//
//  AppStoreSearchEndPoint.swift
//  AppStoreSearchiOS
//
//  Created by Lee Sam on 2023/09/17.
//

import Foundation

public enum AppStoreSearchEndPoint {
    case get(_ searchTerm: SearchTerm)
    
    private enum DefaultQueries: String, CaseIterable {
        case country, lang, media, limit
        
        var value: String {
            switch self {
            case .country: "kr"
                
            case .lang: "ko-kr"
                
            case .media: "software"
                
            case .limit: "20"
            }
        }
    }
    
    public func url() -> URL {
        let baseURL = URL(string: "https://itunes.apple.com")!
        
        switch self {
        case let .get(term):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = path
            let baseQueries = DefaultQueries.allCases.map {
                URLQueryItem(name: $0.rawValue, value: $0.value)
            }
            components.queryItems = baseQueries + [URLQueryItem(name: "term", value: term.term)]
            return components.url!
        }
    }
    
    private var path: String { "/search" }
}
