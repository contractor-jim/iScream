//
//  MockSupabaseService.swift
//  iScream
//
//  Created by James Woodbridge on 14/10/2025.
//

@testable import iScream
import Supabase

class MockSupaBaseService: GenericService, SupaBaseService {
    var client: Supabase.SupabaseClient?
}
