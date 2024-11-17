//
//  CoinManager.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

class CoinManager:ObservableObject {
    
    @Published var coins: Int {
        didSet {
            UserDefaults.standard.set(coins, forKey: "coins")
        }
    }
    
    init() {
        self.coins = UserDefaults.standard.integer(forKey: "coins")
    }
    
    func addCoins(_ amount: Int) {
        coins += amount
    }
    
    func substractCoins(_ amount: Int) {
        coins -= amount
    }
    
}
