//
//  DeutanFilter.ci.metal
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
        float4 deutanFilterKernel(sample_t s, float severity) {
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
            float3x3 sim;
            switch (int(severity)) {
                case 1:
                    sim = float3x3(0.866435, 0.049567, -0.003453, 0.177704, 0.939063, 0.007233, -0.044139, 0.01137, 0.99622);
                    break;
                    
                case 2:
                    sim = float3x3(0.760729, 0.090568, -0.006027, 0.319078, 0.889315, 0.013325, -0.079807, 0.020117, 0.992702);
                    break;
                    //                    return;
                case 3:
                    sim = float3x3(0.675425, 0.125303, -0.00795, 0.43385, 0.847755, 0.018572, -0.109275, 0.026942, 0.989378);
                    break;
                    //                    return;
                case 4:
                    sim = float3x3(0.605511, 0.155318, -0.009376, 0.52856, 0.812366, 0.023176, -0.134071, 0.032316, 0.9862);
                    break;
                    //                    return;
                case 5:
                    sim = float3x3(0.547494, 0.181692, -0.01041, 0.607765, 0.781742, 0.027275, -0.155259, 0.036566, 0.983136);
                    break;
                    //                    return;
                case 6:
                    sim = float3x3(0.498864, 0.205199, -0.011131, 0.674741, 0.754872, 0.030969, -0.173604, 0.039929, 0.980162);
                    break;
                    //                    return;
                case 7:
                    sim = float3x3(0.457771, 0.226409, -0.011595, 0.731899, 0.731012, 0.034333, -0.18967, 0.042579, 0.977261);
                    break;
                    //                    return;
                case 8:
                    sim = float3x3(0.422823, 0.245752, -0.011843, 0.781057, 0.709602, 0.037423, -0.203881, 0.044646, 0.974421);
                    break;
                    //                    return;
                case 9:
                    sim = float3x3(0.392952, 0.263559, -0.01191, 0.82361, 0.69021, 0.040281, -0.216562, 0.046232, 0.97163);
                    break;
                    //                    return;
                case 10:
                    sim = float3x3(0.367322, 0.280085, -0.01182, 0.860646, 0.672501, 0.04294, -0.227968, 0.047413, 0.968881);
                    break;
            }
            
            
            //            float3x3 t = float3x3(0.31399022,0.15537241,0.01775239,0.63951294,0.75789446,0.10944209,0.04649755,0.08670142,0.87256922);
            //            float3x3 invT = float3x3(5.47221206,-1.1252419,0.02980165,-4.6419601,2.29317094,-0.19318073,0.16963708,-0.1678952,1.16364789);
            //            sim = float3x3(0,0,0,1.0511829,1,0,-0.05116099,0,1);
            
            //            pix = t * pix;
            pix = sim * pix;
            //            pix = invT * pix;
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

