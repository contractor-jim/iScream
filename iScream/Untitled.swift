//
//  Untitled.swift
//  iScream
//
//  Created by james Woodbridge on 05/09/2025.
//

run: |


    

    # create keychain
    security create-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH
    security set-keychain-settings -lut 21600 $KEYCHAIN_PATH
    security unlock-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH

    # import certificates into keychain
    security import $CERTIFICATE_PATH -P "$P12_PASSWORD" -A -t cert -f pkcs12 -k $KEYCHAIN_PATH
    security set-key-partition-list -S apple-tool:,apple: -k "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH
    security list-keychain -d user -s $KEYCHAIN_PATH

    # import provisioning profile
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    cp $PP_PATH ~/Library/MobileDevice/Provisioning\ Profiles
    security find-identity -p codesigning -v
    security cms -D -i ~/Library/MobileDevice/Provisioning\ Profiles/build_pp.mobileprovision
- name: Build and Test
run: |
  xcodebuild clean test -project iScream.xcodeproj -scheme "iScream" -configuration Staging -destination 'platform=iOS Simulator,name=iPhone 16'
