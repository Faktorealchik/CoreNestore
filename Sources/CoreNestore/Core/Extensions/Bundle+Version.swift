//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 16.09.2022.
//

import UIKit

public extension Bundle {
    var version: String {
        guard let num = releaseVersionNumber, let build = buildVersionNumber else { return "" }
        return "\(num)(\(build))"
    }
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
