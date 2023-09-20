//
//  LocalSearchTerm+init.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import AppStoreSearch

extension LocalSearchTerm {
    init(from model: SearchTerm) {
        self.init(term: model.term)
    }
}
