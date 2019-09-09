// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXBrandon/BubbleAndPop"
{
	Properties
	{
		_BubbleAndPop("BubbleAndPop", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (54.3058,0,67.79352,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend One One
		Cull Back
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM



#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
		//only defining to not throw compilation error over Unity 5.5
		#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float4 _Color0;
			uniform sampler2D _BubbleAndPop;
			uniform float4 _BubbleAndPop_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord = v.ase_texcoord;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float2 uv_BubbleAndPop = i.ase_texcoord * _BubbleAndPop_ST.xy + _BubbleAndPop_ST.zw;
				float4 tex2DNode1 = tex2D( _BubbleAndPop, uv_BubbleAndPop );
				float lerpResult10 = lerp( tex2DNode1.r , tex2DNode1.g , i.ase_texcoord.z);
				
				
				finalColor = ( _Color0 * lerpResult10 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16900
219;126;1486;885;1147.482;279.929;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-566.4824,15.07098;Float;True;Property;_BubbleAndPop;BubbleAndPop;0;0;Create;True;0;0;False;0;c1e8eac7371edce4c966350858c282fd;c1e8eac7371edce4c966350858c282fd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;4;-445.4824,207.071;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-174.4821,-108.929;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;54.3058,0,67.79352,0;1.066667,1.003922,5.992157,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;10;-141.4821,78.07098;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;75.5176,-7.929016;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;232,1;Float;False;True;2;Float;ASEMaterialInspector;0;1;VFXBrandon/BubbleAndPop;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;10;0;1;1
WireConnection;10;1;1;2
WireConnection;10;2;4;3
WireConnection;6;0;9;0
WireConnection;6;1;10;0
WireConnection;0;0;6;0
ASEEND*/
//CHKSM=4E0337C86463E73AD22F66407F099593506DE24C