//
//  Untitled.swift
//  iScream
//
//  Created by james Woodbridge on 05/09/2025.
//

run: |


    

    # import provisioning profile
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    cp $PP_PATH ~/Library/MobileDevice/Provisioning\ Profiles
    security find-identity -p codesigning -v
    security cms -D -i ~/Library/MobileDevice/Provisioning\ Profiles/build_pp.mobileprovision
- name: Build and Test
run: |
  xcodebuild clean test -project iScream.xcodeproj -scheme "iScream" -configuration Staging -destination 'platform=iOS Simulator,name=iPhone 16'
