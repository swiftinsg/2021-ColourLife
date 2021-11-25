import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    @State private var severity: Double = 0
    let types = ["Normal", "Deuteranopia","Protanopia","Tritanopia","Achromatopsia"]
    @State var buttonPressed = 0
    
    @State private var infoViewIsPresented = false
    @State private var pictureViewIsPresented = false
    let info = [
        "It is estimated that a person with normal color vision can see up to 1 million distinct shades of color, but a person who is color blind may see as few as just 10 thousand colors (1% of the normal range)",
        "A person with deutan color vision deficiency may experience confusions between colors such as green and yellow, or blue and purple. Another common symptom is that green traffic signals appear to be a very pale green or sometimes white. Common color confusion also occurs between pink and gray or white, especially if the pink is similar to a light purple.",
        "A person with protan type color blindness tends to see greens, yellows, oranges, reds, and browns as being more similar shades of color than normal, especially in low light. A very common problem is that purple colors look more like blue. Another common issue is that pink colors appear to be gray, especially if the pink is a more reddish pink or salmon color. Another symptom specific to protan color vision deficiency is that red colors look darker than normal. For example, if red text is printed on a black background, it can be very hard to read because the red appears to be very dark.",
        "Typically a person with a tritan-type color vision deficiency does not see blue colors well, and may have difficulty seeing the difference between blue and green. Cataracts, glaucoma, and age-related macular degeneration can cause symptoms of tritan color blindness. Another factor that causes reduced sensitivity to blue is the yellowing of the crystalline lens within the eye: these cells do not regenerate and over a lifetime of exposure to light, especially UV light, the lens tends to become yellow in appearance and block the transmission of blue light, interfering with color vision. Eventually this yellowing also leads to cataracts that must be treated surgically.",
        "Similar to other forms of color blindness, achromatopsia can be graded as incomplete (partial) achromatopsia or complete achromatopsia (total color blindness). Achromatopsia is often associated with light sensitivity, photophobia, and glare sensitivity. In some cases, low vision disorders such as progressive cone dystrophy or retinitis pigmentosa can cause a gradual deterioration of color vision that eventually turns into complete achromatopsia."
    ]
    let links = [
        Link("More about Normal Vision",
             destination: URL(string: "https://enchroma.com/blogs/beyond-color/how-color-blind-see")!),
        Link("More about Deuteranopia",
             destination: URL(string: "https://enchroma.com/pages/deutan")!),
        Link("More about Protanopia",
             destination: URL(string: "https://enchroma.com/pages/protan")!),
        Link("More about Tritanopia",
             destination: URL(string: "https://enchroma.com/blogs/beyond-color/how-color-blind-see")!),
        Link("More about Achromatopsia",
             destination: URL(string: "https://enchroma.com/blogs/beyond-color/how-color-blind-see")!)
    ]
    
    @State private var currentFilter = DeutanFilter()
    let context = CIContext()
    //    @State var image = UIImage(imageLiteralResourceName: "apples-2")
    //    @State var inputImage: CGImage?
    
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
        default:
            //            return loadImage()
            return myImage
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
            //                        ErrorView(error: model.error)
            //                            Image("apples-2")
            //            image
            //                .resizable()
            //                .edgesIgnoringSafeArea(.all)
            
            
            
            ZStack(alignment: .bottom) {
                
                Color.white
                
                VStack {
                    if (buttonPressed != 0 && buttonPressed != 4) {
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
            .frame(height: buttonPressed == 0 || buttonPressed == 4 ? 175:220)
        }
        .frame(height: UIScreen.main.bounds.size.height)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
