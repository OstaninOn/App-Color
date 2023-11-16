//
//  SearchColors.swift
//  Color
//
//  Created by  aleksandr on 14.11.23.
//

import SwiftUI
import Foundation
import Combine

struct SearchColors: View {
    var body: some View {
        
        Home1()
            .background(LinearGradient(colors: [.yellow,.red, .blue, .green, .cyan, .orange, .indigo, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
        
    }
}

struct SearchColors_Previews: PreviewProvider {
    static var previews: some View {
        SearchColors()
        
    }
}


struct Home1: View {
    @State var show = false
    @State var txt = ""
    @State var data = ["YW359F", "YW361F", "Y2316F", "Y22209", "YW201E", "YW353F", "YW366F", "YW283F", "YW279F", "YW268I", "Y2213I", "SZ601X", "YA406I", "YY217E", "Y2205I", "Y2214I", "Y2305I", "Y2361I", "Y4307I", "YW106I", "YW255F", "YW266F", "YW268F", "YW273F", "YW274F", "YW355F", "YW356F", "YW358F", "YW365F", "YW382I", "YX050F", "Y2214F", "YW383I", "NW001I", "SJ7009", "SW3009", "Y2211I", "Y2303I", "Y4309I", "YL316I", "YW263I", "YW267I", "YW269F", "YW280F", "YW284F", "YW360F", "YW387I", "YX355F", "Y2203I", "Y2204I", "Y2207I", "Y2211I", "Y2215F", "YW266I", "YW371F", "YX353F", "YW380I", "NW4109", "NW4119", "Y2212I", "Y4308I", "YW261I", "YW362F", "N24069", "NW4059", "NW4069", "NW4089", "SA356JR", "SD3079", "Y2000I", "Y2206F", "Y2208I", "Y2217F", "Y2304I", "Y2306I", "Y2317F", "Y4304I", "Y4306I", "YW354F", "YW370F", "YW381I", "R24019", "R24109", "R24119", "R54009", "RX4039", "RX4049", "RX4069", "SM3049", "SM3089", "SM3339", "YZ3009", "Y21019", "EW041D", "NW4139", "RX4079", "RX4089", "RX4099", "Y22099", "Y23099", "N23039", "N23179", "N23229", "MN802I", "N23009", "N23019", "N23049", "N23059", "N23069", "N23079", "N23089", "N23099", "N23109", "N23119", "N23129", "N23139", "N23149", "N23159", "N23189", "N23239", "R23009", "S23029", "SW3029", "SX3019"]
  
    
    var body: some View {
       
        VStack {
            HStack {

                if !self.show {
                    
                    Text("Color")
                        .padding(.top, 12)
                        .padding(.leading, 15)
                        .font(.custom("DenkOne-Regular",fixedSize: 50)
                        .weight(.black))
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 0)
                
                HStack (spacing: 10){
                    
                    if self.show {
                        Label("", systemImage: "")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                        
                        TextField(" search color", text: self.$txt)
                            
                            
                            .frame(width: 240, height: 35)
                            
                            .font(Font.system(size: 20))
                            
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(7)

                            
                        Button(action: {
                            withAnimation {
                                self.txt = ""
                                self.show.toggle()
                            }
                            
                        }) {
                            //Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(.indigiBG)
                                .font(.system(size: 20, weight: .bold))
                            
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    else {
                        Button(action: {
                            withAnimation {
                                self.show.toggle()
                            }
                            
                        }) {
                            Label("", systemImage: "magnifyingglass")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.indigiBG)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .padding(.leading, 10)
                                .padding(.trailing, 3)
                                
                        }
                        
                    }
                    
                }
                
                .padding(self.show ? 15 : 1)
                .background(Color.white)
                .cornerRadius(30)
            }
            
            .padding(.top, 70)
            //.padding(.horizontal, 25)
            .padding(.bottom, 5)
            .padding(.trailing, 30)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    if self.txt != "" {
                        if data.filter({$0.lowercased().contains(self.txt.lowercased())}).count == 0 {
                            
                            Text("NO RESULT").padding(.top, 50)
                                .font(.custom("DenkOne-Regular",fixedSize: 50)
                                    .weight(.black))
                                .font(.title)
                        }
                        
                        else {
                            ForEach(data.filter({$0.lowercased().contains(self.txt.lowercased())}),id: \.self) {i in
                                cellView(image: i)
                       
                            }
                            
                            Text("Found color")
                                .foregroundColor(Color.red)
                                .font(.custom("ZillaSlab-Bold",fixedSize: 20)
                                .weight(.black))
                                .font(.title)
                        }
                    }
                    
                    else {
                        ForEach(data, id: \.self) { i in
                            cellView(image: i)
                                .scrollTransition(.animated.threshold(.visible(0.2))) { content, phase in
                                    
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 1.5)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 1.9)
                                        .rotation3DEffect(.radians(phase.value), axis: (50, 1, 1))
                                }
                        }
                    }
                }
                
                .padding(.horizontal, 15)
                .padding(.top, 5)
                
            }
        }
        
        .edgesIgnoringSafeArea(.top)
        
    }
}



