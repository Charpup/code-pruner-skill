#!/usr/bin/env python3
"""
Code Pruner Tool - Python wrapper for SWE-Pruner API

This tool provides a simple interface to the locally-deployed SWE-Pruner service
for intelligent code context pruning.
"""

import requests
import json
from typing import Dict, Optional
import sys


class CodePrunerError(Exception):
    """Custom exception for code pruner errors"""
    pass


def prune_code(
    code: str,
    query: str,
    threshold: float = 0.7,
    service_url: str = "http://localhost:8000/prune",
    timeout: int = 30
) -> Dict:
    """
    Prune code based on relevance to query.
    
    Args:
        code: Source code to prune
        query: Focus query (e.g., "authentication logic")
        threshold: Relevance threshold (0.0-1.0), default 0.7
        service_url: SWE-Pruner service endpoint
        timeout: Request timeout in seconds
    
    Returns:
        dict: {
            'score': float,           # Relevance score
            'pruned_code': str,       # Pruned code
            'original_size': int,     # Original character count
            'pruned_size': int,       # Pruned character count
            'reduction_rate': float   # Percentage reduced
        }
    
    Raises:
        CodePrunerError: If service is unavailable or request fails
    """
    if not code or not code.strip():
        raise CodePrunerError("Code cannot be empty")
    
    if not query or not query.strip():
        raise CodePrunerError("Query cannot be empty")
    
    if not 0.0 <= threshold <= 1.0:
        raise CodePrunerError("Threshold must be between 0.0 and 1.0")
    
    try:
        # Prepare request
        payload = {
            "code": code,
            "query": query,
            "threshold": threshold
        }
        
        # Make API call
        response = requests.post(
            service_url,
            json=payload,
            timeout=timeout,
            headers={"Content-Type": "application/json"}
        )
        
        # Check response
        response.raise_for_status()
        result = response.json()
        
        # Calculate metrics
        original_size = len(code)
        pruned_size = len(result.get('pruned_code', ''))
        reduction_rate = ((original_size - pruned_size) / original_size * 100) if original_size > 0 else 0.0
        
        return {
            'score': result.get('score', 0.0),
            'pruned_code': result.get('pruned_code', ''),
            'original_size': original_size,
            'pruned_size': pruned_size,
            'reduction_rate': round(reduction_rate, 2)
        }
        
    except requests.exceptions.ConnectionError:
        raise CodePrunerError(
            "Cannot connect to SWE-Pruner service. "
            "Please ensure the service is running on http://localhost:8000"
        )
    except requests.exceptions.Timeout:
        raise CodePrunerError(f"Request timed out after {timeout} seconds")
    except requests.exceptions.HTTPError as e:
        raise CodePrunerError(f"HTTP error: {e}")
    except json.JSONDecodeError:
        raise CodePrunerError("Invalid JSON response from service")
    except Exception as e:
        raise CodePrunerError(f"Unexpected error: {e}")


def check_service_health(service_url: str = "http://localhost:8000") -> bool:
    """
    Check if SWE-Pruner service is available.
    
    Args:
        service_url: Base URL of the service
    
    Returns:
        bool: True if service is healthy, False otherwise
    """
    try:
        response = requests.get(service_url, timeout=5)
        return response.status_code == 200
    except:
        return False


def main():
    """CLI interface for testing"""
    if len(sys.argv) < 3:
        print("Usage: python prune_code.py <code_file> <query>")
        print("Example: python prune_code.py app.py 'authentication logic'")
        sys.exit(1)
    
    code_file = sys.argv[1]
    query = sys.argv[2]
    threshold = float(sys.argv[3]) if len(sys.argv) > 3 else 0.7
    
    try:
        # Read code file
        with open(code_file, 'r', encoding='utf-8') as f:
            code = f.read()
        
        # Check service
        if not check_service_health():
            print("❌ SWE-Pruner service is not running")
            print("   Start it with: .\\scripts\\start-service.ps1")
            sys.exit(1)
        
        # Prune code
        print(f"🔍 Pruning code with query: '{query}'")
        result = prune_code(code, query, threshold)
        
        # Display results
        print(f"\n✅ Pruning complete!")
        print(f"   Relevance Score: {result['score']:.1%}")
        print(f"   Original Size: {result['original_size']:,} chars")
        print(f"   Pruned Size: {result['pruned_size']:,} chars")
        print(f"   Reduction: {result['reduction_rate']:.1f}%")
        print(f"\n📝 Pruned Code:\n")
        print(result['pruned_code'])
        
    except FileNotFoundError:
        print(f"❌ File not found: {code_file}")
        sys.exit(1)
    except CodePrunerError as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
