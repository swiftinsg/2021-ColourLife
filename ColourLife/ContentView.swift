import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

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
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State var image = Image("apples-2")
    @State var inputImage = UIImage(imageLiteralResourceName: "apples-2")
    
    func applyFilter() {
        switch buttonPressed {
        case 0:
            image = Image(uiImage: inputImage)
        default:
            loadImage()
        }
    }
    
    func applyProcessing() {
        
        currentFilter.intensity = Float(severity)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func loadImage() {
        //        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.severity
            },
            set: {
                self.severity = $0
                self.applyProcessing()
            }
        )
        ZStack(alignment: .bottom) {
            
            //            FrameView(image: model.frame)
            //                .edgesIgnoringSafeArea(.all)
            //            ErrorView(error: model.error)
            //                Image("apples-2")
            image
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            
            
            ZStack(alignment: .bottom) {
                
                Color.white
                
                VStack {
                    if (buttonPressed != 0) {
                        HStack(alignment: .center){
                            Text("Mild")
                                .padding()
                            Slider(value: intensity, in: 0...20) {_ in
                                applyProcessing()
                            }
                            Text("Severe")
                                .padding()
                        }
                    }
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(0..<types.count) {type in
                                Button(types[type]) {
                                    buttonPressed = type
                                    applyFilter()
                                    //filterFunction(type)
                                }
                                .frame(height: 30)
                                .padding(10)
                                .background(buttonPressed==type ? Color.blue : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.3))
                                .foregroundColor(buttonPressed==type ? Color.white : Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.5))
                                .cornerRadius(15)
                                
                                
                            }
                        }
                        .padding(.horizontal,10)
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
            .frame(height: buttonPressed == 0 ? 175:220)
        }
        .frame(height: UIScreen.main.bounds.size.height)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(image: Image("apples-1"))
    }
}
