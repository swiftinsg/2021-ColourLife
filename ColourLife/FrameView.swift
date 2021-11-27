//
//  FrameView.swift
//  ColourLife
//
//  Created by sap on 22/11/21.
//

import SwiftUI

struct FrameView: View {
    @Binding var image: CGImage?
    private let label = Text("Camera Feed")
    
    var body: some View {
        // 1
        if let image = image {
          // 2
          GeometryReader { geometry in
            // 3
            Image(image, scale: 1.0, orientation: .up, label: label)
              .resizable()
              .scaledToFill()
              .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center)
              .clipped()
          }
        } else {
          // 4
          Text("Oops! Something has gone wrong")
        }

    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView(image: .constant(nil) )
    }
}
