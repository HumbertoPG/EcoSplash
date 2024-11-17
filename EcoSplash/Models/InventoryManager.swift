//
//  InventoryManager.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 13/11/24.
//

import Foundation

class InventoryManager: ObservableObject {
    
    @Published var fishTanks: [Item] = [] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(fishTanks) {
                UserDefaults.standard.set(encodedData, forKey: "fishTanks")
            }
        }
    }
    @Published var skins: [Item] = [] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(skins) {
                UserDefaults.standard.set(encodedData, forKey: "skins")
            }
        }
    }
    
    @Published var itemsObtained: Int = 0 {
        didSet {
            UserDefaults.standard.set(itemsObtained, forKey: "itemsObtained")
        }
    }
    
    init() {
        
        self.fishTanks = loadTanks()
        self.skins = loadSkins()
        self.itemsObtained = UserDefaults.standard.integer(forKey: "itemsObtained")
        if self.fishTanks.isEmpty {
            fishTanks = [
                Item(id: 0, itemImageName: "N/A", frameImageName: "basic_tank", price: 0, description: "N/A", isUnlocked: true, isEquipped: true),
                Item(id: 1, itemImageName: "igloo_item", frameImageName: "igloo_tank", price: 15, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 2, itemImageName: "palm_item", frameImageName: "palm_tank", price: 20, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 3, itemImageName: "pineapple_item", frameImageName: "pineapple_tank", price: 30, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 4, itemImageName: "moai_item", frameImageName: "moai_tank", price: 100, description: "No lo sé, solo estaba nadando por hawai, alguien se me acerco con uno de estos y me dijo MONDONGO, y se alejó lentamente.", isUnlocked: false, isEquipped: false)
            ]
            print("Datos para fishTanks cargados por default")
        }
        
        if self.skins.isEmpty {
            skins = [
                Item(id: 0, itemImageName: "N/A", frameImageName: "basic_axolote", price: 0, description: "N/A", isUnlocked: true, isEquipped: true),
                Item(id: 1, itemImageName: "flower_item", frameImageName: "flower_axolote", price: 20, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 2, itemImageName: "mexican_item", frameImageName: "mexican_axolote", price: 25, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 3, itemImageName: "sunglasses_item", frameImageName: "sunglasses_axolote", price: 45, description: "N/A", isUnlocked: false, isEquipped: false),
                Item(id: 4, itemImageName: "viking_item", frameImageName: "viking_axolote", price: 100, description: "N/A", isUnlocked: false, isEquipped: false)
            ]
            print("Datos para skins cargados por default")
        }
    }
    
    func loadTanks() -> [Item] {
        if let savedDataTanks = UserDefaults.standard.data(forKey: "fishTanks") {
            do {
                let decodedFishTanks = try JSONDecoder().decode([Item].self, from: savedDataTanks)
                return decodedFishTanks
            } catch {
                print("Error al decodificar los tanques: \(error)")
            }
        }
        return []
    }
    
    func loadSkins() -> [Item] {
        if let savedDataSkins = UserDefaults.standard.data(forKey: "skins") {
            do {
                let decodedSkins = try JSONDecoder().decode([Item].self, from: savedDataSkins)
                return decodedSkins
            } catch {
                print("Error al decodificar las apariencias: \(error)")
            }
        }
        return []
    }
    
    func purchaseItem(index: Int, switchMode: Int) {
        if switchMode == 1 {
            fishTanks[index].isUnlocked = true
            itemsObtained += 1
        }else {
            skins[index].isUnlocked = true
            itemsObtained += 1
        }
            
    }
    
    func chechIfItemIsUnlocked(index: Int, switchMode: Int) -> Bool {
        
        if switchMode == 1 {
            return fishTanks[index].isUnlocked
        }else {
            return skins[index].isUnlocked
        }
        
    }
    
    func getItemImageName(index: Int, switchMode: Int) -> String {
        
        if switchMode == 1 {
            return fishTanks[index].itemImageName
        }else {
            return skins[index].itemImageName
        }
        
    }
    
    func getFrameImageName(index: Int, switchMode: Int) -> String {
        
        if switchMode == 1 {
            return fishTanks[index].frameImageName
        }else {
            return skins[index].frameImageName
        }
    }
    
    func getPrice(index: Int, switchMode: Int) -> Int {
        
        if switchMode == 1 {
            return fishTanks[index].price
        }else {
            return skins[index].price
        }
    }
    
    func getDescription(index: Int, switchMode: Int) -> String {
        
        if switchMode == 1 {
            return fishTanks[index].description
        }else {
            return skins[index].description
        }
        
    }
    
    func getIsEquipped(index: Int, switchMode: Int) -> Bool {
        
        if switchMode == 1 {
            return fishTanks[index].isEquipped
        }else {
            return skins[index].isEquipped
        }
    }
    
}
