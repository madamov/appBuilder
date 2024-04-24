#!/bin/bash

echo Creating keychain

# create variables
CERTIFICATE_PATH=$HOME/Documents/cert/for4D.p12
KEYCHAIN_PATH=$HOME/Documents/build.keychain
KEYCHAIN_PASSWORD=Sr11Ma26
CERTIFICATE_PASSWORD=Sr11Ma26
IDENTITY_CERTIFICATE = "Common name from $CERTIFICATE_PATH"

# import certificate from secrets
base64 --decode -o "$CERTIFICATE_PATH" -i $HOME/Documents/cert/for4D.base64

# create temporary keychain
security create-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"

# Append temp keychain to the user domain
security list-keychains -d user -s "$KEYCHAIN_PATH" $(security list-keychains -d user | sed s/\"//g)

security set-keychain-settings -lut 21600 "$KEYCHAIN_PATH"

security unlock-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"

# import certificate to keychain
security import "$CERTIFICATE_PATH" -A -k "$KEYCHAIN_PATH" -P "$CERTIFICATE_PASSWORD"

# Enable codesigning from a non user interactive shell
# security set-key-partition-list -S apple-tool:,apple:, -s -k $KEYCHAIN_PASSWORD -D "${IDENTITY_CERTIFICATE}" -t private $KEYCHAIN_PATH
security set-key-partition-list -S "apple-tool:,apple:" -s -k "${KEYCHAIN_PASSWORD}" "${KEYCHAIN_PATH}"

# set the new keychain as the default keychain for the user
security default-keychain -d "user" -s "${KEYCHAIN_PATH}"
