//
//  AchromatFilter.swift
//  ColourLife
//
//  Created by sap on 25/11/21.
//

import Foundation
// 1
import CoreImage

class AchromatFilter: CIFilter {
  // 2
  var inputImage: CIImage?

  // 3
  static var kernel: CIKernel = { () -> CIColorKernel in
    guard let url = Bundle.main.url(
      forResource: "AchromatFilter.ci",
      withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIColorKernel(
      functionName: "achromatFilterKernel",
      fromMetalLibraryData: data) else {
      fatalError("Unable to createcolourkernel")
    }

    return kernel
  }()

    
    // 4
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        return AchromatFilter.kernel.apply(
            extent: inputImage.extent,
            roiCallback: { _, rect in
                return rect
            },
            arguments: [inputImage])
    }
}

