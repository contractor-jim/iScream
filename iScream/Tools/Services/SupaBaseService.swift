//
//  SupaBaseService.swift
//  iScream
//
//  Created by James Woodbridge on 09/10/2025.
//

import Supabase
import Foundation

protocol SupaBaseService { }

class DefaultSupaBaseService: GenericService, SupaBaseService {

    override init() {
        super.init()
        let client = SupabaseClient(supabaseURL: URL(string: "TODO:")!, supabaseKey: "publishable-or-anon-key")
    }
}
