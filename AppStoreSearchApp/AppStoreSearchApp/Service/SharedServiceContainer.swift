//
//  SharedServiceContainer.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 12/13/23.
//

import Foundation
import Combine
import AppStoreSearch

final class SharedServiceContainer {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func imageDataLoader(from url: URL) -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: url)
        return httpClient
            .performPublisher(request)
            .tryMap(ImageDataMapper.map)
            .eraseToAnyPublisher()
    }
}
