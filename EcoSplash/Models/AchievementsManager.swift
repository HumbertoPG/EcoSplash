//
//  AchievementsManager.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import Foundation

class AchievementsManager: ObservableObject {
    
    private var strikeManager: StrikeManager
    private var statistics: Statistics
    private var inventoryManager: InventoryManager
    
    @Published var achievements: [Achievement] = [] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(achievements) {
                UserDefaults.standard.set(encodedData, forKey: "achievements")
            }
        }
    }
    
    init(strikeManager: StrikeManager, statistics: Statistics, inventoryManager: InventoryManager) {
        
        self.strikeManager = strikeManager
        self.statistics = statistics
        self.inventoryManager = inventoryManager
        self.achievements = AchievementsManager.loadAchievements()
        if self.achievements.isEmpty {
            print("No se encontraron logros guardados, inicializando con valores predeterminados.")
            self.achievements = [
                Achievement(imageName: "achievement_short_showers", description: "Toma 30 duchas rapidas seguidas", goal: 30, progress: strikeManager.strikes, obtained: false),
                Achievement(imageName: "achievement_super_saver", description: "Ahora 10,000 litros de agua", goal: 10000, progress: Int(statistics.totalSavedLiters), obtained: false),
                Achievement(imageName: "achievement_water_saver", description: "Desbloquea todos los items de la tienda", goal: 8, progress: inventoryManager.itemsObtained, obtained: false)
            ]
        }
    }
    
    func addAchievement(_ achievement: Achievement) {
        achievements.append(achievement)
        saveAchievements()
    }
    
    private func saveAchievements() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: "achievements")
        }
    }
    
    private static func loadAchievements() -> [Achievement] {
        if let savedData = UserDefaults.standard.data(forKey: "achievements") {
            do {
                let decodedAchievements = try JSONDecoder().decode([Achievement].self, from: savedData)
                return decodedAchievements
            } catch {
                print("Error al decodificar los logros: \(error)")
            }
        }
        return []
    }
    
    private func checkForAchievements() {
        for i in 0..<achievements.count {
            if achievements[i].progress >= achievements[i].goal {
                achievements[i].obtained = true
            }
        }
        saveAchievements()
    }
    
    func updateProgress() {
        for i in 0..<achievements.count {
            switch achievements[i].description {
            case "Toma 30 duchas rapidas seguidas":
                achievements[i].progress = strikeManager.strikes
                print(achievements[i])
            case "Ahora 10,000 litros de agua":
                achievements[i].progress = Int(statistics.totalSavedLiters)
                print(achievements[i])
            case "Desbloquea todos los items de la tienda":
                achievements[i].progress = inventoryManager.itemsObtained
                print(achievements[i])
            default:
                break
            }
        }
        checkForAchievements()
    }
    
}
