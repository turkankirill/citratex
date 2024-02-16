//
//  Item.swift
//  LineBlock
//
//  Created by ADMIN on 11.02.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
