//
//  EditMenu.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 14/11/24.
//

import SwiftUI

struct EditMenu: View {
    
    let geometry: GeometryProxy
    @Binding var activeMenu: BottomView.ActiveMenu?
    @Binding var isExpanded: Bool
    @Binding var itemType: Int
    
    var body: some View {
        
        HStack {
            Button(action: {
                isExpanded = false
                activeMenu = nil
            }) {
                Image("arrow")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 0)
                    .padding(.leading, 0)
            }
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.067)
        
        HStack {
            Button(action: {
                itemType = 1
                activeMenu = .editTank
            }) {
                Image("editPecera")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }.background(.popUpBlue)
                .cornerRadius(20)
                .padding(.trailing, 10)
            
            Button(action: {
                itemType = 2
                activeMenu = .editSkin
            }) {
                Image("editHat")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            }.background(.popUpBlue)
                .cornerRadius(20)
                .padding(.leading, 10)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
