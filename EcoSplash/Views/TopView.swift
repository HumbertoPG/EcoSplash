//
//  TopView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 05/11/24.
//

import SwiftUI

struct TopView: View {
    
    let geometry: GeometryProxy
    
    @Binding var activePopUp: ActivePopUp?
    
    @ObservedObject var levelManager: LevelManager
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                
                Button(action: {
                    activePopUp = .achievements
                }) {
                    Image("Award")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14)
                        .padding(.leading, 16)
                }
                
                Spacer()
                
                Button(action: {
                    activePopUp = .info
                }) {
                    Image("Info")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14)
                        .padding(.trailing, 16)
                }
                
                
            }.padding(0)
            
            Text("Nivel: \(levelManager.currentLevel)").font(Font.custom("Montserrat-SemiBold", size: geometry.size.width * 0.15)).bold().padding(0)
            
            ZStack(alignment: .leading) {
                
                ZStack {
                    Capsule()
                        .fill(.white)
                        .frame(height: geometry.size.height * 0.039)
                }
                
                Capsule()
                    .fill(.darkBlue)
                    .frame(width: geometry.size.width * 0.91 * min(1, (Double(levelManager.currentExperience) / Double(levelManager.experienceToNextLevel))), height: geometry.size.height * 0.039)
                
            }.padding(.leading, 18).padding(.trailing, 18)
            
        }.frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.23).background(.niceBlue)
    }
}

#Preview {
    //    TopView()
}
