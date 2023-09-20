//
//  Apps+ImageDataLoaderSpy.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 2023/09/20.
//

import Foundation
import Combine
import AppStoreSearch

class AppsLoaderSpy {
    private var appsRequests: [PassthroughSubject<[App], Error>] = []
    
    func loadPublisher(for searchTerm: SearchTerm) -> AnyPublisher<[App], Error> {
        let subject = PassthroughSubject<[App], Error>()
        appsRequests.append(subject)
        return subject.eraseToAnyPublisher()
    }
    
    func loadComplete(with apps: [App], at index: Int = 0) {
        appsRequests[index].send(apps)
        appsRequests[index].send(completion: .finished)
    }
    
    // MARK: - Image Data Loader Spy
    
    private var imageRequests: [(url: URL, subject: PassthroughSubject<Data, Error>)] = []
    private(set) var cancelImageURLs: [URL] = []
    
    var requestedURLs: [URL] {
        imageRequests.map(\.url)
    }
    
    func loadImageData(from url: URL) -> AnyPublisher<Data, Error> {
        let subject = PassthroughSubject<Data, Error>()
        imageRequests.append((url, subject))
        return subject
            .handleEvents(receiveCancel: { [weak self] in
                self?.cancelImageURLs.append(url)
            })
            .eraseToAnyPublisher()
            
    }
    
    func loadCompleteImage(with data: Data, at index: Int = 0) {
        imageRequests[index].subject.send(data)
        imageRequests[index].subject.send(completion: .finished)
    }
}
