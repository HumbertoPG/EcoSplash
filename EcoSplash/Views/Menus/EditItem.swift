//
//  EditItem.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import SwiftUI

struct EditItem: View {
    
    let geometry: GeometryProxy
    
    @Binding var activeMenu: BottomView.ActiveMenu?
    @ObservedObject var inventoryManager: InventoryManager
    @ObservedObject var userData: UserData
    @ObservedObject var coinManager: CoinManager
    @Binding var activePopUp: ActivePopUp?
    @Binding var itemType: Int
    @Binding var index: Int
    
    @State private var lastTappedIndex: Int?
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    activeMenu = .selector
                    userData.endPreview()
                    index = 0
                }) {
                    Image("arrow")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 0)
                        .padding(.leading, 0)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.065)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    let array = itemType == 1 ? inventoryManager.fishTanks : inventoryManager.skins
                    ForEach(Array(array.enumerated()), id: \.element.id) { currentIndex, fishTank in
                        let isSelected = currentIndex == lastTappedIndex
                        CardView(geometry: geometry, userData: userData, inventoryManager: inventoryManager, itemType: itemType, index: currentIndex, isSelected: isSelected)
                            .onTapGesture {
                                handleTap(for: currentIndex)
                                let frame = inventoryManager.getFrameImageName(index: currentIndex, switchMode: itemType)
                                if inventoryManager.chechIfItemIsUnlocked(index: currentIndex, switchMode: itemType) {
                                    userData.setCurrentFrame(frame: frame, itemType: itemType)
                                    userData.setPreview(frame: frame, itemType: itemType)
                                }else {
                                    userData.setPreview(frame: frame, itemType: itemType)
                                }
                            }
                    }
                }
            }
        }.onAppear {
            if itemType == 1 {
                lastTappedIndex = inventoryManager.fishTanks.firstIndex { $0.frameImageName == userData.currentFishTank }
            } else {
                lastTappedIndex = inventoryManager.skins.firstIndex { $0.frameImageName == userData.currentSkin }
            }
        }
    }
    
    private func handleTap(for tappedIndex: Int) {
            if lastTappedIndex == tappedIndex {
                activePopUp = .itemInfo
            } else {
                index = tappedIndex
                lastTappedIndex = tappedIndex
            }
        }
}
