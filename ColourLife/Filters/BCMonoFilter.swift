//
//  BCMonoFilter.swift
//  ColourLife
//
//  Created by sap on 25/11/21.
//

import Foundation
// 1
import CoreImage

class BCMonoFilter: CIFilter {
  // 2
  var inputImage: CIImage?

  // 3
  static var kernel: CIKernel = { () -> CIColorKernel in
    guard let url = Bundle.main.url(
      forResource: "BCMonoFilter.ci",
      withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIColorKernel(
      functionName: "BCMonoFilterKernel",
      fromMetalLibraryData: data) else {
      fatalError("Unable to createcolourkernel")
    }

    return kernel
  }()

    
    // 4
    func getOutputImage() -> CIImage? {
        guard let inputImage = inputImage else { return nil }
        return BCMonoFilter.kernel.apply(
            extent: inputImage.extent,
            roiCallback: { _, rect in
                return rect
            },
            arguments: [inputImage])
    }
}


