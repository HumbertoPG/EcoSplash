//
//  AchievementsView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 03/11/24.
//

import SwiftUI

struct AchievementsView: View {
    
    let geometry: GeometryProxy
    
    @Binding var activePopUp: ActivePopUp?
    @ObservedObject var achievementsManager: AchievementsManager
    
    @State private var selectedAchievement: Achievement?
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Logros")
                    .font(Font.custom("Montserrat-Bold", size: geometry.size.width * 0.07))
                    .frame(alignment: .center)
                    .padding(.leading, geometry.size.width * 0.13)
                Spacer()
                Button(action: {
                    activePopUp = nil
                }) {
                    Image("X")
                }
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(achievementsManager.achievements) { achievement in
                        Image("\(achievement.imageName)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.15, alignment: .center)
                            .saturation(achievement.obtained ? 1 : 0)
                            .onTapGesture {
                                selectedAchievement = achievement
                            }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.35)
            
            if let selectedAchievement = selectedAchievement{
                ProgressAchievementView(geometry: geometry, selectedAchievement: selectedAchievement)
            }
            
            Spacer()
        }.frame(maxWidth: geometry.size.width * 0.73, maxHeight: geometry.size.height * 0.6, alignment: Alignment(horizontal: .center, vertical: .center))
            .background(.popUpBlue)
            .cornerRadius(20)
            .onAppear() {
                selectedAchievement = achievementsManager.achievements[0]
            }
    }
}

struct ProgressAchievementView: View {
    
    let geometry: GeometryProxy
    var selectedAchievement: Achievement
    
    var body: some View {
        Text(selectedAchievement.description).font(Font.custom("Montserrat-SemiBold", size: geometry.size.width * 0.05))
        ZStack(alignment: .leading) {
            
            Capsule()
                .fill(.white)
                .frame(height: geometry.size.height * 0.039)
            Capsule()
                .fill(selectedAchievement.progress < selectedAchievement.goal ? .darkBlue : .green)
                .frame(width: geometry.size.width * 0.64 * min(1.0, CGFloat((Float(selectedAchievement.progress) / Float(selectedAchievement.goal)))), height: geometry.size.height * 0.039)
            HStack {
                Spacer()
                
                let textToShow = selectedAchievement.progress < selectedAchievement.goal ? "\(selectedAchievement.progress)/\(selectedAchievement.goal)" : "Completado"
                Text(textToShow)
                    .font(Font.custom("Montserrat-SemiBold", size:geometry.size.width * 0.05))
                Spacer()
            }
            
        }.padding(.leading, 18).padding(.trailing, 18)
        Spacer()
    }
}

#Preview {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
    
                AchievementsView(geometry: geometry, activePopUp: .constant(nil), achievementsManager: AchievementsManager(strikeManager: StrikeManager(), statistics: Statistics(), inventoryManager: InventoryManager()))
    
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}
