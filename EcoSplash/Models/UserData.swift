//
//  UserData.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 31/10/24.
//

import Foundation
import SwiftUI

class UserData:ObservableObject {
    
    @Published var isFirstTime: Bool {
        didSet {
            UserDefaults.standard.set(isFirstTime, forKey: "isFirstTime")
        }
    }
    
    @Published var currentSkin: String {
        didSet {
            UserDefaults.standard.set(currentSkin, forKey: "currentSkin")
        }
    }
    
    @Published var currentFishTank: String {
        didSet {
            UserDefaults.standard.set(currentFishTank, forKey: "currentFishTank")
        }
    }
    
    @Published var previewSkin: String?
    @Published var previewFishTank: String?
    
    init() {
        
        if UserDefaults.standard.object(forKey: "isFirstTime") == nil {
            self.isFirstTime = true
            UserDefaults.standard.set(true, forKey: "isFirstTime")
        } else {
            self.isFirstTime = UserDefaults.standard.bool(forKey: "isFirstTime")
        }
        self.currentSkin = UserDefaults.standard.string(forKey: "currentSkin") ?? "basic_axolote"
        self.currentFishTank = UserDefaults.standard.string(forKey: "currentFishTank") ?? "basic_tank"
        
    }
    
    func setIsFirstTime() {
        isFirstTime = false
    }
    
    func getCurrentFrame(itemType: Int) -> String {
        if itemType == 1 {
            return currentFishTank
        }else {
            return currentSkin
        }
    }
    
    func getPreview(itemType: Int) -> String {
        if itemType == 1 {
            return previewFishTank ?? "basic_tank"
        }else {
            return previewSkin ?? "basic_axolote"
        }
    }
    
    func checkIfIsInUse (item: String) -> Bool {
        if currentSkin == item || currentFishTank == item {
            return true
        }
        return false
    }
    
    func setCurrentFrame(frame: String, itemType: Int) {
        if itemType == 1 {
            currentFishTank = frame;
        }else {
            currentSkin = frame
        }
    }
    
    func setPreview(frame: String, itemType: Int) {
        if itemType == 1 {
            previewFishTank = frame;
        }else {
            previewSkin = frame
        }
    }
    
    func endPreview() {
        previewSkin = nil
        previewFishTank = nil
    }
    
}
