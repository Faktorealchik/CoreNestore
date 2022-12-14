//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 04.01.2023.
//

import Foundation

// @available on extension level sufficient as added functions do not match upcoming APIs exactly
@available(iOS, deprecated: 16.0, message: "URLCompatibilityKit is only useful when targeting iOS versions earlier than 16")
@available(macOS, deprecated: 13.0, message: "URLCompatibilityKit is only useful when targeting macOS versions earlier than 13")
@available(tvOS, deprecated: 16.0, message: "URLCompatibilityKit is only useful when targeting tvOS versions earlier than 16")
@available(watchOS, deprecated: 9.0, message: "URLCompatibilityKit is only useful when targeting watchOS versions earlier than 9")
public extension URL {
    /// Appends a path (inferring if it is directory or not) to the receiver.
    mutating func append<S>(path: S) where S: StringProtocol {
        if path.hasSuffix("/") {
            appendPathComponent("\(path)", isDirectory: true)
        } else {
            appendPathComponent("\(path)", isDirectory: false)
        }
    }

    /// Returns a URL constructed by appending the given path (inferring if it is directory or not) to self
    func appending<S>(path: S) -> URL where S: StringProtocol {
        if path.hasSuffix("/") {
            return appendingPathComponent("\(path)", isDirectory: true)
        } else {
            return appendingPathComponent("\(path)", isDirectory: false)
        }
    }
}

// @available on method level needed to avoid "`Ambiguous use of ..." compiler error as added function/property does match upcoming API
public extension URL {
    /// The URL to the program’s current directory.
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static func currentDirectory() -> URL {
        URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }

    #if os(macOS)
        /// Home directory for the specified user.
        @available(iOS, introduced: 11.0, obsoleted: 16.0)
        @available(macOS, introduced: 10.12, obsoleted: 13.0)
        @available(tvOS, introduced: 10.0, obsoleted: 16.0)
        @available(watchOS, introduced: 3.0, obsoleted: 9.0)
        static func homeDirectory(forUser user: String) -> URL? {
            FileManager.default.homeDirectory(forUser: user)
        }
    #endif
}


// @available on method level needed to avoid "`Ambiguous use of ..." compiler error as added function/property does match upcoming API
public extension URL {
    /// Supported applications (/Applications).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var applicationDirectory: URL {
        FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first!
    }

    /// Application support files (Library/Application Support).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var applicationSupportDirectory: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }

    /// Discardable cache files (Library/Caches).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var cachesDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    /// The user’s desktop directory.
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var desktopDirectory: URL {
        FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    }

    /// Document directory.
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    /// The user’s downloads directory.
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var downloadsDirectory: URL {
        FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
    }

    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var homeDirectory: URL {
        URL(fileURLWithPath: NSHomeDirectory())
    }

    /// Various user-visible documentation, support, and configuration files (/Library).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var libraryDirectory: URL {
        FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
    }

    /// The user’s Movies directory (~/Movies).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var moviesDirectory: URL {
        FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
    }

    /// The user’s Music directory (~/Music).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var musicDirectory: URL {
        FileManager.default.urls(for: .musicDirectory, in: .userDomainMask).first!
    }

    /// The user’s Pictures directory (~/Pictures).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var picturesDirectory: URL {
        FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!
    }

    /// The user’s Public sharing directory (~/Public).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var sharedPublicDirectory: URL {
        FileManager.default.urls(for: .sharedPublicDirectory, in: .userDomainMask).first!
    }

    /// The temporary directory for the current user.
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var temporaryDirectory: URL {
        URL(fileURLWithPath: NSTemporaryDirectory())
    }

    #if os(macOS)
        /// The trash directory.
        @available(iOS, introduced: 11.0, obsoleted: 16.0)
        @available(macOS, introduced: 10.12, obsoleted: 13.0)
        @available(tvOS, introduced: 10.0, obsoleted: 16.0)
        @available(watchOS, introduced: 3.0, obsoleted: 9.0)
        static var trashDirectory: URL {
            FileManager.default.urls(for: .trashDirectory, in: .localDomainMask).first!
        }
    #endif

    /// User home directories (/Users).
    @available(iOS, introduced: 11.0, obsoleted: 16.0)
    @available(macOS, introduced: 10.12, obsoleted: 13.0)
    @available(tvOS, introduced: 10.0, obsoleted: 16.0)
    @available(watchOS, introduced: 3.0, obsoleted: 9.0)
    static var userDirectory: URL {
        FileManager.default.urls(for: .userDirectory, in: .localDomainMask).first!
    }
}
