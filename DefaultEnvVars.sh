#!/bin/bash
touch iScream/Environment/EnvVars.swift
cat >iScream/Environment/EnvVars.swift <<EOL
import Foundation

struct EnvVars {
    static let envSupabaseUrl = ""
    static let envSupabaseAuthKey = ""
}
EOL

cat iScream/Environment/EnvVars.swift
