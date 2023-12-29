//
//  XCTestCase+SnapshotHelpers.swift
//  TeuidaTests
//
//  Created by Lee Sam on 2022/11/17.
//  Copyright © 2022 Teuida. All rights reserved.
//

import XCTest

extension XCTestCase {
    func assert(_ snapshot: UIImage, named name: String, file: StaticString = #filePath, line: UInt = #line) {
        let snapshotURL = makeSnapshotURL(name: name, file: file)
        
        guard let snapshotData = snapshot.pngData() else {
            return XCTFail("Failed to generate PNG representation from snapshot", file: file, line: line)
        }
        
        guard let storedSnapshotData = try? Data(contentsOf: snapshotURL) else {
            return XCTFail("Failed to load store snapshot at URL: \(snapshotURL). Use `record` method first to take snapshot")
        }
        
        let temporarySnapshotURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            .appendingPathComponent(snapshotURL.lastPathComponent)
        
        try? snapshotData.write(to: temporarySnapshotURL)
        
        guard snapshotData == storedSnapshotData else {
            return XCTFail("New snapshot does not match stored snapshot. New snapshot at \(temporarySnapshotURL). Stored snapshot at \(snapshotURL)", file: file, line: line)
        }
    }
    
    func record(_ snapshot: UIImage, named name: String, file: StaticString = #filePath, line: UInt = #line) {
        let snapshotURL = makeSnapshotURL(name: name, file: file)
        
        guard let snapshotData = snapshot.pngData() else {
            return XCTFail("Failed to generate PNG representation from snapshot", file: file, line: line)
        }
        
        do {
            try FileManager.default.createDirectory(at: snapshotURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            
            try snapshotData.write(to: snapshotURL)
            XCTFail("Record succeeded - use `assert` to compare the snapshot from now on.", file: file, line: line)
        } catch {
            XCTFail("Failed to record snapshot at this URL: \(snapshotURL)", file: file, line: line)
        }
    }
    
    func makeSnapshotURL(name: String, file: StaticString) -> URL {
        URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots", isDirectory: true)
            .appendingPathComponent("\(name).png")
    }
}
