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
    
    // ahhhhhhhhhh
    @State var savedImage: CGImage?
    //    let imageSaver = ImageSaver()
    
    //    @State private var currentFilter = DeutanFilter()
    let context = CIContext()
    let protanFilter = ProtanFilter()
    let deutanFilter = DeutanFilter()
    let tritanFilter = TritanFilter()
    let achromatFilter = AchromatFilter()
    let bcMonoFilter = BCMonoFilter()
    
    //    @State private var processedImage: UIImage?
    //    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    @State var isUsingOwnImage = false
    @State var hideUI = false
    
    func applyFilter() -> CGImage? {
        /*
         //let ciContext = CIContext()
         let myImage = context.createCGImage(CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!, from: CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!.extent)!
         switch buttonPressed {
         case 0:
         //            image = UIImage(model.frame)
         return model.frame
         
         case 1:
         return applyDeutanFilter(input: model.frame)
         //            currentFilter = DeutanFilter()
         case 2:
         return applyProtanFilter(input: model.frame)
         //            currentFilter = ProtanFilter()
         case 3:
         return applyTritanFilter(input: model.frame)
         //            currentFilter = TritanFilter()
         case 4:
         return applyAchromatFilter(input: model.frame)
         case 5:
         return applyBCMonoFilter(input: model.frame)
         default:
         //            return loadImage()
         return model.frame
         */
        var myImage: CGImage?
        if isUsingOwnImage { myImage = inputImage?.cgImage }
        else { myImage = context.createCGImage(CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!, from: CIImage(image: UIImage(imageLiteralResourceName: "grocery_store"))!.extent)}
        if let image = myImage {
            switch buttonPressed {
            case 0:
                return image
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
                return image
            }
        } else {
            return nil
        }
    }
    
    func applyProtanFilter(input: CGImage) -> CGImage {
        let beginImage =  CIImage(cgImage: input)
        protanFilter.inputImage = beginImage
        protanFilter.severity = Float(severity)
        if let outputImage = protanFilter.getOutputImage() {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyDeutanFilter(input: CGImage) -> CGImage {
        let beginImage =  CIImage(cgImage: input)
        deutanFilter.inputImage = beginImage
        deutanFilter.severity = Float(severity)
        if let outputImage = deutanFilter.getOutputImage() {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyTritanFilter(input: CGImage) -> CGImage {
        let beginImage =  CIImage(cgImage: input)
        tritanFilter.inputImage = beginImage
        tritanFilter.severity = Float(severity)
        if let outputImage = tritanFilter.getOutputImage() {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyAchromatFilter(input: CGImage) -> CGImage {
        let beginImage =  CIImage(cgImage: input)
        achromatFilter.inputImage = beginImage
        if let outputImage = achromatFilter.getOutputImage() {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    func applyBCMonoFilter(input: CGImage) -> CGImage {
        let beginImage =  CIImage(cgImage: input)
        bcMonoFilter.inputImage = beginImage
        if let outputImage = bcMonoFilter.getOutputImage() {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return cgimg
            }
        }
        return input
    }
    
    func saveImage(inputImage: CGImage?) {
        //        guard let inputImage = inputImage else {
        //            isUsingOwnImage = false
        //            return
        //
        //        }
        //        let image = UIImage(cgImage: inputImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: UIImage(cgImage: inputImage!))
    }
    
    func loadImage() {
        guard inputImage != nil else {
            isUsingOwnImage = false
            return
        }
        isUsingOwnImage = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            FrameView(image: .constant(applyFilter()))
                .edgesIgnoringSafeArea(.all)
            
            ErrorView(error: model.error)
            
            ZStack(alignment: .bottom) {
                
                Color.white
                .opacity(hideUI ? 0.0 : 1.0)
                
                HStack {
                    Button("\(Image(systemName: "camera"))"){
                        isUsingOwnImage = false
                    }
                    .opacity(isUsingOwnImage ? 1.0 : 0.0)
                    .font(.system(size:25))
                    .padding(13)
                    .foregroundColor(.blue)
                    .offset(x: -UIScreen.main.bounds.size.width/3.3)
                    
                    Text("")
                    
                    Button("\(Image(systemName: hideUI ? "eye" : "eye.slash"))"){
                        hideUI.toggle()
                    }
                    .font(.system(size:25))
                    .padding(13)
                    .foregroundColor(.blue)
                    .offset(x: UIScreen.main.bounds.size.width/3.3)
                }
            }
            .offset(y: -UIScreen.main.bounds.size.height/1.1)
            .edgesIgnoringSafeArea(.top)
            .frame(height: 170)
            
            ZStack(alignment: .bottom) {
                
                Color.white
                
                VStack(spacing: 1) {
                    if (buttonPressed != 0 && buttonPressed != 4 && buttonPressed != 5) {
                        HStack(alignment: .center){
                            Text("Mild")
                                .padding(.horizontal)
                            Slider(value: $severity, in: 1...10,step:1)
                            Text("Severe")
                                .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
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
                    .offset(y: -7)
                    
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
                        
                        Button("\(Image(systemName: isUsingOwnImage ? "square.and.arrow.down" : "camera.circle.fill"))"){
                            savedImage = applyFilter()
                            pictureViewIsPresented = true
                            //                            loadImage(inputImage: savedImage!)
                        }
                        .font(.system(size: isUsingOwnImage ? 60 : 70))
                        .foregroundColor(Color.black)
                        .fullScreenCover(isPresented: $pictureViewIsPresented) {
                            ZStack {
                                
                                if (savedImage != nil){
                                    FrameView(image: $savedImage)
                                        .edgesIgnoringSafeArea(.all)
                                }
                                VStack {
                                    Button("Save to Photos"){
                                        saveImage(inputImage: savedImage)
                                        pictureViewIsPresented = false
                                    }
                                    .frame(height: 30)
                                    .padding(10)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    Button("Dismiss"){
                                        pictureViewIsPresented = false
                                    }
                                    .frame(height: 30)
                                    .padding(10)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    
                                }
                                .offset(y: UIScreen.main.bounds.size.height/2.75)
                            }
                        }
                        // yeet i thought @Binding fixed it but it didnt
                        if savedImage != nil {
                            EmptyView()
                        }
                        
                        Button("\(Image(systemName: "photo.fill.on.rectangle.fill"))"){
                            self.showingImagePicker = true
                        }
                        .font(.system(size: 30))
                        .offset(x: UIScreen.main.bounds.size.width/6)
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage)
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: -23)
                }
            }
            .frame(height: buttonPressed == 0 || buttonPressed == 4  || buttonPressed == 5 ? 175:220)
            .opacity(hideUI ? 0.0 : 1.0)
        }
        .frame(height: UIScreen.main.bounds.size.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
