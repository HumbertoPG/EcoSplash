//
//  CardView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 08/11/24.
//

import SwiftUI

struct CardView: View {
    
    let geometry: GeometryProxy
    
    @ObservedObject var userData: UserData
    @ObservedObject var inventoryManager: InventoryManager
    let itemType: Int
    let index: Int
    var isSelected: Bool
    
    var body: some View {
        VStack {
            
            if inventoryManager.getItemImageName(index: index, switchMode: itemType) == "N/A" {
                Image("none")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }else {
                
                Image(inventoryManager.getItemImageName(index: index, switchMode: itemType))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(5)
                if inventoryManager.chechIfItemIsUnlocked(index: index, switchMode: itemType) {
                    Spacer()
                }else{
                    HStack(spacing: 0) {
                        Image("coins")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.07)
                        Text("$\(inventoryManager.getPrice(index: index, switchMode: itemType))").foregroundColor(Color.black).font(Font.custom("Montserrat-Bold", size: geometry.size.width * 0.05))
                    }
                }
                
            }
            
        }.frame(width: geometry.size.width * 0.28, height: geometry.size.height * 0.15)
            .background(.popUpBlue)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(isSelected ? .green : .popUpBlue, lineWidth: isSelected ? 3 : 2))
    }
}

#Preview {
//    @State var selectedItem: String = "N/A"
//    GeometryReader { geometry in
//        CardView(geometry: geometry, imageName: "pecera_item1", price: 20, selected: $selectedItem)
//    }
    
}
