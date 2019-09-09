// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Battlerite/VFX1"
{
	Properties
	{
		[HDR]_Color("Color", Color) = (0.7075472,0.06341223,0.06341223,0)
		_Noise("Noise", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Color;
		uniform sampler2D _Noise;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = ( i.vertexColor * _Color ).rgb;
			float2 uv_TexCoord2 = i.uv_texcoord + float2( -0.5,-0.5 );
			float temp_output_1_0 = length( uv_TexCoord2 );
			float smoothstepResult5 = smoothstep( 0.0 , ( i.uv_tex4coord.z * 2.0 ) , temp_output_1_0);
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_2_0_g3 = ( i.uv_texcoord - temp_cast_1 );
			float2 temp_cast_2 = (0.5).xx;
			float2 break8_g3 = temp_output_2_0_g3;
			float2 appendResult25_g3 = (float2(( length( temp_output_2_0_g3 ) * 2.0 * 1.0 ) , ( atan2( break8_g3.x , break8_g3.y ) * ( 1.0 / 6.28 ) * 1.0 )));
			o.Alpha = ( i.vertexColor.a * ( 1.0 - step( ( step( temp_output_1_0 , 0.5 ) * ( (-1.0 + (smoothstepResult5 - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)) + tex2D( _Noise, appendResult25_g3 ).g ) ) , 0.0 ) ) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

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
				float4 customPack2 : TEXCOORD2;
				float3 worldPos : TEXCOORD3;
				half4 color : COLOR0;
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
				o.customPack2.xyzw = customInputData.uv_tex4coord;
				o.customPack2.xyzw = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
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
				surfIN.uv_tex4coord = IN.customPack2.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.vertexColor = IN.color;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
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
379;676;1906;658;267.5721;368.5042;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-986.5,92.5;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.5,-0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;33;-985.1722,376.3956;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-646.0831,424.6402;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;1;-737.5,92.5;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;5;-485.1997,177.1;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;32;-625.2152,657.3771;Float;True;PolarCoordinates;-1;;3;343631acc98cee34399169b9733f3934;0;2;27;FLOAT;1;False;24;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;31;-253.577,63.88913;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-303.6132,625.177;Float;True;Property;_Noise;Noise;1;0;Create;True;0;0;False;0;641cf02b46150004099cf11b4753918d;8bda69dfcbffab34ea3335395c4766c4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;10;-203.1124,317.6779;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;41.35925,501.1466;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;13;10.88629,84.47761;Float;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;323.5864,311.3776;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;621.449,311.4026;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;871.4489,309.4026;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;729.6855,17.20105;Float;False;Property;_Color;Color;0;1;[HDR];Create;True;0;0;False;0;0.7075472,0.06341223,0.06341223,0;1.233589,1.190359,0.4829619,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;35;1006.428,-161.8041;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1079.383,570.732;Float;False;Property;_Progression;Progression;2;0;Create;True;0;0;False;0;0.7548674;0.1387585;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1130.039,209.8806;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;1285.928,9.795824;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1494.946,-31.69614;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Battlerite/VFX1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;33;3
WireConnection;1;0;2;0
WireConnection;5;0;1;0
WireConnection;5;2;30;0
WireConnection;31;0;1;0
WireConnection;14;1;32;0
WireConnection;10;0;5;0
WireConnection;9;0;10;0
WireConnection;9;1;14;2
WireConnection;13;0;31;0
WireConnection;11;0;13;0
WireConnection;11;1;9;0
WireConnection;22;0;11;0
WireConnection;23;0;22;0
WireConnection;28;0;35;4
WireConnection;28;1;23;0
WireConnection;34;0;35;0
WireConnection;34;1;4;0
WireConnection;0;2;34;0
WireConnection;0;9;28;0
ASEEND*/
//CHKSM=3068B59E7356C15D285F89E1D32134A33AA2756A