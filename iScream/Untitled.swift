//
//  Untitled.swift
//  iScream
//
//  Created by james Woodbridge on 05/09/2025.
//

run: |

- name: Build and Test
run: |
  xcodebuild clean test -project iScream.xcodeproj -scheme "iScream" -configuration Staging -destination 'platform=iOS Simulator,name=iPhone 16'
