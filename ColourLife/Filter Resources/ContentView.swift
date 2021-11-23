//
//  ContentView.swift
//  ColourLife
//
//  Created by sap on 19/11/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins



struct ContentView: View {
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State var image = Image("apples")
    @State var inputImage: Optional<UIImage>
    @State var present = true
    
    func applyProcessing() {
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
//        guard let inputImage = inputImage else { return }
//            image = Image(uiImage: inputImage)
    }
    
    @StateObject private var model = ContentViewModel()
    
    var body: some View {
        
        //            FrameView(image: model.frame)
        //                .edgesIgnoringSafeArea(.all)
        //            ErrorView(error: model.error)
        
        
        
        
        VStack {
            Text("hi")
            image
                .resizable()
                .scaledToFill()
        }
        .sheet(isPresented: $present, onDismiss: loadImage) {
            Text("not hi")
        }
        .onAppear {
            inputImage = UIImage(imageLiteralResourceName: "apples")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(image: Image("apples"), inputImage:nil)
    }
}

