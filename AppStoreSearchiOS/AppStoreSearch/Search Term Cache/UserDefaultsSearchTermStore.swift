//
//  UserDefaultsSearchTermStore.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public final class UserDefaultsSearchTermStore: SearchTermStore {
    private let key = "SearchTerms.klioop"
    private let defaults: UserDefaults
    
    public init(suiteName: String) throws {
        guard
            let defaults = UserDefaults(suiteName: suiteName)
        else { throw FailureToCreateUserDefaultsInstance() }
        
        self.defaults = defaults
    }
    
    public func insert(_ term: LocalSearchTerm, completion: @escaping (InsertionResult) -> Void) {
        guard !(terms().contains { $0 == term.term }) else { return }
    }
    
    public func retrieve(completion: @escaping (RetrievalResult) -> Void) {
        completion(.success(terms().map(LocalSearchTerm.init)))
    }
    
    // MARK: - Helpers
    
    private func terms() -> [String] {
        defaults.stringArray(forKey: key) ?? []
    }
}
 
struct FailureToCreateUserDefaultsInstance: Error {}
