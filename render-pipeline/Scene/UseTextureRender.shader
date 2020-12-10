<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" class="ShaderProgram" path="Res://Scene/UseTextureRender.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 1) uniform sampler2D Albedo;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 SRgbToLinear(vec3 srgbIn)&#10;{&#10;    return pow(srgbIn, vec3(2.2000000476837158203125));&#10;}&#10;&#10;vec3 LinearToSRgb(vec3 linearIn)&#10;{&#10;    return pow(linearIn, vec3(0.4545454680919647216796875));&#10;}&#10;&#10;void main()&#10;{&#10;    vec4 Albedo_Color = texture(Albedo, v_UV);&#10;    vec3 param = Albedo_Color.xyz;&#10;    vec3 _44 = SRgbToLinear(param);&#10;    Albedo_Color = vec4(_44.x, _44.y, _44.z, Albedo_Color.w);&#10;    vec3 _BaseColor = Albedo_Color.xyz;&#10;    float _Opacity = Albedo_Color.w;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    vec3 param_1 = _BaseColor;&#10;    o_FragColor = vec4(LinearToSRgb(param_1), _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{246aef77-5df5-4346-9a1f-5414b0bef925}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{37b49bc0-d329-453a-9e02-52b7c10b7fdb}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{246aef77-5df5-4346-9a1f-5414b0bef925}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{37b49bc0-d329-453a-9e02-52b7c10b7fdb}&quot;,&#10;            &quot;out_index&quot;: 4&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{246aef77-5df5-4346-9a1f-5414b0bef925}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 0,&#10;                &quot;y&quot;: -13&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{37b49bc0-d329-453a-9e02-52b7c10b7fdb}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;true&quot;,&#10;                &quot;isAtla&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;,&#10;                &quot;texture&quot;: &quot;&quot;,&#10;                &quot;type&quot;: &quot;General&quot;,&#10;                &quot;variableName&quot;: &quot;Albedo&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -377,&#10;                &quot;y&quot;: 8&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="" />