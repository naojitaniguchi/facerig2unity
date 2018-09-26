Shader "Unlit/ChromakeyUnlit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_KeyColor("Key Color", Color) = (0,1,0)

		_Near("Near", Range(0, 2)) = 0.2

	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
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

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed3 _KeyColor;

			fixed _Near;

			
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
				//fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);


				fixed4 c = tex2D(_MainTex, i.uv);

				clip(distance(_KeyColor, c) - _Near);

				//o.Albedo = c.rgb;

				//o.Alpha = c.a;


				return c;
			}
			ENDCG
		}
	}
}
