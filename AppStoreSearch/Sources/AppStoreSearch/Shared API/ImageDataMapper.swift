//
//  ImageDataMapper.swift
//  AppStoreSearch
//
//  Created by Lee Sam on 2023/09/19.
//

import Foundation

public class ImageDataMapper {
    private init() {}
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard
            !data.isEmpty,
            response.statusCode == 200
        else { throw Error.invalidData }
        
        return data
    }
}
