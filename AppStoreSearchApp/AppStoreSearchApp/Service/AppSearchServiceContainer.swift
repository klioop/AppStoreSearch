//
//  AppSearchServiceContainer.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import Foundation
import Combine
import AppStoreSearch

final class AppSearchServiceContainer {
    private lazy var store: SearchTermStore = try! UserDefaultsSearchTermStore(suiteName: "klioop.AppStoreSearchTermStore")
    private lazy var localSearchTermsLoader = LocalSearchTermLoader(store: store)
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func recentSearchTermsLoader() -> AnyPublisher<[SearchTerm], Error> {
        localSearchTermsLoader.loadPublisher()
    }
    
    func matchedSearchTermsLoader(containing searchTerm: SearchTerm) -> AnyPublisher<[SearchTerm], Error> {
        localSearchTermsLoader.loadPublisher(containing: searchTerm)
    }
    
    func appsLoader(for searchTerm: SearchTerm) -> AnyPublisher<[App], Error> {
        let request = URLRequest(url: AppStoreSearchEndPoint.get(searchTerm).url())
        return httpClient
            .performPublisher(request)
            .logRequestInfo(of: request)
            .tryMap(AppMapper.map)
            .eraseToAnyPublisher()
    }
    
    func save(_ searchTerm: SearchTerm) {
        localSearchTermsLoader.saveIgnoringResult(LocalSearchTerm(from: searchTerm))
    }
}
