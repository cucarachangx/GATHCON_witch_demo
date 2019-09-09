// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/Templates/Unlit"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Distortion_Factor("Distortion_Factor", Float) = 0
		_DistortionScale("Distortion Scale", Float) = 0
		_Speed("Speed", Float) = 1.09
		_UV_Offset_Noise("UV_Offset_Noise", Float) = 1
		_Color_INT("Color_INT", Color) = (0.007842897,0,0.9999692,0)
		[HDR]_Color_EXT("Color_EXT", Color) = (0,1,0.9680035,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color_EXT;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _TextureSample1;
		uniform float _DistortionScale;
		uniform float _Speed;
		uniform float _UV_Offset_Noise;
		uniform sampler2D _TextureSample2;
		uniform float _Distortion_Factor;
		uniform float4 _TextureSample0_ST;
		uniform float4 _Color_INT;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_27_0 = ( _Time.y * ( _DistortionScale * _Speed ) );
			float2 uv_TexCoord2 = i.uv_texcoord * float2( 3,3 );
			float2 temp_output_26_0 = ( uv_TexCoord2 * _DistortionScale );
			float2 panner9 = ( temp_output_27_0 * float2( 0.5,-1 ) + temp_output_26_0);
			float2 panner13 = ( temp_output_27_0 * float2( 0.7,-1.5 ) + temp_output_26_0);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 appendResult40 = (float2(i.uv_texcoord.x , ( i.uv_texcoord.y + ( ( ( ( pow( tex2D( _TextureSample1, ( panner9 + _UV_Offset_Noise ) ).g , 5.0 ) + pow( tex2D( _TextureSample2, ( _UV_Offset_Noise + panner13 ) ).r , 5.0 ) ) * 0.3333 ) * _Distortion_Factor ) * ( i.uv_texcoord.y * tex2D( _TextureSample0, uv_TextureSample0 ).a ) ) )));
			float4 tex2DNode18 = tex2D( _TextureSample0, appendResult40 );
			float4 temp_output_22_0 = ( ( _Color_EXT * tex2DNode18.r ) + ( _Color_INT * tex2DNode18.g ) );
			o.Albedo = temp_output_22_0.rgb;
			o.Emission = temp_output_22_0.rgb;
			o.Alpha = ( ( 1.0 - tex2DNode18.b ) * tex2D( _TextureSample0, uv_TextureSample0 ).a );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
1921;1;1022;704;1292.915;-76.91241;1.586744;False;False
Node;AmplifyShaderEditor.RangedFloatNode;30;-2224.618,785.574;Float;False;Property;_Speed;Speed;5;0;Create;True;0;0;False;0;1.09;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2096.433,475.4503;Float;False;Property;_DistortionScale;Distortion Scale;4;0;Create;True;0;0;False;0;0;0.73;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1892.618,630.574;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2243.78,3.822215;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;3,3;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;31;-1878.618,459.574;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1739.161,132.3403;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1611.661,540.7402;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1380.618,364.574;Float;False;Property;_UV_Offset_Noise;UV_Offset_Noise;6;0;Create;True;0;0;False;0;1;1.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-1383.39,143.1685;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;13;-1351.11,519.9032;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.7,-1.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-1148.618,496.574;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-1148.618,160.574;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-1006.19,467.6678;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;7ed8e2e495422814a8e2d49cb2bf29c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1013.284,117.9109;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;641cf02b46150004099cf11b4753918d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;8;-716.2837,139.9109;Float;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;14;-714.9903,506.6679;Float;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-393.1575,239.3643;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-298.6177,696.574;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-128.6177,235.574;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3333;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-298.1581,842.6476;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;dadd215e546bd2147baf7817ce284834;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-334.8806,524.3929;Float;False;Property;_Distortion_Factor;Distortion_Factor;3;0;Create;True;0;0;False;0;0;-5.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;45.71567,205.9108;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;115.3823,665.574;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;216.5575,38.11563;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;324.3823,347.574;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;627.2886,369.7158;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;671.3745,104.6531;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;47;801.2874,-607.9315;Float;False;Property;_Color_EXT;Color_EXT;8;1;[HDR];Create;True;0;0;False;0;0,1,0.9680035,0;0.4355464,1.118678,1.231144,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;48;760.2802,-324.5652;Float;False;Property;_Color_INT;Color_INT;7;0;Create;True;0;0;False;0;0.007842897,0,0.9999692,0;0,0.5247078,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;902.0474,-17.85716;Float;True;Property;_TextureSample3;Texture Sample 3;0;0;Create;True;0;0;False;0;None;dadd215e546bd2147baf7817ce284834;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;1280.146,-340.4389;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;43;1121.409,467.8009;Float;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;False;0;None;dadd215e546bd2147baf7817ce284834;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;41;1344.964,268.0559;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1219.297,-622.1985;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;1763.369,-499.1759;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2426.488,498.6893;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1569.843,350.0704;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;44;2039.585,-24.6058;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Hidden/Templates/Unlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;25;0
WireConnection;29;1;30;0
WireConnection;26;0;2;0
WireConnection;26;1;25;0
WireConnection;27;0;31;2
WireConnection;27;1;29;0
WireConnection;9;0;26;0
WireConnection;9;1;27;0
WireConnection;13;0;26;0
WireConnection;13;1;27;0
WireConnection;33;0;34;0
WireConnection;33;1;13;0
WireConnection;32;0;9;0
WireConnection;32;1;34;0
WireConnection;11;1;33;0
WireConnection;7;1;32;0
WireConnection;8;0;7;2
WireConnection;14;0;11;1
WireConnection;10;0;8;0
WireConnection;10;1;14;0
WireConnection;35;0;10;0
WireConnection;4;0;35;0
WireConnection;4;1;21;0
WireConnection;37;0;36;2
WireConnection;37;1;1;4
WireConnection;38;0;4;0
WireConnection;38;1;37;0
WireConnection;39;0;20;2
WireConnection;39;1;38;0
WireConnection;40;0;20;1
WireConnection;40;1;39;0
WireConnection;18;1;40;0
WireConnection;46;0;48;0
WireConnection;46;1;18;2
WireConnection;41;0;18;3
WireConnection;45;0;47;0
WireConnection;45;1;18;1
WireConnection;22;0;45;0
WireConnection;22;1;46;0
WireConnection;42;0;41;0
WireConnection;42;1;43;4
WireConnection;44;0;22;0
WireConnection;44;2;22;0
WireConnection;44;9;42;0
ASEEND*/
//CHKSM=6D4E5A4C0B6AF819B5F9176E973917CD439E73B6