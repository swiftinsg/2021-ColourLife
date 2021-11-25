//
//  TritanFilter.ci.metal
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
        float4 colorFilterKernel(sample_t s, float severity) {
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
                    sim = float3x3(0.92667, 0.021191, 0.008437, 0.092514, 0.964503, 0.054813, -0.019184, 0.014306, 0.93675);
                    break;
                    
                case 2:
                    sim = float3x3(0.89572, 0.029997, 0.013027, 0.13333, 0.9454, 0.104707, -0.02905, 0.024603, 0.882266);
                    break;
                    //                    return;
                case 3:
                    sim = float3x3(0.905871, 0.026856, 0.01341, 0.127791, 0.941251, 0.148296, -0.033662, 0.031893, 0.838294);
                    break;
                    //                    return;
                case 4:
                    sim = float3x3(0.948035, 0.014364, 0.010853, 0.08949, 0.946792, 0.193991, -0.037526, 0.038844, 0.795156);
                    break;
                    //                    return;
                case 5:
                    sim = float3x3(1.017277, -0.006113, 0.006379, 0.027029, 0.958479, 0.248708, -0.044306, 0.047634, 0.744913);
                    break;
                    //                    return;
                case 6:
                    sim = float3x3(1.104996, -0.032137, 0.001336, -0.046633, 0.971635, 0.317922, -0.058363, 0.060503, 0.680742);
                    break;
                    //                    return;
                case 7:
                    sim = float3x3(1.193214, -0.058496, -0.002346, -0.109812, 0.97941, 0.403492, -0.083402, 0.079086, 0.598854);
                    break;
                    //                    return;
                case 8:
                    sim = float3x3(1.257728, -0.078003, -0.003316, -0.139648, 0.975409, 0.501214, -0.118081, 0.102594, 0.502102);
                    break;
                    //                    return;
                case 9:
                    sim = float3x3(1.278864, -0.084748, -0.000989, -0.125333, 0.957674, 0.601151, -0.153531, 0.127074, 0.399838);
                    break;
                    //                    return;
                case 10:
                    sim = float3x3(1.255528, -0.078411, 0.004733, -0.076749, 0.930809, 0.691367, -0.178779, 0.147602, 0.3039);
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

