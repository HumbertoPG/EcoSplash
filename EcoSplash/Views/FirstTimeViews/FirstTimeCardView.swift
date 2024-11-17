//
//  FirstTimeCardView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 15/11/24.
//

import SwiftUI

struct FirstTimeCardView: View {
    var body: some View {
        VStack {
            Text("¡Bienvenido a EcoSplash!¡Una app donde cuidas el agua, divirtiéndote!Para comenzar, conoce las características y botones principales")
            Image("axobowl")
            Text("Este es tu ajolote, cuidalo muy bien, conforme progreses irá creciendo y podrás personalizarlo")
        }
    }
}

#Preview {
    FirstTimeCardView()
}
