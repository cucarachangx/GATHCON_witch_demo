// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXBrandon/AdditiveTransparent"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "white" {}
		_CambiarColor("CambiarColor?", Color) = (0,0,0,0)
		_NecesitaFadeOut("NecesitaFadeOut?", Range( 0 , 1)) = 0
		_SpeedRotacion("SpeedRotacion", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		ZTest Always
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _CambiarColor;
		uniform sampler2D _MainTex;
		uniform float _SpeedRotacion;
		uniform float _NecesitaFadeOut;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float cos11 = cos( ( _Time.y * _SpeedRotacion ) );
			float sin11 = sin( ( _Time.y * _SpeedRotacion ) );
			float2 rotator11 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos11 , -sin11 , sin11 , cos11 )) + float2( 0.5,0.5 );
			float4 tex2DNode1 = tex2D( _MainTex, rotator11 );
			float4 temp_cast_0 = (_NecesitaFadeOut).xxxx;
			o.Emission = ( _CambiarColor * ( tex2DNode1 * ( tex2DNode1 - temp_cast_0 ) * i.vertexColor ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
20;868;1906;949;1578;213;1;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;13;-1190,275;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1193,368;Float;False;Property;_SpeedRotacion;SpeedRotacion;4;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1218,59;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-970,236;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;11;-917,67;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;2.57;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-634,276;Float;False;Property;_NecesitaFadeOut;NecesitaFadeOut?;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-666,49;Float;True;Property;_MainTex;_MainTex;1;0;Create;True;0;0;False;0;None;16e53173e1b5eb24c8e5e1c67efbcf97;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;15;-264,503;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;-330,200;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;6;-173,-70;Float;False;Property;_CambiarColor;CambiarColor?;2;0;Create;True;0;0;False;0;0,0,0,0;0.213132,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-85.3333,130;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;110,108;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;270,15;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;VFXBrandon/AdditiveTransparent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;13;0
WireConnection;14;1;12;0
WireConnection;11;0;10;0
WireConnection;11;2;14;0
WireConnection;1;1;11;0
WireConnection;8;0;1;0
WireConnection;8;1;9;0
WireConnection;4;0;1;0
WireConnection;4;1;8;0
WireConnection;4;2;15;0
WireConnection;7;0;6;0
WireConnection;7;1;4;0
WireConnection;0;2;7;0
ASEEND*/
//CHKSM=4D1255D6CCD9CAE6AFBC190C676C8119DB6BB207