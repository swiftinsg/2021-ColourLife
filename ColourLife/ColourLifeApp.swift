//
//  ColourLifeApp.swift
//  ColourLife
//
//  Created by sap on 19/11/21.
//

import SwiftUI

@main
struct ColourLifeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(image:Image("apples"), inputImage: UIImage(imageLiteralResourceName: "apples"))
        }
    }
}
