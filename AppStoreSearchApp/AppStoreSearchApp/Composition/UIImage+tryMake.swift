//
//  UIImage+tryMake.swift
//  AppStoreSearchApp
//
//  Created by Lee Sam on 2023/09/19.
//

import UIKit

extension UIImage {
    static func tryMake(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else { throw InvalidImageDataRepresentation() }
        return image
    }
}

struct InvalidImageDataRepresentation: Error {}
