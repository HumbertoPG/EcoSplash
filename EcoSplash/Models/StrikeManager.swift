//
//  StrikeManager.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

class StrikeManager:ObservableObject {
    
    @Published var strikes: Int {
        didSet {
            UserDefaults.standard.set(strikes, forKey: "strikes")
        }
    }
    
    init() {
        self.strikes = UserDefaults.standard.integer(forKey: "strikes")
    }
    
    func addStrike() {
        strikes += 1
    }
    
    func resetStrikes() {
        strikes = 0
    }
    
}
