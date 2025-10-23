//
//  MockSupaBaseService.swift
//  iScream
//
//  Created by James Woodbridge on 20/10/2025.
//

@testable import iScream
import Supabase

class MockSupaBaseService: SupaBaseService {
    func fetch<T>(table: String, eq: [String : any PostgREST.PostgrestFilterValue], type: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        return nil
    }

    func insert<T>(table: String, object: T) async throws where T:Decodable, T: Encodable { }

    var client: Supabase.SupabaseClient?
}
