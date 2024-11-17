//
//  ScrollCarousel.swift
//  EcoSplash
//
//  Created by Humberto Pérez Galindo on 15/11/24.
//

import SwiftUI

struct ScrollCarousel<Content: View>: View {
    
    @Binding var activeIndex: Int
    @ViewBuilder var content: Content
    @State private var scrollPosition: Int?
    @State private var isScrolling: Bool = false
    @GestureState private var isHoldingScreen: Bool = false
    @State private var timer = Timer.publish(every: autoScrollDuration, on: .main, in: .default).autoconnect()
    
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            Group(subviews: content) { collection in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        
                        if let lastItem = collection.last {
                            lastItem
                                .frame(width: size.width, height: size.height)
                                .id(-1)
                        }
                        ForEach(collection.indices, id: \.self) { index in
                            collection[index]
                                .frame(width: size.width, height: size.height)
                                .id(index)
                        }
                        if let firstItem = collection.first {
                            firstItem
                                .frame(width: size.width, height: size.height)
                                .id(collection.count)
                        }
                        
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $scrollPosition)
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .onScrollPhaseChange {oldPhase, newPhase in
                    isScrolling = newPhase.isScrolling
                    
                    if !isScrolling && scrollPosition == -1 {
                        scrollPosition = collection.count - 1
                    }
                    
                    if !isScrolling && scrollPosition == collection.count {
                        scrollPosition = 0
                    }
                }
                .simultaneousGesture(DragGesture(minimumDistance: 0).updating($isHoldingScreen, body: { _, out, _ in
                    out = true
                }))
                .onChange(of: isHoldingScreen, { oldValue, newValue in
                    if newValue {
                        timer.upstream.connect().cancel()
                    } else {
                        timer = Timer.publish(every: Self.autoScrollDuration, on: .main, in: .default).autoconnect()
                    }
                })
                .onReceive(timer) { _ in
                    guard !isHoldingScreen && !isScrolling else { return }
                    let nextIndex = (scrollPosition ?? 0) + 1
                    withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                        scrollPosition = (nextIndex == collection.count + 1) ? 0 : nextIndex
                    }
                }
                .onChange(of: scrollPosition) { oldValue, newValue in
                    if let newValue {
                        activeIndex = max(min(newValue, collection.count - 1), 0)
                    }
                }
            }
            .onAppear {scrollPosition = 0}
        }
    }
    
    static var autoScrollDuration: CGFloat {
        return 3
    }
    
}

#Preview {
    GeometryReader { geometry in
        ZStack {
            FirstTimeView(geometry: geometry, activePopUp: .constant(nil), userData: UserData())
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
