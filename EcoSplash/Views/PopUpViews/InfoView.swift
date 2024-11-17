//
//  InfoView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 05/11/24.
//

import SwiftUI

struct InfoView: View {
    
    let geometry: GeometryProxy
    
    @Binding var activePopUp: ActivePopUp?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    activePopUp = nil
                }) {
                    Image("X")
                }
            }
            Text("El objetivo de la aplicación es concientizar sobre el desperdicio y uso desmedido del agua, ya que, este es un recurso limitado del cual todos debemos cuidar generando una red de acción ciudadana.")
                .font(Font.custom("Dangrek-Regular", size: 20))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.horizontal)
            Text("Para más información visita nuestra pagina de facebook EcoEspacio Digital")
                .font(Font.custom("Dangrek-Regular", size: 20))
            Spacer()
        }.frame(width: geometry.size.width * 0.9, height: geometry.size.width * 1, alignment: .center)
            .background(.popUpBlue)
            .cornerRadius(20)
    }
}

#Preview {
    
    GeometryReader { geometry in
        ZStack {
            InfoView(geometry: geometry, activePopUp: .constant(nil))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
