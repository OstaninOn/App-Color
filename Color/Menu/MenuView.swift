//
//  MenuView.swift
//  Color
//
//  Created by  aleksandr on 14.11.23.
//

import SwiftUI

struct MenuView: View {
    @State var selectTab = "Search 1..9"
    let tabs = ["Searsh 1..9", "Searsh A..Z"]//, "Setting"]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
           
        HStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectTab) {
                    ContentView()
                        .tag(tabs[0])
                    SearchColors()
                        .tag(tabs[1])
                    //SettingView()
                        //.tag(tabs[2])
                }
                
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Spacer()
                        TabBarItem(tab: tab, selected: $selectTab)
                        Spacer()
                    }
                }

                .frame(width: 360)
                .frame(height: 70)
                .background(Color("indigiBG"))
                .cornerRadius(25)
                .shadow(color: .black, radius: 5)
                Spacer()
            }
            .padding(.bottom, -5)
        }
    }
}

struct TabBarItem: View {
    
    @State var tab: String
    @Binding var selected: String
    
    var body: some View {
        if tab == "Setting" {
            Button {
                withAnimation(.spring()) {
                    selected = tab
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(selected == tab ? Color("") : .white)
                    
                    Image("Setting")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
            }
            
        } else {
            ZStack {
                Button {
                    withAnimation(.spring()) {
                        selected = tab
                            
                    }
                    
                } label: {
                    HStack {
                        Image(tab)
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        if selected == tab {
                            Text(tab)
                            
                                .font(Font.custom("DenkOne-Regular", size: 25)
                                    .weight(.black))
                                .font(.largeTitle)
                                .foregroundColor(.indigiBG)
                        }
                    }
                }
            }
            .opacity(selected == tab ? 20 : 20)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(selected == tab ? .white : Color(.white))
            
            
            .clipShape(Capsule())

        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

