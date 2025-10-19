//
//  SupaBaseService.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import Supabase
import Foundation

protocol SupaBaseService {
    var client: SupabaseClient? { get }
}

class DefaultSupaBaseService: GenericService, SupaBaseService {

    var client: SupabaseClient?

    override init() {
        if ProcessInfo.processInfo.environment["XCTestSessionIdentifier"] == nil {
            client = SupabaseClient(supabaseURL: URL(string: EnvVars.envSupabaseUrl)!, supabaseKey: EnvVars.envSupabaseAuthKey)
        }
        super.init()
    }
}
