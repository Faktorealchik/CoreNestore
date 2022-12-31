//
//  Units.swift
//  Calx
//
//  Created by Aleksandr Nesterov on 13.03.2021.
//  Copyright © 2021 Alexandr Nesterov. All rights reserved.
//

import Foundation

public struct Units {
    
    public let bytes: Int64
    private let isBinary: Bool
    
    public var kilobytes: Double {
        return Double(bytes) / number
    }
    
    public var megabytes: Double {
        return kilobytes / number
    }
    
    public var gigabytes: Double {
        return megabytes / number
    }
    
    public var number: Double {
        if isBinary {
            return 1024
        } else {
            return 1000
        }
    }
    
    public var numberAsInt: Int64 {
        Int64(number)
    }
    
    public init(bytes: Int64, isBinary: Bool = true) {
        self.bytes = bytes
        self.isBinary = isBinary
    }
    
    public func getReadableUnit() -> String {
        switch bytes {
        case 0..<numberAsInt:
            return "\(bytes) bytes"
        case numberAsInt..<(numberAsInt * numberAsInt):
            return "\(String(format: "%.2f", kilobytes)) KB"
        case numberAsInt..<(numberAsInt * numberAsInt * numberAsInt):
            return "\(String(format: "%.2f", megabytes)) MB"
        case (numberAsInt * numberAsInt * numberAsInt)...Int64.max:
            return "\(String(format: "%.2f", gigabytes)) GB"
        default:
            return "\(bytes) bytes"
        }
    }
}
