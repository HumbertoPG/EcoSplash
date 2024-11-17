//
//  ItemInfoView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 10/11/24.
//

import SwiftUI

struct ItemInfoView: View {
    
    let geometry: GeometryProxy
    @Binding var activePopUp: ActivePopUp?
    @ObservedObject var coinManager: CoinManager
    @ObservedObject var inventoryManager: InventoryManager
    @ObservedObject var userData: UserData
    @ObservedObject var achievementsManager: AchievementsManager
    @Binding var itemType: Int
    @Binding var index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    activePopUp = nil
                }) {
                    Image("X")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                }
                
            }
            Image(inventoryManager.getItemImageName(index: index, switchMode: itemType))
                .resizable()
                .scaledToFit()
            Spacer()
            Text("\(inventoryManager.getDescription(index: index, switchMode: itemType))")
                .font(Font.custom("Montserrat-Semibold", size: geometry.size.width * 0.0435))
                .frame(height: geometry.size.height * 0.2)
                .frame(alignment: .center)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .multilineTextAlignment(.center)
            Spacer()
            
            if inventoryManager.chechIfItemIsUnlocked(index: index, switchMode: itemType) {
                
                if userData.checkIfIsInUse(item: inventoryManager.getFrameImageName(index: index, switchMode: itemType)) {
                    Button(action: {
                        if itemType == 1 {
                            userData.currentFishTank = inventoryManager.fishTanks[0].frameImageName
                        }else {
                            userData.currentSkin = inventoryManager.skins[0].frameImageName
                        }
                    }) {
                        Text("Quitar")
                            .foregroundColor(.white)
                            .padding()
                    }.background(.darkBlue)
                        .cornerRadius(10)
                }else {
                    Button(action: {
                        if itemType == 1 {
                            userData.currentFishTank = inventoryManager.getFrameImageName(index: index, switchMode: itemType)
                        }else {
                            userData.currentSkin = inventoryManager.getFrameImageName(index: index, switchMode: itemType)
                        }
                    }) {
                        Text("Usar")
                            .foregroundColor(.white)
                            .padding()
                    }.background(.darkBlue)
                        .cornerRadius(10)
                }
                
            }else {
                Button(action: {
                    if coinManager.coins >= inventoryManager.getPrice(index: index, switchMode: itemType) {
                        
                        inventoryManager.purchaseItem(index: index, switchMode: itemType)
                        
                        if itemType == 1 {
                            userData.currentFishTank = inventoryManager.getFrameImageName(index: index, switchMode: itemType)
                        }else {
                            userData.currentSkin = inventoryManager.getFrameImageName(index: index, switchMode: itemType)
                        }
                        
                        coinManager.substractCoins(inventoryManager.getPrice(index: index, switchMode: itemType))
                        achievementsManager.updateProgress()
                    }
                }) {
                    Text("Comprar")
                        .foregroundColor(.white)
                        .padding()
                }.background(.darkBlue)
                    .cornerRadius(10)
            }
            
            
            Spacer()
            
        }.frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.55, alignment: .center)
            .background(.popUpBlue)
            .cornerRadius(25)
    }
}

#Preview {
    //    GeometryReader { geometry in
    //        ZStack {
    //            ItemInfoView(geometry: geometry, activePopUp: .constant(nil), item: FishTank(itemImageName: "moai_item", tankImageName: "moai_tank", price: 100, description: "No lo sé, solo estaba nadando por hawai, alguien se me acerco con uno de estos y me dijo MONDONGO, y se alejó lentamente.", isUnlocked: false, isEquipped: false))
    //        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    //    }
}
