*** Variables ***
# URLs
${URL}                    https://demowebshop.tricentis.com/

# Browser Configuration
${BROWSER}                chrome
${DEFAULT_TIMEOUT}        10s

# Test Data
${FIRST_NAME}             Test
${LAST_NAME}              User
${EMAIL}                  test.user${EMPTY}@example.com
${PASSWORD}               Test123!
${VALID_EMAIL}            your.registered@email.com  # Replace with a valid registered email
${VALID_PASSWORD}         yourpassword              # Replace with the actual password

# Locators
# Header
${REGISTER_LINK}          link:Register
${LOGIN_LINK}             link:Log in
${LOGOUT_LINK}            link:Log out
${ACCOUNT_EMAIL}          css:.account
${SHOPPING_CART_LINK}     link:Shopping cart

# Login Page
${EMAIL_FIELD}            id:Email
${PASSWORD_FIELD}         id:Password
${LOGIN_BUTTON}           css:.login-button

# Registration Page
${REGISTER_BUTTON}        id:register-button

# Product Page
${ADD_TO_CART_BUTTON}     id:add-to-cart-button-1

# Shopping Cart
${TERMS_CHECKBOX}         id:termsofservice
${CHECKOUT_BUTTON}        id:checkout

# Checkout Process
${BILLING_ADDRESS_FORM}   id:billing-address-select
${SHIPPING_METHOD}        id:shipping-method-buttons-container
${PAYMENT_METHOD}         id:payment-method-buttons-container
${PAYMENT_INFO}           id:payment-info-buttons-container
${CONFIRM_ORDER}          id:confirm-order-buttons-container

# Order Confirmation
${ORDER_SUCCESS_MESSAGE}  css:.order-completed

# Error Messages
${ERROR_MESSAGE}          css:.validation-summary-errors

# Categories
${COMPUTERS_CATEGORY}     link:Computers
${DESKTOPS_SUBCATEGORY}   link:Desktops
${NOTEBOOKS_SUBCATEGORY}  link:Notebooks
${ACCESSORIES_SUBCATEGORY}  link:Accessories
