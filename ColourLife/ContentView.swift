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
    
    @State private var currentFilter = DeutanFilter()
    let context = CIContext()
    
    //    @State private var processedImage: UIImage?
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    @State var isUsingOwnImage = false
    
    func applyFilter() -> CGImage? {
        let ciContext = CIContext()
        let myImage = ciContext.createCGImage(CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!, from: CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!.extent)!
        switch buttonPressed {
        case 0:
            //            image = UIImage(model.frame)
            return model.frame
            
        case 1:
            return applyDeutanFilter(input: myImage)
            //            currentFilter = DeutanFilter()
        case 2:
            return applyProtanFilter(input: myImage)
            //            currentFilter = ProtanFilter()
        case 3:
            return applyTritanFilter(input: myImage)
            //            currentFilter = TritanFilter()
        case 4:
            return applyAchromatFilter(input: myImage)
        case 5:
            return applyBCMonoFilter(input: myImage)
        default:
            //            return loadImage()
            return myImage

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
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    //func transferImage() {
    //    processedImage = FrameView.image
    //}
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            FrameView(image: applyFilter())
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
                            Slider(value: $severity, in: 1...10,step:1)
                            Text("Severe")
                        }
                    }
                    ScrollView(.horizontal){
                        LazyHStack{
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
                        .font(.system(size: 30))
                        .offset(x: -UIScreen.main.bounds.size.width/6)
                        .sheet(isPresented: $infoViewIsPresented) {
                            ScrollView{
                                VStack {
                                    Spacer()
                                    Text("\(types[buttonPressed])")
                                        .font(.system(.largeTitle))
                                        .fontWeight(.bold)
                                        .padding()
                                    Text("\(info[buttonPressed])")
                                        .font(.system(size:25))
                                        .padding(20)
                                    links[buttonPressed]
                                        .font(.system(size:25))
                                        .padding()
                                }
                            }
                        }
                        
                        Button("\(Image(systemName: "camera.circle.fill"))"){
                            loadImage()
                        }
                        .font(.system(size: 70))
                        .foregroundColor(Color.black)
                        //.fullScreenCover(isPresented: $pictureViewIsPresented) {
                        //    ZStack {
                        //        inputImage
                        //            .edgesIgnoringSafeArea(.all)
                        //
                        //        VStack {
                        //            Button("Save to Photos"){
                        //                loadImage()
                        //                pictureViewIsPresented = false
                        //            }
                        //            .frame(height: 30)
                        //            .padding(10)
                        //            .background(Color.blue)
                        //            .foregroundColor(Color.white)
                        //            .cornerRadius(15)
                        //            Button("Dismiss"){
                        //                pictureViewIsPresented = false
                        //            }
                        //            .frame(height: 30)
                        //            .padding(10)
                        //            .background(Color.red)
                        //            .foregroundColor(.white)
                        //            .cornerRadius(10)
                        //
                        //        }
                        //        .offset(y: UIScreen.main.bounds.size.height/4)
                        //    }
                        //}
                        
                        Button("\(Image(systemName: "photo.fill.on.rectangle.fill"))"){
                            self.showingImagePicker = true
                        }
                        .font(.system(size: 30))
                        .offset(x: UIScreen.main.bounds.size.width/6)
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: self.$inputImage)
                        }
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
