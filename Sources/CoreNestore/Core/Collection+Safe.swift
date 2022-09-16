//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 16.09.2022.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
