//
//  URL+Extensions.swift
//  Private
//
//  Created by Aleksandr Nesterov on 16.12.2022.
//

// swiftlint:disable redundant_optional_initialization

import Foundation

public struct URLFileAttribute {
    public var fileSize: UInt? = nil
    public var creationDate: Date? = nil
    public var modificationDate: Date? = nil
    
    public init(url: URL) {
        let path = url.path
        guard let dictionary: [FileAttributeKey: Any] = try? FileManager.default
            .attributesOfItem(atPath: path) else {
            return
        }
        
        if dictionary.keys.contains(FileAttributeKey.size),
           let value = dictionary[FileAttributeKey.size] as? UInt {
            self.fileSize = value
        }
        
        if dictionary.keys.contains(FileAttributeKey.creationDate),
           let value = dictionary[FileAttributeKey.creationDate] as? Date {
            self.creationDate = value
        }
        
        if dictionary.keys.contains(FileAttributeKey.modificationDate),
           let value = dictionary[FileAttributeKey.modificationDate] as? Date {
            self.modificationDate = value
        }
    }
}

public extension URL {
    func directoryContents() throws -> [URL] {
        let directoryContents = try FileManager.default.contentsOfDirectory(
            at: self,
            includingPropertiesForKeys: nil)
        return directoryContents
    }
    
    func folderSize() throws -> UInt {
        let contents = try directoryContents()
        var totalSize: UInt = 0
        contents.forEach { url in
            let size = url.fileSize()
            totalSize += size
        }
        return totalSize
    }
    
    func fileSize() -> UInt {
        let attributes = URLFileAttribute(url: self)
        return attributes.fileSize ?? 0
    }
}
