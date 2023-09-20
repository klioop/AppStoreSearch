//
//  LocalSearchTermLoader+saveIgnoringResult.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import AppStoreSearch

extension LocalSearchTermLoader {
    func saveIgnoringResult(_ searchTerm: LocalSearchTerm) {
        save(searchTerm) {_ in }
    }
}
