Shader "Unlit/HeightMapCubes"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_TiempoEscala("_TiempoEscala", float) = 1
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

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float _TiempoEscala;

            v2f vert (appdata v)
            {
				v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.uv.x += _SinTime * _TiempoEscala * v.color;
				half4 height = tex2D(_MainTex, o.uv,0,0);
				o.vertex.y += height;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                
                
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
