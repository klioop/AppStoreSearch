//
//  URLSessionHTTPClient.swift
//
//  Created by Lee Sam on 2022/11/29.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func perform(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        async let (data, urlResponse) = try session.data(for: request)
        
        do {
            guard
                let response = try await urlResponse as? HTTPURLResponse
            else { throw UnexpectedValuesRepresentation() }
            
            return try await (data, response)
        } catch {
            throw error
        }
    }
}
