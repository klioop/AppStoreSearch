//
//  AppStoreSearchAPIEndToEndTests.swift
//  AppStoreSearchAPIEndToEndTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

final class AppStoreSearchAPIEndToEndTests: XCTestCase {
    
    func test_getSearchAppsEndToEnd() async {
        do {
            let apps = try await getSearchApps()
            XCTAssertFalse(apps.isEmpty, "API 통신에 성공한 결과, 값을 반환한다")
        } catch {
            XCTFail("API 통신은 실패하면 안된다")
        }
    }
    
    // MARK: - Helpers
    
    private func getSearchApps() async throws -> [App] {
        let search = SearchTerm(term: "카카오")
        let request = URLRequest(url: AppStoreSearchEndPoint.get(search).url())
        let (data, response) = try await client().perform(request)
        XCTAssertEqual(response.statusCode, 200)
        return try AppMapper.map(data, from: response)
    }
    
    private func client() -> HTTPClient {
        URLSessionHTTPClient(session: .shared)
    }
}
