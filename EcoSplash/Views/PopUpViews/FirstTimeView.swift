//
//  FirstTimeView.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 05/11/24.
//

import SwiftUI

struct FirstTimeView: View {
    
    let geometry: GeometryProxy
    @Binding var activePopUp: ActivePopUp?
    @ObservedObject var userData: UserData
    
    @State private var activePage: Int = 0
    
    var cards: [HelpViewsContent] = [
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "axobowl", bottomText: """
    Este es tu ajolote, cuidalo
    muy bien, conforme
    progreses irá creciendo y
    podrás personalizarlo
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "timer", bottomText: """
    Botón de temporizador:
    Justo cuando estés a
    punto de meterte a bañar,
    presiona el botón de
    temporizador para tomar
    el tiempo. Cuando
    termines, oprimelo una
    vez más para detenerlo.
    ¡Si tu ducha es menor a
    8 minutos, ganarás más recompensas!
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "clock", bottomText: """
    Temporizador: Aquí se
    mostrará el tiempo
    restante de la ducha para
    conseguir más recompensas.
    ¡No dejes que el reloj llegue a 0!
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar,conoce las
    características y botones
    principales
    """, imageName: "strikes", bottomText: """
    Racha: Cada vez que
    completes una ducha en
    menos de 8 minutos, esta irá incrementando, entre
    mayor sea la racha,
    mayores serán las recompensas.
    ¡No la pierdas!
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "coins", bottomText: """
    ¡Monedas!: Ganarás
    monedas conforme tomes
    duchas rápidas, entre
    menor sea el tiempo de tu
    ducha, ganarás más
    monedas, las cuales
    podrás gastar en la tienda
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "Edit", bottomText: """
    Tienda: Accede a la tienda
    por medio de este botón,
    en ella podrás gastar tus
    monedas para adquirir
    accesorios para tu ajolote y pecera
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "Activity", bottomText: """
    Estadísticas: Oprime el
    botón de estadísticas para
    ver tus duchas totales,
    duchas rápidas y litros de
    agua ahorrados.
    """),
        HelpViewsContent(topText: """
    ¡Bienvenido a EcoSplash!
    ¡Una app donde cuidas el
    agua, divirtiéndote!
    Para comenzar, conoce las
    características y botones
    principales
    """, imageName: "Award", bottomText: """
    Botón de logros: Ganarás
    medallas conforme
    alcances los logros,
    puedes ver tu progreso y
    metas cumplidas.
    ¡Completa todos!
    """),
    ]
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Button(action: {
                        activePopUp = nil
                        userData.setIsFirstTime()
                    }) {
                        Image("X")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.06)
                            .padding(.top, geometry.size.height * 0.01)
                            .padding(.trailing, geometry.size.width * 0.05)
                    }
                }
                ScrollCarousel(activeIndex: $activePage) {
                    ForEach(cards) { card in
                        VStack {
                            Text(card.topText)
                                .font(Font.custom("Montserrat-SemiBold", size: 20))
                                .multilineTextAlignment(.center)
                                .frame(height: .infinity)
                            VStack {
                                Image(card.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: geometry.size.height * 0.4) // Tamaño máximo inicial
                                    .layoutPriority(1) // Da menos prioridad a la imagen que al texto
                                
                                Spacer(minLength: 10) // Espaciador entre la imagen y el texto
                                
                                // Texto inferior con tamaño fijo
                                Text(card.bottomText)
                                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(2)
                            }
                        }
                    }
                }
                HStack(spacing: 5) {
                    ForEach(cards.indices, id: \.self) { index in
                        Circle()
                            .fill(activePage == index ? .primary : .secondary)
                            .frame(width: 8, height: 8)
                    }
                }
                Spacer()
            }.background(.niceBlue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(.niceBlue)
            .cornerRadius(50)
            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8, alignment: .center)
        
    }
}

#Preview {
    GeometryReader { geometry in
        ZStack {
            FirstTimeView(geometry: geometry, activePopUp: .constant(nil), userData: UserData())
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
