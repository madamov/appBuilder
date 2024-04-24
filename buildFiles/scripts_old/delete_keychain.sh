security delete-keychain "$KEYCHAIN_PATH"

# default again to user login keychain
security list-keychains -d user -s login.keychain

echo keychain deleted
