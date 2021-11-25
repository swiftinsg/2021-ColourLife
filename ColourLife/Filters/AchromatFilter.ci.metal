//
//  AchromatFilter.ci.metal
//  ColourLife
//
//  Created by sap on 25/11/21.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>
#include <metal_math>

extern "C" {
    namespace coreimage {
        float4 achromatFilterKernel(sample_t s) {
            //      float4 swappedColor;
            //      swappedColor.r = s.g;
            //      swappedColor.g = s.b;
            //      swappedColor.b = s.r;
            //      swappedColor.a = s.a;
            float3 pix;
            //            pix.r = s.r;
            //            pix.g = s.g;
            //            pix.b = s.b;
            for (int i = 0; i < 3; ++i) {
                if (s[i] <= 0.04045) {
                    pix[i] = s[i] / 12.92;
                } else {
                    pix[i] = pow((s[i] + 0.055) / 1.055,2.4);
                }
            }
            float3 sim;
            sim = float3(0.212656,0.715158,0.072186);
            float w = dot(sim,pix);
            for (int i = 0; i < 3; ++i) {
                pix[i] = w;
            }
            float4 res;
            
            for (int i = 0; i < 3; ++i) {
                if (pix[i] <= 0.0031308) {
                    res[i] = pix[i] * 12.92;
                } else {
                    res[i] = (pow(pix[i],0.41666) * 1.055 - 0.055);
                }
            }
            //            res.r = pix.r;
            //            res.g = pix.g;
            //            res.b = pix.b;
            res.a = s.a;
            
            return res;
        }
    }
}


