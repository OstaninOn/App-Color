//
//  ContentView.swift
//  Color
//
//  Created by  aleksandr on 14.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()

            .background(LinearGradient(colors: [.yellow,.red, .blue, .green, .cyan, .orange, .indigo, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
        
    }
}

struct Home : View {
    
    @State var show = false
    @State var search = ""
    @State var gradients : [Gradient] = []
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @State var filtered : [Gradient] = []
    
    var body: some View{
        
        ZStack {
         VStack{
          HStack(spacing: 20){
                    
                    if show{
                        
                        // Search Bar...
                        
                        TextField("Search Color", text: $search)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        // search Bar Functionality...
                        
                            .keyboardType(.decimalPad)
                            .onChange(of: search) { (value) in
                                
                                if search != "" {
                                    searchColor()
                                }
                                
                                else {
                                    
                                    // clearing all search results..
                                    search = ""
                                    filtered = gradients
                                    
                                }
                            }
                        
                        Button(action: {
                            
                            withAnimation(.easeOut){
                                
                                // clearing search...
                                search = ""
                                // safe side...
                                filtered = gradients
                                show.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
              else {
                  
                  Text("Color")
                      .padding(.leading, 4)
                      .font(.custom("DenkOne-Regular",fixedSize: 50).weight(.black))
                      .font(.title)
                      .foregroundColor(.black)
                  Spacer()
                  
                  Button(action: {
                      withAnimation(.easeOut){
                          show.toggle()
                      }
                            
                  }) {
                      Image(systemName: "magnifyingglass")
                          .font(.system(size: 20, weight: .bold))
                          .foregroundColor(.black)
                  }
                  
                  Button(action: {
                      withAnimation(.easeOut){
                          
                          if columns.count == 1{
                             columns.append(GridItem(.flexible(), spacing: 20))
                          }
                          else {
                              columns.removeLast()
                          }
                      }
                      
                  }) {
                      Image(systemName: columns.count == 1 ? "square.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                          .font(.system(size: 20, weight: .bold))
                          .foregroundColor(.black)
                  }
              }
          }
             
          .padding(.top,30)
          .padding(.bottom,10)
          .padding(.horizontal)
          .zIndex(1)
             
             // Vstack Bug..
             
             if gradients.isEmpty{
                 
                 // loading View...
                 ProgressView()
                 //.padding(.top,55)
                 
                 Spacer()
             }
             
             else {
     
                 ScrollView(.vertical, showsIndicators: false) {
                     LazyVGrid(columns: columns,spacing: 15){
                         
                         // assigning name as ID...
                         
                         ForEach(filtered,id: \.name){gradient in
                             VStack(spacing: 15){
                                 ZStack{
                                     LinearGradient(gradient: .init(colors: HEXTORGB(colors: gradient.colors)), startPoint: .top, endPoint: .bottom)
                                         .frame(height: 120)
                                         .clipShape(CShape())
                                     
                                     
                                     // context Menu...
                                     
                                         .contentShape(CShape())
                                         .shadow(color: .black, radius: 5)
                                         .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 35))
                                         .contextMenu{
                                             
                                             Button(action: {
                                                 
                                                 // copying to copy Board..
                                                 
                                                 var colorCode = ""
                                                 for color in gradient.colors {
                                                     
                                                     colorCode += color + "\n"
                                                 }
                                                 
                                                 UIPasteboard.general.string = colorCode
                                                 
                                             }) {
                                                 
                                                 Text("Copy")
                                             }
                                         }
                                     
                                     Text(gradient.name)
                                         .fontWeight(.bold)
                                         .multilineTextAlignment(.center)
                                         .foregroundColor(.white)
                                         .padding(.horizontal)
                                         .shadow(color: .black, radius: 1)
                                 }
                                 
                                 .scrollTransition(.animated.threshold(.visible(0.2))) { content, phase in
                                     
                                     content
                                         .opacity(phase.isIdentity ? 1.0 : 1.0)
                                         .scaleEffect(phase.isIdentity ? 1.0 : 0.1)
                                         .rotation3DEffect(.radians(phase.value), axis: (4, 6, 1))
                                 }
                                 
                                 if columns.count == 3{
                                     
                                     HStack(spacing: 15){
                                         ForEach(gradient.colors,id: \.self){color in
                                             Text(color)
                                                 .fontWeight(.bold)
                                                 .foregroundColor(.blue)
                                         }
                                     }
                                 }
                             }
                         }
                     }
                     
                     .padding(.top, 20)
                     .padding(.horizontal)
                     .padding(.bottom)
                     
                 }
                 
                 .zIndex(0)
                 
             }
         }
                .onAppear {
             
             getColors()
             
         }
    }
}
    
    func getColors(){
        
        // Loading JSON Data....
        
        let url = "https://raw.githubusercontent.com/OstaninOn/Secura-Gallery/hw10/Сolors.json"
        
        let seesion = URLSession(configuration: .default)
        
        seesion.dataTask(with: URL(string: url)!) { (data, _, _) in
            
            guard let jsonData = data else{return}
            
            do {
                
                // decoding Json...
                
                let colors = try JSONDecoder().decode([Gradient].self, from: jsonData)
                
                self.gradients = colors
                self.filtered = colors
            }
            catch {
                
                print(error)
            }
            
        }
        .resume()
    }
    
    // Converting HEX Number To UICOlor.....
    
    func HEXTORGB(colors: [String])->[Color] {
        
        var colors1 : [Color] = []
        
        for color in colors {
            
            // removing #...
            
            var trimmed = color.trimmingCharacters(in: .whitespaces).uppercased()
            
            trimmed.remove(at: trimmed.startIndex)
            
            var hexValue : UInt64 = 0
            Scanner(string: trimmed).scanHexInt64(&hexValue)
            
            let r = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
            let g = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
            let b = CGFloat((hexValue & 0x000000FF)) / 255
            
            colors1.append(Color(UIColor(red: r, green: g, blue: b, alpha: 1.0)))
        }
        
        return colors1
    }
    
    func searchColor() {
        
        // filtering...
        
        let query = search.lowercased()
        
        // using bg thread to reduce Main ui Usage...
        
        DispatchQueue.global(qos: .background).async {
            
            let filter = gradients.filter { (gradient) -> Bool in
                
                if gradient.name.lowercased().contains(query) {
                    
                    return true
                }
                else {
                    return false
                }
            }
            
            // Refreshing View...
            DispatchQueue.main.async {
                
                // adding animation..
                
                withAnimation(.snappy) {
                    self.filtered = filter
                }
            }
        }
    }
}

struct Gradient : Decodable {
    
    var name : String
    var colors : [String]
}

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
    
}


