Shader "Om/TextureShaderExample"
{
    Properties
    {
        BaseColor ("Base Color",Color) = (1,1,1,1)
        BaseTex ("Base Texture",2D) = "white"{}
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
                    float2 textureUV : TEXCOORD0;
                };

                struct VertexOutput{
                    float4 positionCS : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                sampler2D BaseTex;
                CBUFFER_START (UnityPerMaterial)
                    float4 BaseColor;
                    float4 BaseTex_ST;
                CBUFFER_END

                VertexOutput VertMain( appData V){
                    VertexOutput o;
                    o.positionCS = TransformObjectToHClip(V.positions);
                    o.uv = TRANSFORM_TEX(V.textureUV, BaseTex);
                    return o;
                }

                float4 FragMain(VertexOutput V):SV_TARGET{
                    
                    float4 textureSample = tex2D(BaseTex,V.uv);
                    return textureSample * BaseColor;
                }

            ENDHLSL
        }
    }


    



    Fallback "Unlit/Color"
}



