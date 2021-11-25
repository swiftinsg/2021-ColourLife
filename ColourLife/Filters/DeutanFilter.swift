//
//  Deutan.swift
//  ColourLife
//
//  Created by sap on 25/11/21.
//

import Foundation
// 1
import CoreImage

class DeutanFilter: CIFilter {
  // 2
  var inputImage: CIImage?
    var severity: Float?

  // 3
  static var kernel: CIKernel = { () -> CIColorKernel in
    guard let url = Bundle.main.url(
      forResource: "DeutanFilter.ci",
      withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIColorKernel(
      functionName: "deutanFilterKernel",
      fromMetalLibraryData: data) else {
      fatalError("Unable to create color kernel")
    }

    return kernel
  }()

    
    // 4
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        return DeutanFilter.kernel.apply(
            extent: inputImage.extent,
            roiCallback: { _, rect in
                return rect
            },
            arguments: [inputImage,severity!])
    }
}

