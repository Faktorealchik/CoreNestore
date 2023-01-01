//
//  BenchTimer.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 31.12.2022.
//

import CoreFoundation

public class BenchTimer {
    let startTime: CFAbsoluteTime
    var endTime: CFAbsoluteTime?

    public init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    public func stop() -> CFAbsoluteTime {
        if endTime == nil {
            endTime = CFAbsoluteTimeGetCurrent()
        }

        return duration!
    }

    var duration: CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
