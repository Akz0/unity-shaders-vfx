


Shader "Om/HelloWorld"
{
    Properties
    {
        BaseColor ("Base Color",Color) = (1,1,1,1)
    }

    SubShader{
        Tags{
            "RenderType" = "Opaque"
            "Queue" = "Geometry"
            "RenderPipeline" = "UniversalPipeline"
        }
        Pass{
        
            Tags{
                "LightMode" = "UniversalForward"
             
            }
    
            HLSLPROGRAM
            
                #pragma vertex VertMain
                #pragma fragment FragMain
            
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

                struct appData{
                    float4 positions : POSITION;
                };

                struct VertexOutput{
                    float4 positionCS : SV_POSITION;
                };

                CBUFFER_START (UnityPerMaterial)
                    float4 BaseColor;
                CBUFFER_END

                VertexOutput VertMain( appData V){
                    VertexOutput o;
                    o.positionCS = TransformObjectToHClip(V.positions);

                    return o;
                }

                float4 FragMain(VertexOutput V):SV_TARGET{
                    return BaseColor;
                }

            ENDHLSL
        }
    }


    



    Fallback "Unlit/Color"
}



