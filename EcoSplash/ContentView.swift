//
//  ContentView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 28/10/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var showTimer: Bool = false
    @State private var isExpanded: Bool = false
    @State private var selectedItem: Item?
    
    @StateObject private var userData = UserData()
    @StateObject private var levelManager = LevelManager()
    @StateObject private var coinManager = CoinManager()
    @StateObject private var strikeManager = StrikeManager()
    @StateObject private var statistics = Statistics()
    @StateObject private var inventoryManager = InventoryManager()
    
    @StateObject private var achievementsManager: AchievementsManager
    @StateObject private var timerModel: TimerModel
    
    @State private var activePopUp: ActivePopUp?
    @State var itemType: Int = 0
    @State var index: Int = 0
    
    init() {
        let levelManagerInstance = LevelManager()
        let coinManagerInstance = CoinManager()
        let strikesManagerInstance = StrikeManager()
        let statisticsInstance = Statistics()
        let inventoryManagerInstance = InventoryManager()
        let achievementsManagerInstance = AchievementsManager(strikeManager: strikesManagerInstance, statistics: statisticsInstance, inventoryManager: inventoryManagerInstance)
        _levelManager = StateObject(wrappedValue: levelManagerInstance)
        _coinManager = StateObject(wrappedValue: coinManagerInstance)
        _strikeManager = StateObject(wrappedValue: strikesManagerInstance)
        _statistics = StateObject(wrappedValue: statisticsInstance)
        _inventoryManager = StateObject(wrappedValue: inventoryManagerInstance)
        _achievementsManager = StateObject(wrappedValue: achievementsManagerInstance)
        _timerModel = StateObject(wrappedValue: TimerModel(levelManager: levelManagerInstance, coinManager: coinManagerInstance, strikeManager: strikesManagerInstance, statistics: statisticsInstance, achievementsManager: achievementsManagerInstance))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                
                VStack(spacing: 0) {
                    TopView(geometry: geometry, activePopUp: $activePopUp, levelManager: levelManager)
                    MidView(geometry: geometry, userData: userData, showTimer: $showTimer, isExpanded: $isExpanded, coinManager: coinManager, strikeManager: strikeManager, timerModel: timerModel, levelManager: levelManager)
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                ZStack(alignment: .bottom) {
                    BottomView(geometry: geometry, activePopUp: $activePopUp, isExpanded: $isExpanded, showTimer: $showTimer, timerModel: timerModel, inventoryManager: inventoryManager, userData: userData, coinManager: coinManager, achievementsManager: achievementsManager, itemType: $itemType, index: $index)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
                if let popUp = activePopUp {
                    switch popUp {
                    case .achievements:
                        Color.black.opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                activePopUp = nil
                            }
                        AchievementsView(geometry: geometry, activePopUp: $activePopUp, achievementsManager: achievementsManager)
                    case .info:
                        Color.black.opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                activePopUp = nil
                            }
                        InfoView(geometry: geometry,activePopUp: $activePopUp)
                    case .stats:
                        Color.black.opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                activePopUp = nil
                            }
                        StatsView(geometry: geometry, activePopUp: $activePopUp, statistics: statistics)
                    case .itemInfo:
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                activePopUp = nil
                            }
                        ItemInfoView(geometry: geometry, activePopUp:$activePopUp, coinManager: coinManager, inventoryManager: inventoryManager, userData: userData, achievementsManager: achievementsManager, itemType: $itemType, index: $index)
                    case .firstTimeView:
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                activePopUp = nil
                                userData.setIsFirstTime()
                            }
                        FirstTimeView(geometry: geometry, activePopUp: $activePopUp, userData: userData)
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    if userData.isFirstTime {
                        activePopUp = .firstTimeView
                    }
                }
        }
    }
    
}

#Preview {
    ContentView()
}
