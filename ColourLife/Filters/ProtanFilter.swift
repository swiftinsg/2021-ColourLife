//
//  ColorFilter.swift
//  ColourLife
//
//  Created by sap on 24/11/21.
//

import Foundation
// 1
import CoreImage

class ProtanFilter: CIFilter {
  // 2
  var inputImage: CIImage?
    var severity: Float?

  // 3
  static var kernel: CIKernel = { () -> CIColorKernel in
    guard let url = Bundle.main.url(
      forResource: "ProtanFilter.ci",
      withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIColorKernel(
      functionName: "protanFilterKernel",
      fromMetalLibraryData: data) else {
      fatalError("Unable to create color kernel")
    }

    return kernel
  }()

    
    // 4
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        return ProtanFilter.kernel.apply(
            extent: inputImage.extent,
            roiCallback: { _, rect in
                return rect
            },
            arguments: [inputImage,severity!])
    }
}

