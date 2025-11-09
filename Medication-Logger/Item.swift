//
//  Item.swift
//  Medication-Logger
//
//  Created by Carlo André Aguilar on 9/11/25.
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
