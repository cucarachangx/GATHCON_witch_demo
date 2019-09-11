// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXBrandon/CalderoLiquido"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,0,0,0)
		_Color2("Color 2", Color) = (1,0,0,0)
		_Color3("Color 3", Color) = (1,0,0,0)
		_Color1("Color 1", Color) = (1,0,0,0)
		_CantidadDistorsion("CantidadDistorsion", Range( 0.001 , 0.2)) = 1.19
		_Intensity("Intensity", Float) = 2
		_Float3("Float 3", Float) = 0
		_ColorChanger0051("ColorChanger (0 / 0.5 / 1)", Range( 0 , 1)) = 0
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
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Intensity;
		uniform float4 _BaseColor;
		uniform float _ColorChanger0051;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform sampler2D _TextureSample3;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _TextureSample2;
		uniform float _Float3;
		uniform float _CantidadDistorsion;
		uniform float4 _Color1;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 lerpResult74 = lerp( _BaseColor , float4( 0,0,0,0 ) , _ColorChanger0051);
			float4 lerpResult67 = lerp( lerpResult74 , _Color2 , (0.0 + (_ColorChanger0051 - 0.0) * (1.0 - 0.0) / (0.5 - 0.0)));
			float4 lerpResult68 = lerp( lerpResult67 , _Color3 , (0.0 + (_ColorChanger0051 - 0.5) * (2.0 - 0.0) / (1.0 - 0.5)));
			float2 uv_TexCoord32 = i.uv_texcoord * float2( 2,1.2 ) + float2( 0,0.09 );
			float2 panner3 = ( 1.0 * _Time.y * float2( -0.1,0.3 ) + i.uv_texcoord);
			float2 panner16 = ( 1.0 * _Time.y * float2( 0.1,0.2 ) + i.uv_texcoord);
			float2 appendResult35 = (float2(uv_TexCoord32.x , saturate( ( ( uv_TexCoord32.y + ( ( pow( tex2D( _TextureSample0, panner3 ).r , 9.0 ) + pow( tex2D( _TextureSample2, panner16 ).r , 9.0 ) ) * _Float3 ) ) * uv_TexCoord32.y * _CantidadDistorsion ) )));
			float2 panner56 = ( 1.0 * _Time.y * float2( 0,0 ) + appendResult35);
			float smoothstepResult65 = smoothstep( 0.0 , 0.4 , tex2D( _TextureSample3, panner56 ).r);
			o.Emission = ( ( _Intensity * lerpResult68 ) + ( smoothstepResult65 * _Color1 * 100.0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
255;484;1906;973;-1712.16;548.1431;1.3;True;False
Node;AmplifyShaderEditor.Vector2Node;15;-166.6107,627.4403;Float;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;0.1,0.2;0.1,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;10;-122.1573,190.0596;Float;False;Constant;_Speed;Speed;4;0;Create;True;0;0;False;0;-0.1,0.3;-0.1,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-325.9788,-53.46517;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-215.3774,426.4348;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;16;21.62259,410.4348;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.35,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;3;22.92908,-31.59661;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.35,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;276.1701,327.9201;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;946a38fc269538940a200df14647884e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;277.4768,-114.1113;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;e6d8fd72e9262da4b926f36c8c7fed7e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;40;567.9911,244.4429;Float;False;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;41;553.9911,90.4429;Float;False;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;825.8306,403.5747;Float;False;Property;_Float3;Float 3;10;0;Create;True;0;0;False;0;0;55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;747.0301,131.1992;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;827.2689,-223.6254;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,1.2;False;1;FLOAT2;0,0.09;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;960.9911,166.4429;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3333;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1096.446,298.6362;Float;False;Property;_CantidadDistorsion;CantidadDistorsion;8;0;Create;True;0;0;False;0;1.19;0.108;0.001;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;1135.343,-33.95073;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1381.859,-29.04317;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;66;1602.928,-92.71948;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;1155.928,-624.2195;Float;False;Property;_ColorChanger0051;ColorChanger (0 / 0.5 / 1);11;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;1759.252,-161.5125;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;77;1427.928,-468.2195;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;1232.683,-879.748;Float;False;Property;_BaseColor;BaseColor;4;0;Create;True;0;0;False;0;1,0,0,0;0,0.1797752,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;75;1514.928,-620.2195;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;1935.443,-118.5352;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;69;1637.928,-794.2195;Float;False;Property;_Color2;Color 2;5;0;Create;True;0;0;False;0;1,0,0,0;0.9568629,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;74;1480.928,-876.2195;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;78;1869.928,-634.2195;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;76;1853.928,-418.2195;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;2008.928,-631.2195;Float;False;Property;_Color3;Color 3;6;0;Create;True;0;0;False;0;1,0,0,0;0.04839927,0.5660378,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;2102.868,-141.0425;Float;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;False;0;None;566766a75df6ed949b55c6ba769a705a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;67;1953.928,-849.2195;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;79;2285.928,-419.2195;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;2695.471,-639.7851;Float;False;Property;_Intensity;Intensity;9;0;Create;True;0;0;False;0;2;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;68;2339.928,-592.2195;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;63;2698.135,249.5781;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;100;212.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;61;2408.139,220.5303;Float;False;Property;_Color1;Color 1;7;0;Create;True;0;0;False;0;1,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;65;2451.928,-139.7195;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;2767.678,5.444862;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;2831.176,-436.8261;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;83;3170.761,-50.2432;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3313.382,-97.05093;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;VFXBrandon/CalderoLiquido;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.28;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;14;0
WireConnection;16;2;15;0
WireConnection;3;0;1;0
WireConnection;3;2;10;0
WireConnection;17;1;16;0
WireConnection;2;1;3;0
WireConnection;40;0;17;1
WireConnection;41;0;2;1
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
WireConnection;77;0;70;0
WireConnection;75;0;70;0
WireConnection;56;0;35;0
WireConnection;74;0;12;0
WireConnection;74;2;70;0
WireConnection;78;0;75;0
WireConnection;76;0;77;0
WireConnection;31;1;56;0
WireConnection;67;0;74;0
WireConnection;67;1;69;0
WireConnection;67;2;78;0
WireConnection;79;0;76;0
WireConnection;68;0;67;0
WireConnection;68;1;71;0
WireConnection;68;2;79;0
WireConnection;65;0;31;1
WireConnection;60;0;65;0
WireConnection;60;1;61;0
WireConnection;60;2;63;0
WireConnection;46;0;55;0
WireConnection;46;1;68;0
WireConnection;83;0;46;0
WireConnection;83;1;60;0
WireConnection;0;2;83;0
ASEEND*/
//CHKSM=65DAAA50C55865DB3635D3FAECFA1FBB7C3E2839