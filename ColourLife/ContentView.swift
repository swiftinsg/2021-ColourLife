import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    @State private var severity: Double = 0
    let types = ["Normal", "Deuteranopia","Protanopia","Tritanopia","Achromatopsia","Blue-cone monochromacy"]
    @State var buttonPressed = 0
    
    @State private var infoViewIsPresented = false
    @State private var pictureViewIsPresented = false
    
    
    let context = CIContext()
    //    @State var image = UIImage(imageLiteralResourceName: "apples-2")
    //    @State var inputImage: CGImage?
    
    func applyFilter() -> CGImage? {
        if let image = model.frame {
            switch buttonPressed {
            case 0:
                return model.frame
            case 1:
                return applyDeutanFilter(input: image)
            case 2:
                return applyProtanFilter(input: image)
            case 3:
                return applyTritanFilter(input: image)
            case 4:
                return applyAchromatFilter(input: image)
            case 5:
                return applyBCMonoFilter(input: image)
            default:
                return model.frame
            }
        } else {
            return nil
        }
    }
    
    func applyProtanFilter(input: CGImage) -> CGImage {
        let filter = ProtanFilter()
        let beginImage =  CIImage(cgImage: input)
        filter.inputImage = beginImage
        filter.severity = Float(severity)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyDeutanFilter(input: CGImage) -> CGImage {
        let filter = DeutanFilter()
        let beginImage =  CIImage(cgImage: input)
        filter.inputImage = beginImage
        filter.severity = Float(severity)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyTritanFilter(input: CGImage) -> CGImage {
        let filter = TritanFilter()
        let beginImage =  CIImage(cgImage: input)
        filter.inputImage = beginImage
        filter.severity = Float(severity)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyAchromatFilter(input: CGImage) -> CGImage {
        let filter = AchromatFilter()
        let beginImage =  CIImage(cgImage: input)
        filter.inputImage = beginImage
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyBCMonoFilter(input: CGImage) -> CGImage {
        let filter = BCMonoFilter()
        let beginImage =  CIImage(cgImage: input)
        filter.inputImage = beginImage
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    //    func loadImage() -> CGImage? {
    //        guard let inputImage = model.frame else { return model.frame}
    //
    //        let beginImage =  CIImage(cgImage: inputImage)
    //        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    //
    //        currentFilter.intensity = Float(severity)
    //
    //        guard let outputImage = currentFilter.outputImage else { return model.frame}
    //
    //        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
    //            //            let uiImage = UIImage(cgImage: cgimg)
    //            return cgimg
    //        }
    //        return model.frame
    //    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            FrameView(image:  applyFilter())
                .edgesIgnoringSafeArea(.all)
            ErrorView(error: model.error)
//            Image("apples-2")
            //            image
            //                .resizable()
            //                .edgesIgnoringSafeArea(.all)
            
            
            
            ZStack(alignment: .bottom) {
                
                Color.white
                
                VStack {
                    if (buttonPressed != 0 && buttonPressed != 4 && buttonPressed != 5) {
                        HStack(alignment: .center){
                            Text("Mild")
                                .padding()
                            Slider(value: $severity, in: 1...10,step:1)
                            //                            { _ in
                            //                                let ciContext = CIContext()
                            //                                let myImage = ciContext.createCGImage(CIImage(image: UIImage(imageLiteralResourceName: "apples-2"))!, from: CIImage(image: UIImage(imageLiteralResourceName: "apples-2"))!.extent)!
                            //
                            //                                FrameView(image:applyColorKernal(input: myImage))
                            //
                            //                            }
                            Text("Severe")
                                .padding()
                        }
                    }
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(0..<types.count) {type in
                                Button(types[type]) {
                                    buttonPressed = type
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
                            infoViewIsPresented = true
                        }
                        .sheet(isPresented: $infoViewIsPresented) {
                            ScrollView{
                                Text("\(types[buttonPressed])")
                                    .font(.system(.largeTitle))
                                    .fontWeight(.bold)
                                VStack {
                                    Text("\(info[buttonPressed])")
                                        .font(.system(size:25))
                                        .padding(20)
                                    links[buttonPressed]
                                        .padding()
                                }
                            }
                        }
                        .font(.system(size: 30))
                        .offset(x: -UIScreen.main.bounds.size.width/6)
                        
                        Button("\(Image(systemName: "camera.circle.fill"))"){
                            //picture sheet
                        }
                        .font(.system(size: 70))
                        .foregroundColor(Color.black)
                        
                        Button("\(Image(systemName: "photo.fill.on.rectangle.fill"))"){
                            pictureViewIsPresented = true
                        }
                        .fullScreenCover(isPresented: $pictureViewIsPresented) {
                            //InfoView()
                            ZStack {
                                Text("\(Image("apples-1"))")
                                VStack {
                                    Button("Save to Photos"){
                                        //request access to photos
                                    }
                                    .frame(height: 30)
                                    .padding(10)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    Button("Dismiss"){
                                        pictureViewIsPresented = false
                                    }
                                    .foregroundColor(Color.red)
                                }
                                .offset(y: UIScreen.main.bounds.size.height/2.5)
                            }
                        }
                        .font(.system(size: 30))
                        .offset(x: UIScreen.main.bounds.size.width/6)
                    }
                    .offset(y: -20)
                }
            }
            .frame(height: buttonPressed == 0 || buttonPressed == 4  || buttonPressed == 5 ? 175:220)
        }
        .frame(height: UIScreen.main.bounds.size.height)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
