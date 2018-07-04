Shader "Nick/MixTex"
{
	Properties
	{
		_MainTex1("Texture1", 2D) = "white" {}
		_MainTex2("Texture2", 2D) = "white" {}
		_Mix("Mix", Range(0, 1)) = 0.5
		_Flicker("Flicker", Range(0, 1)) = 0.5
		_Glow("Glow", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
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
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex1;
			sampler2D _MainTex2;
			float4 _MainTex_ST;
			float _Mix;
			float _Flicker;
			float _Glow;

			float rand(float val) {
				return frac(sin(dot(float3(val, val, val), float3(12.9898, 78.233, 45.5432))) * 43758.5453);
			}

			float randVec(float3 val) {
				return frac(sin(dot(val, float3(12.9898, 78.233, 45.5432))) * 43758.5453);
			}

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col1 = tex2D(_MainTex1, i.uv);
				fixed4 col2 = tex2D(_MainTex2, i.uv);
				
				_Mix += rand(_Flicker) - (_Flicker/2.0);
				//fixed4 col = (col1 * _Mix) + (col2 * (1.0 - _Mix));
				fixed4 col = lerp(col1, col2, _Mix);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col); 
				return col + (col * _Glow);
			}
			ENDCG
		}
	}
}
