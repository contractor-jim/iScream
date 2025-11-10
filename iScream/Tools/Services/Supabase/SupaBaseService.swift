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

    func fetchArr<T: Codable>(table: String, eq: [String: PostgrestFilterValue], type: T.Type) async throws -> [T]
    func fetch<T: Codable>(table: String, eq: [String: PostgrestFilterValue], type: T.Type) async throws -> T?
    func insert<T: Codable>(table: String, object: T) async throws
    func function<T: Codable>(functionName: String, params: [String: some Encodable & Sendable], object: T.Type) async throws -> [T]

    // User Functions
    func getLoggedInUserId() async throws -> UUID?
    func registerUser(email: String, password: String, nickname: String) async throws -> UUID?
    func loginUser(email: String, password: String) async throws -> UUID
    func insertProfile(profile: Profile) async throws
    func fetchProfile(userId: UUID) async throws -> Profile?
}

class DefaultSupaBaseService: GenericService, SupaBaseService {

    var client: SupabaseClient?

    override init() {
        if ProcessInfo.processInfo.environment["XCTestSessionIdentifier"] == nil {
            client = SupabaseClient(supabaseURL: URL(string: EnvVars.envSupabaseUrl)!, supabaseKey: EnvVars.envSupabaseAuthKey)
        }
        super.init()
    }

    func fetchArr<T: Codable>(table: String, eq: [String: PostgrestFilterValue], type: T.Type) async throws -> [T] {
        let query = client?
          .from(table)
          .select()

        for (key, val) in eq {
            _ = query?.eq(key, value: val)
        }

        let response = try await query?.execute()

        let decoder = JSONDecoder()
        let objects = try decoder.decode([T].self, from: response!.data)

        if objects.count < 0 {
            return []
        }

        return objects
    }

    func fetch<T: Codable>(table: String,
                           eq: [String: PostgrestFilterValue],
                           type: T.Type) async throws -> T? {
        let objects: [T] = try await fetchArr(table: table, eq: eq, type: type)
        if objects.count < 0 {
            return nil
        }

        return objects[0] as T
    }

    func insert<T: Codable>(table: String, object: T) async throws {
        try await client?
            .from(table)
            .insert(object)
            .execute()
    }

    func function<T: Codable>(functionName: String,
                              params: [String: some Encodable & Sendable],
                              object: T.Type) async throws -> [T] {

        do {
            let response = try await client?.rpc(functionName,
                                                 params: params).execute()

            print(">>> RESPONSE \(String(data: response!.data, encoding: .utf8))")
            let decoder = JSONDecoder()
            let objects = try decoder.decode([T].self, from: response!.data)

            if objects.count < 0 {
                return []
            }

            return objects
        } catch {
            return []
        }
    }
}