struct DetailView: View {
    
    static let status = ""
  
    var image: String
    var body: some View {
        
        Text(image)
            
    }
}


struct cellView: View {
    @State var showSheet = false
     var image: String

    @State var showingDetail = false
    @State var msg = ""
    @State var retrieved = ""
    
  
 
    var body: some View {

    
        ZStack(alignment: .bottomTrailing) {
            
            Button(action: {
                self.showSheet.toggle()
                }, label: {
                    Image(image).resizable().frame(height: 200).cornerRadius(25)
                        .shadow(color: .black, radius: 5, x: 1, y: 5)
                }).sheet(isPresented: $showSheet, content: {
                    Image(image)
                        .resizable()
                })
                .padding(.bottom, 5)
            
      // ИМЯ ЦВЕТА
            
                
                    DetailView(image: image)
                        .padding(.trailing, 150)
                        .padding(.bottom, 80)
                        .font(
                            .custom("DenkOne-Regular",fixedSize: 30).weight(.black))
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: .black,  radius: 3)
            
            
    // КНОПКА КРУГЛАЯ БЕЛАЯ ( ИНФОРМАЦИЯ ЦВЕТА )
            
            Button (action: {
                self.showingDetail.toggle()
                print(image)
                
            }) {
                
                Image(systemName: "info")
                    .foregroundColor(.blue).padding()
                    .scaleEffect(1.5)
                    .symbolEffect(.pulse)
            }.sheet(isPresented: $showingDetail, content: {
                
                Spacer()
                    .frame(height: 30)
                
                
    // ИНФОРМАЦИЯ ЦВЕТА
                    
                Text("Color Information")
                    .font(
                        .custom("ZillaSlab-Bold",fixedSize: 30).weight(.black))
                    .font(.largeTitle)
                    //.fontWeight(.bold)
                    .foregroundColor(.red)
                Spacer()
                    .frame(height: 30)
                
                
    // РАЗДЕЛИТЕЛЬ КРАСНАЯ ПОЛОСКА
                Divider()
                    .overlay(.indigiBG)
                
                
      // НАЗВАНИЕ ЦВЕТА (информация цвета)
                
                    Form {
                        
                        Section(header: Text ("Color: ")) {
                            
                            DetailView(image: image)
                            
                                .font(
                                    .custom("DenkOne-Regular",fixedSize: 80).weight(.black))
                                .font(.largeTitle)
                                .frame(minWidth: 0,
                                       maxWidth: .infinity,
                                       minHeight: 0,
                                       maxHeight: .infinity,
                                       alignment: .center)
                                .frame(height: 70)
                                .shadow(color: .red, radius: 1, x: 2, y: 0 )
                                //.listRowBackground(Color.green)
                        }
                        
                      // ВВОД ТЕКСТА И СОХРАНЕНИЕ
                        
                        Section(header: Text ("Text: ")) {
                            
                            Text(retrieved).fontWeight(.bold)
                            
                                .padding(.bottom, 60)
                            TextField("Entry field",text:$msg).padding()
                        
                            Button(action: {
                                
                                UserDefaults.standard.set(self.msg, forKey: image)
                                self.retrieved = self.msg
                                self.msg = ""
                 
                            }) {
                                
                                Text("Save").padding()
                                    
                                    .font(
                                        .custom("DenkOne-Regular",fixedSize: 30).weight(.black))
                                Spacer()
                            }
                           
                            .frame(width: 160, height: 60)
                            .background(Color.indigiBG)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 0,
                                   maxHeight: .infinity,
                                   alignment: .center)
                            .padding(30)
                            .onAppear {
                                guard let retreivedmsg = UserDefaults.standard.value(forKey: image) else {return}
                                self.retrieved = retreivedmsg as! String
 
                            }
                        }
                    }
            })
            
            .background(Color.white)
            .clipShape(Circle())
            .padding()
        }
    }
}

class Host: UIHostingController<SearchColors> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
