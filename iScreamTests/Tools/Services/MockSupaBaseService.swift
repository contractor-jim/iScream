//
//  MockSupaBaseService.swift
//  iScream
//
//  Created by James Woodbridge on 20/10/2025.
//

@testable import iScream
import Supabase

class MockSupaBaseService: SupaBaseService {
    var client: Supabase.SupabaseClient?
}
