//
//  DowlandAnimate.swift
//  Color
//
//  Created by  aleksandr on 14.11.23.
//

import SwiftUI

struct DowlandAnimate: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Image("color")
                .resizable()
                //.scaledToFill()
                //.edgesIgnoringSafeArea(.all)
                .scaleEffect(animate ? 4 : 1)
                
                .onAppear {
                    animate.toggle()
                }
                .animation(.easeInOut, value: animate)
        }
        MenuView()
        .opacity(animate ? 1 : 0)
        .animation(.easeInOut.delay(0.15), value: animate)
        
    }
}

#Preview {
    DowlandAnimate()
}
