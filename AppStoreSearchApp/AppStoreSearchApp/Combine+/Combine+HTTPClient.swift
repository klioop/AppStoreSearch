//
//  Combine+HTTPClient.swift
//  EssentialApp
//
//  Created by klioop on 2022/08/23.
//

import Foundation
import Combine
import AppStoreSearch

public extension HTTPClient {
    typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
    
    func performPublisher(_ request: URLRequest) -> Publisher {
        let task = Task {
            do {
                return try await perform(request)
            } catch {
                throw error
            }
        }
        return Deferred {
            Future { completion in
                Task {
                    completion(await task.result)
                }
            }
        }
        .handleEvents(receiveCancel: { task.cancel() })
        .eraseToAnyPublisher()
    }
}
