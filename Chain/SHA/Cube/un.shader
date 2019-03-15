﻿Shader "Unlit/un"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_T("t", Int) = 0
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			int _T;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				// sample the texture
				float4 ret = 1;
				uint2 pixel = floor(i.vertex.xy);

				if ((pixel.x * pixel.y) % _T == 0)
				ret = 0;


				return ret;
			}
			ENDCG
		}
	}
}
