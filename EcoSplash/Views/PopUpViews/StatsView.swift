//
//  StatsView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 04/11/24.
//

import SwiftUI

struct StatsView: View {
    
    let geometry: GeometryProxy
    
    @Binding var activePopUp: ActivePopUp?
    
    @ObservedObject var statistics: Statistics
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                Text("Estadísticas")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Button(action:{
                    activePopUp = nil
                }) {
                    Image("X")
                }
            }
            
            VStack {
                Text("Duchas totales: \(statistics.totalShowers)").font(Font.custom("Dangrek-Regular", size: 20))
                Spacer()
                Text("Duchas menores a 5 minutos: \(statistics.totalShortShowers)").font(Font.custom("Dangrek-Regular", size: 20))
                Spacer()
                Text("Litros de agua ahorrados: \(String(format: "%.2f", statistics.totalSavedLiters))").font(Font.custom("Dangrek-Regular", size: 20))
                Spacer()
            }
            
            Spacer()
        }.frame(width: geometry.size.width * 0.9, height: geometry.size.width * 1, alignment: .center)
            .background(.popUpBlue)
            .cornerRadius(20)
    }
}

#Preview {
    //StatsView()
}
