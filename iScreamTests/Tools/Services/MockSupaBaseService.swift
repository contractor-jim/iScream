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

    func fetch<T>(table: String, eq: [String: any PostgrestFilterValue], type: T.Type) async throws -> T? where T: Decodable, T: Encodable {
        return nil
    }

    func insert<T>(table: String, object: T) async throws where T: Decodable, T: Encodable { }

    func fetchArr<T>(table: String, eq: [String: any PostgREST.PostgrestFilterValue], type: T.Type) async throws -> [T] where T: Decodable, T: Encodable {
        return []
    }

    func function<T>(functionName: String, params: [String: some Encodable & Sendable], object: T.Type) async throws -> [T] where T: Decodable, T: Encodable {
        return []
    }
}
