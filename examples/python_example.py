"""
Basic usage examples for Code Pruner Skill
"""

from tools.prune_code import prune_code, CodePrunerError

# Example 1: Simple authentication code pruning
print("=" * 60)
print("Example 1: Authentication Logic")
print("=" * 60)

auth_code = """
def authenticate_user(username, password):
    '''Authenticate user credentials'''
    if verify_credentials(username, password):
        return create_session(username)
    return None

def create_session(username):
    '''Create user session'''
    session_id = generate_session_id()
    store_session(session_id, username)
    return session_id

def logout_user(session_id):
    '''Logout user'''
    delete_session(session_id)

def send_welcome_email(username):
    '''Send welcome email to new user'''
    email = get_user_email(username)
    send_email(email, "Welcome!", "Thanks for joining!")

def update_user_profile(username, data):
    '''Update user profile information'''
    validate_profile_data(data)
    save_to_database(username, data)
"""

try:
    result = prune_code(auth_code, "focus on authentication and session management")
    print(f"✅ Relevance Score: {result['score']:.1%}")
    print(f"📊 Reduction: {result['reduction_rate']:.1f}%")
    print(f"📝 Pruned Code:\n{result['pruned_code']}")
except CodePrunerError as e:
    print(f"❌ Error: {e}")

# Example 2: Payment processing
print("\n" + "=" * 60)
print("Example 2: Payment Processing")
print("=" * 60)

payment_code = """
def process_payment(amount, card_info):
    if validate_card(card_info):
        if charge_card(card_info, amount):
            send_receipt(card_info['email'])
            update_inventory()
            return True
    return False

def validate_card(card_info):
    return len(card_info['number']) == 16

def charge_card(card_info, amount):
    # Payment gateway integration
    return True

def send_receipt(email):
    print(f"Receipt sent to {email}")

def update_inventory():
    # Inventory management
    pass

def generate_report():
    # Analytics reporting
    pass
"""

try:
    result = prune_code(payment_code, "payment validation and charging", threshold=0.8)
    print(f"✅ Relevance Score: {result['score']:.1%}")
    print(f"📊 Reduction: {result['reduction_rate']:.1f}%")
    print(f"📝 Pruned Code:\n{result['pruned_code']}")
except CodePrunerError as e:
    print(f"❌ Error: {e}")

# Example 3: Error handling
print("\n" + "=" * 60)
print("Example 3: Error Handling")
print("=" * 60)

try:
    # This will fail - empty code
    result = prune_code("", "test")
except CodePrunerError as e:
    print(f"✅ Caught expected error: {e}")

try:
    # This will fail - service not running (if service is down)
    result = prune_code("def test(): pass", "test")
    print(f"✅ Service is running")
except CodePrunerError as e:
    print(f"⚠️  Service error: {e}")
    print(f"   Start service with: .\\scripts\\start-service.ps1")
