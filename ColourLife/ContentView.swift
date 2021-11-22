//
//  ContentView.swift
//  ColourLife
//
//  Created by sap on 19/11/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    
    var body: some View {
        ZStack {
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
            ErrorView(error: model.error)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
