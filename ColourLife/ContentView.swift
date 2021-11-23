import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    @State private var severity: Double = 0
//    @State var toggle1: Bool = true
//    @State var toggle2: Bool = false
//    @State var toggle3: Bool = false
//    @State var toggle4: Bool = false
//    @State var toggle5: Bool = false
    let types = ["Normal", "Deuteranopia","Protanopia","Tritanopia","Achromatopsia"]
    @State var buttonPressed = 0
    
    var body: some View {
        ZStack {
            
            ZStack {
                //            FrameView(image: model.frame)
                //                .edgesIgnoringSafeArea(.all)
                //            ErrorView(error: model.error)
                Image("apples-2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
            
            ZStack {
                
                Color.white
                
                VStack{
                    HStack(alignment: .center){
                        Text("Mild")
                            .padding()
                        Slider(value: $severity, in: 0...20)
                        Text("Severe")
                            .padding()
                    }
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(0..<types.count) {type in
                                Button(types[type]) {
                                    buttonPressed = type
                                    //filterFunction(type)
                                }
                                .frame(height: 30)
                                .padding(10)
                                .background(buttonPressed==type ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
                                .foregroundColor(buttonPressed==type ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
                                .cornerRadius(15)

                                
                            }
//                            Button("Normal"){
//                                //no filter
//                                toggle1 = true
//                                toggle2 = false
//                                toggle3 = false
//                                toggle4 = false
//                                toggle5 = false
//                            }
//                            .frame(height: 30)
//                            .padding(10)
//                            .background(toggle1 ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
//                            .foregroundColor(toggle1 ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
//                            .cornerRadius(15)
//
//                            Button("Deutanopia"){
//                                //Deutanopia filter
//                                toggle1 = false
//                                toggle2 = true
//                                toggle3 = false
//                                toggle4 = false
//                                toggle5 = false
//                            }
//                            .frame(height: 30)
//                            .padding(10)
//                            .background(toggle2 ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
//                            .foregroundColor(toggle2 ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
//                            .cornerRadius(15)
//
//                            Button("Protanopia"){
//                                //Protanopia filter
//                                toggle1 = false
//                                toggle2 = false
//                                toggle3 = true
//                                toggle4 = false
//                                toggle5 = false
//                            }
//                            .frame(height: 30)
//                            .padding(10)
//                            .background(toggle3 ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
//                            .foregroundColor(toggle3 ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
//                            .cornerRadius(15)
//
//                            Button("Tritanopia"){
//                                //Tritanopia filter
//                                toggle1 = false
//                                toggle2 = false
//                                toggle3 = false
//                                toggle4 = true
//                                toggle5 = false
//                            }
//                            .frame(height: 30)
//                            .padding(10)
//                            .background(toggle4 ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
//                            .foregroundColor(toggle4 ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
//                            .cornerRadius(15)
//
//                            Button("Achromatopsia"){
//                                //Achromatopsia filter
//                                toggle1 = false
//                                toggle2 = false
//                                toggle3 = false
//                                toggle4 = false
//                                toggle5 = true
//                            }
//                            .frame(height: 30)
//                            .padding(10)
//                            .background(toggle5 ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
//                            .foregroundColor(toggle5 ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
//                            .cornerRadius(15)
                        }
                        .offset(x:15)
                    }
                    
                    HStack{
                        Button("\(Image(systemName: "questionmark.circle.fill"))"){
                            //info sheet
                        }
                        .font(.system(size: 30))
                        .offset(x: -90)
                        
                        Button("\(Image(systemName: "camera.circle.fill"))"){
                            //picture sheet
                        }
                        .font(.system(size: 70))
                        .foregroundColor(Color.black)
                        
                        Button("\(Image(systemName: "photo.fill.on.rectangle.fill"))"){
                            //photos app
                        }
                        .font(.system(size: 30))
                        .offset(x: 90)
                    }
                    .offset(y: -20)
                }
            }
            .frame(height: 220)
            .offset(y: 310)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
