//
//  BottomView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 05/11/24.
//

import SwiftUI

struct BottomView: View {
    
    let geometry: GeometryProxy
    
    @Binding var activePopUp: ActivePopUp?
    
    @Binding var isExpanded: Bool
    @Binding var showTimer: Bool
    
    @ObservedObject var timerModel: TimerModel
    @ObservedObject var inventoryManager: InventoryManager
    @ObservedObject var userData: UserData
    @ObservedObject var coinManager: CoinManager
    @ObservedObject var achievementsManager: AchievementsManager
    @Binding var itemType: Int
    @Binding var index: Int
    
    enum ActiveMenu {
        case selector, editSkin, editTank
    }
    
    @State private var activeMenu: ActiveMenu? = nil
    
    var body: some View {
        
        ZStack() {
            
            if isExpanded {
                
                VStack(spacing: 0) {
                    
                    if activeMenu == .selector {
                        EditMenu(geometry: geometry, activeMenu: $activeMenu, isExpanded: $isExpanded, itemType: $itemType)
                            .transition(.move(edge: .leading))
                    } else if activeMenu == .editTank || activeMenu == .editSkin {
                        EditItem(geometry: geometry, activeMenu: $activeMenu, inventoryManager: inventoryManager, userData: userData, coinManager: coinManager, activePopUp: $activePopUp, itemType: $itemType, index: $index)
                            .transition(.move(edge: .leading))
                    }
                }
                
                
                
            } else {
                
                HStack {
                    Spacer()
                    Button(action: {
                        isExpanded.toggle()
                        activeMenu = .selector
                    }) {
                        Image("Edit")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Spacer()
                    Button(action: {
                        showTimer.toggle()
                        
                        if showTimer {
                            timerModel.startTimer()
                        } else {
                            timerModel.stopTimer()
                        }
                    }) {
                        Image("timer")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Spacer()
                    Button(action: {
                        withTransaction(Transaction(animation: nil)) {
                            activePopUp = .stats
                        }
                    }) {
                        Image("Activity")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Spacer()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: isExpanded ? geometry.size.height * 0.23 : geometry.size.height * 0.089, alignment: Alignment(horizontal: .center, vertical: .bottom)).background(.white)
    }
}
