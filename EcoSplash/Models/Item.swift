//
//  Item.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

struct Item: Identifiable, Codable, Equatable {
    let id: Int
    let itemImageName: String
    let frameImageName: String
    let price: Int
    let description: String
    var isUnlocked: Bool = false
    var isEquipped: Bool = false
}
