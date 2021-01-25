<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://Blur/zoom-blur.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 1) uniform sampler2D Mask;&#10;layout(binding = 2) uniform sampler2D Albedo;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 ZoomBlur(sampler2D tex, vec2 uv, vec2 center, float radius, float samples, float weight, float strength)&#10;{&#10;    vec2 dir = center - uv;&#10;    float len = length(dir);&#10;    float scale = clamp(len, 0.0, radius) / len;&#10;    vec2 _step = (dir * scale) / vec2(samples);&#10;    vec4 origin = texture(tex, uv);&#10;    vec4 color = origin;&#10;    float count = 1.0;&#10;    for (float i = 1.0; i &lt;= samples; i += 1.0)&#10;    {&#10;        float weightPow = pow(1.0 - (i / samples), weight);&#10;        color += (texture(tex, uv + (_step * i)) * weightPow);&#10;        count += weightPow;&#10;    }&#10;    color /= vec4(count);&#10;    return mix(origin.xyz, color.xyz, vec3(strength));&#10;}&#10;&#10;void main()&#10;{&#10;    float Float_186_Value = 16.0;&#10;    vec2 Vector2_187_Value = vec2(0.5);&#10;    vec4 Mask_Color = texture(Mask, v_UV);&#10;    vec4 Albedo_Color = texture(Albedo, v_UV);&#10;    float Float_192_Value = 0.100000001490116119384765625;&#10;    float Float_228_Value = 0.0;&#10;    float OneMinus_203 = 1.0 - Mask_Color.w;&#10;    vec2 param = v_UV;&#10;    vec2 param_1 = Vector2_187_Value;&#10;    float param_2 = Float_192_Value;&#10;    float param_3 = Float_186_Value;&#10;    float param_4 = Float_228_Value;&#10;    float param_5 = OneMinus_203;&#10;    vec3 ZoomBlur_194 = ZoomBlur(Albedo, param, param_1, param_2, param_3, param_4, param_5);&#10;    vec3 _BaseColor = ZoomBlur_194;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    o_FragColor = vec4(_BaseColor, _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 4,&#10;            &quot;out_id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 2,&#10;            &quot;out_id&quot;: &quot;{b3811dd9-b095-401e-b5ad-4c30d6234dcf}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{8b0caea3-a688-465f-9841-ce8cc3f32bd7}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;A&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;a&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{1769d0f6-e6a8-4d72-a3f1-54ef675e4b65}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{514e8e93-9e94-49b6-aab1-267f7ec0985b}&quot;,&#10;            &quot;out_index&quot;: 2&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 3,&#10;            &quot;out_id&quot;: &quot;{dd0b17aa-4516-4113-b75d-8af58a042706}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 6,&#10;            &quot;out_id&quot;: &quot;{1769d0f6-e6a8-4d72-a3f1-54ef675e4b65}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;in_index&quot;: 5,&#10;            &quot;out_id&quot;: &quot;{98ebcd09-0275-4bac-b1f8-cd4990bd80b8}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;16.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_186&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -497,&#10;                &quot;y&quot;: 702&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b3811dd9-b095-401e-b5ad-4c30d6234dcf}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Uniform&quot;: &quot;false&quot;,&#10;                &quot;Value&quot;: &quot;0.5 0.5&quot;,&#10;                &quot;Variable&quot;: &quot;Vector2_187&quot;,&#10;                &quot;name&quot;: &quot;Vector2&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -459,&#10;                &quot;y&quot;: 560&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{514e8e93-9e94-49b6-aab1-267f7ec0985b}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;Res://Blur/circle-mask.png&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Mask&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -838,&#10;                &quot;y&quot;: 734&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;ShaderTemplate_189&quot;,&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 78,&#10;                &quot;y&quot;: 524&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;Res://Blur/albedo.png&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Albedo&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -517,&#10;                &quot;y&quot;: 337&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8b0caea3-a688-465f-9841-ce8cc3f32bd7}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Attribute&quot;: &quot;uv0&quot;,&#10;                &quot;Variable&quot;: &quot;VertexAttribute_191&quot;,&#10;                &quot;name&quot;: &quot;VertexAttribute&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -574,&#10;                &quot;y&quot;: 482&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{dd0b17aa-4516-4113-b75d-8af58a042706}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;0.1&quot;,&#10;                &quot;Variable&quot;: &quot;Float_192&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -495,&#10;                &quot;y&quot;: 635&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{be00578b-1399-45a1-9653-d778ff1f6b94}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Code&quot;: &quot;vec3 ZoomBlur(sampler2D tex, vec2 uv, vec2 center, float radius, float samples, float weight, float strength)\n{\n\t// https://gaming.stackexchange.com/questions/306721/what-is-radial-blur\n\tvec2 dir = center - uv;\n\tfloat len = length(dir);\n\tfloat scale = clamp(len, 0.0, radius) / len;\n\tvec2 step = dir * scale / samples;\n\tvec4 origin = texture(tex, uv);\n\tvec4 color = origin;\n\tfloat count = 1.0;\n\t\n\tfor (float i = 1.0; i &lt;= samples; i += 1.0)\n\t{\n\t\tfloat weightPow = pow(1.0 - i / samples, weight);\n\t\tcolor += texture(tex, uv + step * i) * weightPow;\n\t\tcount += weightPow;\n\t}\n\n\tcolor /= count;\n\n\treturn mix(origin.xyz, color.xyz, strength);\n}&quot;,&#10;                &quot;FunctionName&quot;: &quot;ZoomBlur&quot;,&#10;                &quot;Parameters&quot;: &quot;sampler2D tex, vec2 uv, vec2 center, float radius, float samples, float weight, float strength&quot;,&#10;                &quot;ReturnType&quot;: &quot;vec3&quot;,&#10;                &quot;Variable&quot;: &quot;ZoomBlur_194&quot;,&#10;                &quot;name&quot;: &quot;ZoomBlur&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -178,&#10;                &quot;y&quot;: 525&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{1769d0f6-e6a8-4d72-a3f1-54ef675e4b65}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;OneMinus_203&quot;,&#10;                &quot;name&quot;: &quot;OneMinus&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -454,&#10;                &quot;y&quot;: 830&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{98ebcd09-0275-4bac-b1f8-cd4990bd80b8}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;0.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_228&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -498,&#10;                &quot;y&quot;: 766&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="Res://Blur/albedo.png" Uniforms.Mask="Res://Blur/circle-mask.png" />
