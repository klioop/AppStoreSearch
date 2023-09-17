//
//  HTTPClient.swift
//  Teuida
//
//  Created by Lee Sam on 2022/11/29.
//  Copyright © 2022 Teuida. All rights reserved.
//

import Foundation


public protocol HTTPClient {
    func perform(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
