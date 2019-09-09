// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXBrandon/DMGorHealth"
{
	Properties
	{
		_Damage_Color("Damage_Color", Color) = (0.7735849,0,0,0)
		_Health_Color("Health_Color", Color) = (0,1,0.2464235,0)
		_LerpColorOpacity("LerpColorOpacity", Range( 0 , 1)) = 1
		_DMGorHealth0esDMG1esHealth("DMG or Health? (0 es DMG / 1 es Health)", Float) = 1
		_TexturePanner("_TexturePanner", Range( 0 , 2)) = 1
		_PanningTex("_PanningTex", 2D) = "white" {}
		_Witch_Texture_AO("Witch_Texture_AO", 2D) = "white" {}
		_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv3_texcoord3;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Damage_Color;
		uniform float4 _Health_Color;
		uniform float _DMGorHealth0esDMG1esHealth;
		uniform float _LerpColorOpacity;
		uniform sampler2D _PanningTex;
		uniform float _TexturePanner;
		uniform sampler2D _Witch_Texture_AO;
		uniform float4 _Witch_Texture_AO_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Albedo = tex2D( _MainTex, uv_MainTex ).rgb;
			float4 lerpResult34 = lerp( _Damage_Color , _Health_Color , _DMGorHealth0esDMG1esHealth);
			float4 lerpResult1 = lerp( float4( 0,0,0,0 ) , lerpResult34 , _LerpColorOpacity);
			float2 appendResult29 = (float2(i.uv3_texcoord3.x , ( _TexturePanner + ( i.uv3_texcoord3.y + -1.0 ) )));
			o.Emission = ( lerpResult1 * tex2D( _PanningTex, appendResult29 ).r ).rgb;
			float2 uv_Witch_Texture_AO = i.uv_texcoord * _Witch_Texture_AO_ST.xy + _Witch_Texture_AO_ST.zw;
			o.Occlusion = tex2D( _Witch_Texture_AO, uv_Witch_Texture_AO ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
236;698;1906;664;1837.72;-216.9916;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;32;-1237.518,314.2008;Float;False;1073.133;375.0428;Panneo Textura;6;27;28;29;31;17;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1187.518,456.3881;Float;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-909.4964,580.2435;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1193.604,374.2008;Float;False;Property;_TexturePanner;_TexturePanner;4;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1090.359,-339.3115;Float;False;849.9852;623.8782;"Selector" de Color;6;8;1;5;6;4;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1066.959,36.41119;Float;False;Property;_DMGorHealth0esDMG1esHealth;DMG or Health? (0 es DMG / 1 es Health);3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1061.359,-140.6206;Float;False;Property;_Damage_Color;Damage_Color;0;0;Create;True;0;0;False;0;0.7735849,0,0,0;0.9999598,0,0.008962271,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-761.0273,557.6024;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-1057.059,-302.084;Float;False;Property;_Health_Color;Health_Color;1;0;Create;True;0;0;False;0;0,1,0.2464235,0;0,1,0.2464235,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;29;-623.017,475.0564;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-847.1818,189.189;Float;False;Property;_LerpColorOpacity;LerpColorOpacity;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;-760.2231,-214.7094;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1;-493.3143,47.0713;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;17;-482.3855,447.4759;Float;True;Property;_PanningTex;_PanningTex;5;0;Create;True;0;0;False;0;None;479f0e35807d1a84c95851ee92b291d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;36;151.0225,499.5363;Float;True;Property;_Witch_Texture_AO;Witch_Texture_AO;6;0;Create;True;0;0;False;0;ecab80c5891d54542bf1fc89fd485e57;ecab80c5891d54542bf1fc89fd485e57;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-199.9776,-11.36372;Float;True;Property;_MainTex;_MainTex;7;0;Create;True;0;0;False;0;1136755e366f0f646b45dbf37c521266;1136755e366f0f646b45dbf37c521266;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-121.4975,273.4065;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;35;624.7297,113.2399;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;VFXBrandon/DMGorHealth;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;16;2
WireConnection;28;0;31;0
WireConnection;28;1;27;0
WireConnection;29;0;16;1
WireConnection;29;1;28;0
WireConnection;34;0;4;0
WireConnection;34;1;5;0
WireConnection;34;2;6;0
WireConnection;1;1;34;0
WireConnection;1;2;8;0
WireConnection;17;1;29;0
WireConnection;18;0;1;0
WireConnection;18;1;17;1
WireConnection;35;0;37;0
WireConnection;35;2;18;0
WireConnection;35;5;36;0
ASEEND*/
//CHKSM=F58A765892248144C7F877E4482024CBEF2D32FA