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
        completion(
            InsertionResult {
                guard isNotExist(term) else { return }
                
                cache(terms() + [term.term])
            }
        )
    }
    
    public func retrieve(completion: @escaping (RetrievalResult) -> Void) {
        let terms = terms().map(LocalSearchTerm.init)
        completion(.success(terms))
    }
    
    // MARK: - Helpers
    
    private func cache(_ terms: [String]) {
        defaults.set(terms, forKey: key)
    }
    
    private func isNotExist(_ term: LocalSearchTerm) -> Bool {
        !terms().contains { $0 == term.term }
    }
    
    private func terms() -> [String] {
        defaults.stringArray(forKey: key) ?? []
    }
}
 
struct FailureToCreateUserDefaultsInstance: Error {}
