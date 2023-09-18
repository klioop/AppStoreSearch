//
//  XCTest+trackMemory.swift
//  AppStoreSearchAppTests
//
//  Created by Lee Sam on 2023/09/18.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeak(_ instance: AnyObject, file: StaticString, line: UInt) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "테스트가 끝난 후 객체는 메모리에서 해제되어야 한다. 이 에러는 메모리 릭을 암시",
                file: file,
                line: line
            )
        }
    }
}
