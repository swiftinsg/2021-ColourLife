#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>
#include <metal_math>

extern "C" {
    namespace coreimage {
        float4 protanFilterKernel(sample_t s, float severity) {
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
                    sim = float3x3(0.856167,0.029342,-0.002880,0.182038,0.955115,-.0001563,-0.038205,0.015544,1.004443);
                    break;
                    
                case 2:
                    sim = float3x3(0.734766, 0.05184, -0.004928, 0.334872, 0.919198, -0.004209, -0.069637, 0.028963, 1.009137);
                    break;
                    //                    return;
                case 3:
                    sim = float3x3(0.630323, 0.069181, -0.006308, 0.465641, 0.890046, -0.007724, -0.095964, 0.040773, 1.014032);
                    break;
                    //                    return;
                case 4:
                    sim = float3x3(0.539009, 0.082546, -0.007136, 0.579343, 0.866121, -0.011959, -0.118352, 0.051332, 1.019095);
                    break;
                    //                    return;
                case 5:
                    sim = float3x3(0.458064, 0.092785, -0.007494, 0.679578, 0.846313, -0.016807, -0.137642, 0.060902, 1.024301);
                    break;
                    //                    return;
                case 6:
                    sim = float3x3(0.38545, 0.100526, -0.007442, 0.769005, 0.829802, -0.02219, -0.154455, 0.069673, 1.029632);
                    break;
                    //                    return;
                case 7:
                    sim = float3x3(0.319627, 0.106241, -0.007025, 0.849633, 0.815969, -0.028051, -0.169261, 0.07779, 1.035076);
                    break;
                    //                    return;
                case 8:
                    sim = float3x3(0.259411, 0.110296, -0.006276, 0.923008, 0.80434, -0.034346, -0.18242, 0.085364, 1.040622);
                    break;
                    //                    return;
                case 9:
                    sim = float3x3(0.203876, 0.112975, -0.005222, 0.990338, 0.794542, -0.041043, -0.194214, 0.092483, 1.046265);
                    break;
                    //                    return;
                case 10:
                    sim = float3x3(0.152286, 0.114503, -0.003882, 1.052583, 0.786281, -0.048116, -0.204868, 0.099216, 1.051998);
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
