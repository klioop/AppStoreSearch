//
//  Combine+LocalSearchTermLoader.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/18.
//

import Foundation
import Combine
import AppStoreSearch

extension LocalSearchTermLoader {
    func loadPublisher() -> AnyPublisher<[SearchTerm], Error> {
        Deferred {
            Future(self.load)
        }
        .eraseToAnyPublisher()
    }
}

extension LocalSearchTermLoader {
    func loadPublisher(containing term: SearchTerm) -> AnyPublisher<[SearchTerm], Error> {
        Deferred {
            Future { completion in
                self.load(containing: term, completion: completion)
            }
        }
        .eraseToAnyPublisher()
    }
}
