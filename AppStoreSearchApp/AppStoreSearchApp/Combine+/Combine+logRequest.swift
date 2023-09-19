//
//  Combine+logRequest.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation
import Combine

extension Publisher where Output == (Data, HTTPURLResponse) {
    func logRequestInfo(of request: URLRequest) -> AnyPublisher<Output, Failure> {
        handleEvents(
            receiveOutput: { data, response in
                request.url.map { Swift.print("URL: -- \($0)") }
                request.httpMethod.map { Swift.print("HTTP Method: -- \($0)") }
                Swift.print("Status Code: -- \(response.statusCode)")
                request.httpBody
                    .map { body in
                        Swift.print("HTTP Body: -- \(String(data: body, encoding: .utf8) ?? "")")
                    }
            
                guard let dataString = String(data: data, encoding: .utf8) else { return }
                
                Swift.print("Response: -- \(dataString)")
            },
            receiveCompletion: { result in
                if case let .failure(error) = result {
                    request.url.map { Swift.print("URL: -- \($0)") }
                    request.httpMethod.map { Swift.print("HTTP Method: -- \($0)") }
                    request.httpBody
                        .map { body in
                            Swift.print("HTTP Body: -- \(String(data: body, encoding: .utf8) ?? "")")
                        }
                    Swift.print("ERROR: -- \(error)")
                }
            }
        )
        .eraseToAnyPublisher()
    }
}
