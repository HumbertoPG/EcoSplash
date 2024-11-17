//
//  LevelManager.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

class LevelManager:ObservableObject {
    
    @Published var currentLevel: Int {
        didSet {
            UserDefaults.standard.set(currentLevel, forKey: "level")
        }
    }
    @Published var currentExperience: Int {
        didSet {
            UserDefaults.standard.set(currentExperience, forKey: "currentExperience")
        }
    }
    @Published var experienceToNextLevel: Int {
        didSet {
            UserDefaults.standard.set(experienceToNextLevel, forKey: "experienceToNextLevel")
        }
    }
    
    init() {
        let savedLevel = UserDefaults.standard.integer(forKey: "level")
        self.currentLevel = savedLevel > 0 ? savedLevel : 1
        self.currentExperience = UserDefaults.standard.integer(forKey: "currentExperience")
        self.experienceToNextLevel = UserDefaults.standard.integer(forKey: "experienceToNextLevel")
        
        if self.experienceToNextLevel == 0 {
            self.experienceToNextLevel = 400
        }
    }
    
    func addExperience(points: Int) {
        currentExperience += points
        if (currentExperience >= experienceToNextLevel) {
            levelUp();
        }
    }
    
    private func levelUp() {
        currentLevel += 1
        currentExperience = abs(currentExperience - experienceToNextLevel)
        experienceToNextLevel = Int(Double(experienceToNextLevel) * 1.2)
    }
}
