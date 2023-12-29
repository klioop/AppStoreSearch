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
        
        guard !match(snapshotData, storedSnapshotData, tolerance: 0.1) else { return }
        
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
    
    private func makeSnapshotURL(name: String, file: StaticString) -> URL {
        URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots", isDirectory: true)
            .appendingPathComponent("\(name).png")
    }
    
    private func match(_ oldData: Data, _ newData: Data, tolerance: Float = 0) -> Bool {
        if oldData == newData { return true }
        
        guard
            let oldImage = UIImage(data: oldData)?.cgImage,
            let newImage = UIImage(data: newData)?.cgImage
        else { return false }
        
        guard
            oldImage.width == newImage.width,
            oldImage.height == newImage.height
        else { return false }
        
        let minBytesPerRow = min(oldImage.bytesPerRow, newImage.bytesPerRow)
        let bytesCount = minBytesPerRow * oldImage.height
        
        var oldImageByteBuffer = [UInt8](repeating: 0, count: bytesCount)
        guard let oldImageData = data(for: oldImage, bytesPerRow: minBytesPerRow, buffer: &oldImageByteBuffer) else {
            return false
        }
        
        var newImageByteBuffer = [UInt8](repeating: 0, count: bytesCount)
        guard let newImageData = data(for: newImage, bytesPerRow: minBytesPerRow, buffer: &newImageByteBuffer) else {
            return false
        }
        
        if memcmp(oldImageData, newImageData, bytesCount) == 0 { return true }
        
        return match(oldImageByteBuffer, newImageByteBuffer, tolerance: tolerance, bytesCount: bytesCount)
    }
    
    private func data(for image: CGImage, bytesPerRow: Int, buffer: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer? {
        guard
            let space = image.colorSpace,
            let context = CGContext(
                data: buffer,
                width: image.width,
                height: image.height,
                bitsPerComponent: image.bitsPerComponent,
                bytesPerRow: bytesPerRow,
                space: space,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
        else { return nil }
        
        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        return context.data
    }
    
    private func match(_ bytes1: [UInt8], _ bytes2: [UInt8], tolerance: Float, bytesCount: Int) -> Bool {
        var differentBytesCount = 0
        for i in 0 ..< bytesCount where bytes1[i] != bytes2[i] {
            differentBytesCount += 1
        }
        
        let percentage = Float(differentBytesCount) / Float(bytesCount)
        if percentage > tolerance {
            return false
        }
        
        return true
    }
}
