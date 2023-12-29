//
//  AppStoreSearchEndPointTests.swift
//  AppStoreSearchiOSTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

class AppStoreSearchEndPointTests: XCTestCase {
    
    func test_appStoreSearch_endPoint() {
        let term = "a search"
        let urlEncoded = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = AppStoreSearchEndPoint.get(SearchTerm(term: term)).url()
        
        XCTAssertEqual(url.scheme, "https")
        XCTAssertEqual(url.host, "itunes.apple.com")
        XCTAssertEqual(url.path, "/search")
        XCTAssertEqual(url.query?.contains("lang=ko-kr"), true)
        XCTAssertEqual(url.query?.contains("country=kr"), true)
        XCTAssertEqual(url.query?.contains("media=software"), true)
        XCTAssertEqual(url.query?.contains("limit=20"), true)
        XCTAssertEqual(url.query?.contains("term=\(urlEncoded!)"), true)
    }
}
