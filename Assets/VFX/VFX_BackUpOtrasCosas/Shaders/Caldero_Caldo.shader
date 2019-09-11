// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Color0("Color 0", Color) = (1,0,0,0)
		_Color1("Color 1", Color) = (1,0,0,0)
		_CantidadDistorsion("CantidadDistorsion", Range( 0.001 , 0.2)) = 1.19
		_Float0("Float 0", Float) = 2
		_Float3("Float 3", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Float0;
		uniform float4 _Color0;
		uniform sampler2D _TextureSample3;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _TextureSample2;
		uniform float _Float3;
		uniform float _CantidadDistorsion;
		uniform float4 _Color1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = ( _Float0 * _Color0 ).rgb;
			float2 uv_TexCoord32 = i.uv_texcoord * float2( 2,1.2 ) + float2( 0,0.09 );
			float2 panner3 = ( 1.0 * _Time.y * float2( -0.1,0.3 ) + i.uv_texcoord);
			float2 panner16 = ( 1.0 * _Time.y * float2( 0.1,0.2 ) + i.uv_texcoord);
			float2 appendResult35 = (float2(uv_TexCoord32.x , saturate( ( ( uv_TexCoord32.y + ( ( pow( tex2D( _TextureSample0, panner3 ).r , 9.0 ) + pow( tex2D( _TextureSample2, panner16 ).r , 9.0 ) ) * _Float3 ) ) * uv_TexCoord32.y * _CantidadDistorsion ) )));
			float2 panner56 = ( 1.0 * _Time.y * float2( 0,0 ) + appendResult35);
			float smoothstepResult65 = smoothstep( 0.0 , 0.4 , tex2D( _TextureSample3, panner56 ).r);
			o.Emission = ( smoothstepResult65 * _Color1 * 100.0 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
1921;1;1022;704;-1876.928;332.7195;1;True;False
Node;AmplifyShaderEditor.Vector2Node;15;-166.6107,627.4403;Float;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;0.1,0.2;0.1,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;10;-122.1573,190.0596;Float;False;Constant;_Speed;Speed;4;0;Create;True;0;0;False;0;-0.1,0.3;-0.1,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-325.9788,-53.46517;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-215.3774,426.4348;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;16;21.62259,410.4348;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.35,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;3;22.92908,-31.59661;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.35,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;276.1701,327.9201;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;277.4768,-114.1113;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;41;553.9911,90.4429;Float;False;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;567.9911,244.4429;Float;False;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;825.8306,403.5747;Float;False;Property;_Float3;Float 3;8;0;Create;True;0;0;False;0;0;53.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;747.0301,131.1992;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;827.2689,-223.6254;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,1.2;False;1;FLOAT2;0,0.09;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;960.9911,166.4429;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3333;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1096.446,298.6362;Float;False;Property;_CantidadDistorsion;CantidadDistorsion;6;0;Create;True;0;0;False;0;1.19;0.2;0.001;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;1135.343,-33.95073;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1381.859,-29.04317;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;66;1602.928,-92.71948;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;1757.252,-193.5125;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;56;1935.443,-118.5352;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;31;2102.868,-141.0425;Float;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;False;0;None;566766a75df6ed949b55c6ba769a705a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;2057.683,-378.748;Float;False;Property;_Color0;Color 0;4;0;Create;True;0;0;False;0;1,0,0,0;1,0,0.729857,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;2331.471,-402.7851;Float;False;Property;_Float0;Float 0;7;0;Create;True;0;0;False;0;2;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;2607.135,132.5781;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;100;212.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;65;2451.928,-139.7195;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;61;2408.139,220.5303;Float;False;Property;_Color1;Color 1;5;0;Create;True;0;0;False;0;1,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2630.277,-320.326;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;2767.678,5.444862;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2967.182,-102.7509;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.1;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;14;0
WireConnection;16;2;15;0
WireConnection;3;0;1;0
WireConnection;3;2;10;0
WireConnection;17;1;16;0
WireConnection;2;1;3;0
WireConnection;41;0;2;1
WireConnection;40;0;17;1
WireConnection;13;0;41;0
WireConnection;13;1;40;0
WireConnection;42;0;13;0
WireConnection;42;1;43;0
WireConnection;33;0;32;2
WireConnection;33;1;42;0
WireConnection;37;0;33;0
WireConnection;37;1;32;2
WireConnection;37;2;38;0
WireConnection;66;0;37;0
WireConnection;35;0;32;1
WireConnection;35;1;66;0
WireConnection;56;0;35;0
WireConnection;31;1;56;0
WireConnection;65;0;31;1
WireConnection;46;0;55;0
WireConnection;46;1;12;0
WireConnection;60;0;65;0
WireConnection;60;1;61;0
WireConnection;60;2;63;0
WireConnection;0;0;46;0
WireConnection;0;2;60;0
ASEEND*/
//CHKSM=E79858EB4CF1B15053D5F794403CD2A7E55B5345