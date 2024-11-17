//
//  Achievement.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 03/11/24.
//

import Foundation

struct Achievement: Identifiable, Codable {
    var id: UUID = UUID()
    let imageName: String
    let description: String
    let goal: Int
    var progress: Int
    var obtained: Bool
}
