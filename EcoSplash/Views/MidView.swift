//
//  MidView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 08/11/24.
//

import SwiftUI

struct MidView: View {
    
    let geometry: GeometryProxy
    
    @ObservedObject var userData: UserData
    
    @Binding var showTimer: Bool
    @Binding var isExpanded: Bool
    
    @ObservedObject var coinManager: CoinManager
    @ObservedObject var strikeManager: StrikeManager
    @ObservedObject var timerModel: TimerModel
    @ObservedObject var levelManager: LevelManager
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height * 0.69)
                .clipped()
            VStack {
                HStack {
                    Image("strikes")
                    Text("\(strikeManager.strikes)").font(Font.custom("Montserrat-Bold", size: 21))
                        .padding(.trailing, 10)
                    Image("coins")
                        .padding(.leading, 10)
                    Text("$\(coinManager.coins)").font(Font.custom("Montserrat-Bold", size: 21))
                }.padding(.top, 20)
                
                
                VStack(spacing: 0) {
                    
                    ZStack {
                        
                        TimelineView(.animation) { timeline in
                            
                            let currentTime = timeline.date.timeIntervalSince1970
                            let frameIndex = Int(currentTime * 20) % 44 + 1 // 20 frames por segundo
                            
                            Image("\(userData.previewFishTank ?? userData.currentFishTank)_\(timerModel.tankStatus)_\(frameIndex)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.45)
                        }
                        
                        TimelineView(.animation) { timeline in
                            
                            let currentTime = timeline.date.timeIntervalSince1970
                            let frameIndex = Int(currentTime * 10) % 14 + 1
                            let baseSize: Double = 0.6
                            let maxSize: Double = 1.0
                            let growthFactor = min(maxSize, baseSize + (maxSize - baseSize) * (Double(levelManager.currentLevel) / 10.0))
                            
                            Image("\(userData.previewSkin ?? userData.currentSkin)_\(timerModel.axoloteStatus)_\(frameIndex)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.23 * growthFactor)
                                .padding(.trailing, 93)
                        }
                        
                    }
                    if showTimer {
                        ZStack {
                            Image("clock")
                            Text(timerModel.formattedTime())
                                .frame(width: geometry.size.width * 0.41, height: geometry.size.height * 0.06)
                                .font(Font.custom("Teko-Medium", size: 55))
                                .foregroundColor(.white)
                                .background(.specialGray)
                        }
                    } else {
                        Spacer()
                    }
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.69)
    }
}

#Preview {
    GeometryReader { geometry in
        ZStack {
            
            let userData = UserData()
            
            let coinManager = CoinManager()
            let strikeManager = StrikeManager()
            let levelManager = LevelManager()
            
            let timerModel = TimerModel(
                levelManager: levelManager,
                coinManager: coinManager,
                strikeManager: strikeManager,
                statistics: Statistics(),
                achievementsManager: AchievementsManager(
                    strikeManager: strikeManager,
                    statistics: Statistics(),
                    inventoryManager: InventoryManager()
                )
            )
            
            MidView(
                geometry: geometry,
                userData: userData,
                showTimer: .constant(false),
                isExpanded: .constant(false),
                coinManager: coinManager,
                strikeManager: strikeManager,
                timerModel: timerModel,
                levelManager: levelManager
            )
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

