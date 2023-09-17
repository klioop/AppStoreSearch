//
//  AppStoreSearchAPIEndToEndTests.swift
//  AppStoreSearchAPIEndToEndTests
//
//  Created by Lee Sam on 2023/09/17.
//

import XCTest
import AppStoreSearch

final class AppStoreSearchAPIEndToEndTests: XCTestCase {
    
    func test_getSearchAppsEndToEnd() {
        Task {
            do {
                let apps = try await getSearchApps()
                XCTAssertFalse(apps.isEmpty, "API 통신에 성공한 결과는 빈 값이 아니다")
            } catch {
                XCTFail("API 통신은 실패하면 안된다")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func getSearchApps() async throws -> [App] {
        let request = URLRequest(url: AppStoreSearchEndPoint.get("카카오뱅크").url())
        let (data, response) = try await client().perform(request)
        XCTAssertEqual(response.statusCode, 200)
        return try AppMapper.map(data, from: response)
    }
    
    private func client(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        URLSessionHTTPClient(session: .shared)
    }
}
