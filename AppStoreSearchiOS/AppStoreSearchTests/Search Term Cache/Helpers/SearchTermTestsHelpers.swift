//
//  SearchTermTestsHelpers.swift
//  AppStoreSearchTests
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation
import AppStoreSearch

func makeLocalTerm(term: String = "a term") -> LocalSearchTerm {
    LocalSearchTerm(term: term)
}

func anyError() -> NSError {
    NSError(domain: "a error", code: 0)
}
