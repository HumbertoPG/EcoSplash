//
//  Statistics.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

class Statistics:ObservableObject {
    
    @Published var totalShowers: Int {
        didSet {
            UserDefaults.standard.set(totalShowers, forKey: "totalShowers")
        }
    }
    
    @Published var totalShortShowers: Int {
        didSet {
            UserDefaults.standard.set(totalShortShowers, forKey: "totalShortShowers")
        }
    }
    
    @Published var totalSavedLiters: Double {
        didSet {
            UserDefaults.standard.set(totalSavedLiters, forKey: "totalSavedLiters")
        }
    }
    
    init() {
        self.totalShowers = UserDefaults.standard.integer(forKey: "totalShowers")
        self.totalShortShowers = UserDefaults.standard.integer(forKey: "totalShortShowers")
        self.totalSavedLiters = UserDefaults.standard.double(forKey: "totalSavedLiters")
    }
    
    
}
