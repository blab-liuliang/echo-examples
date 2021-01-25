<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://Blur/flow-blur.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    float u_Time;&#10;} fs_ubo;&#10;&#10;layout(binding = 1) uniform sampler2D Albedo;&#10;layout(binding = 2) uniform sampler2D Flow;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 FlowBlur(sampler2D tex, sampler2D flow, inout vec2 uv, float _length, float samples, float weight, float strength)&#10;{&#10;    float _step = (_length / samples) / 100.0;&#10;    vec4 origin = texture(tex, uv);&#10;    vec4 color = origin;&#10;    float count = 1.0;&#10;    for (float i = 1.0; i &lt;= samples; i += 1.0)&#10;    {&#10;        vec2 dir = (texture(flow, uv).xy * 2.0) - vec2(1.0);&#10;        uv += (dir * _step);&#10;        float weightPow = pow(clamp(1.0 - (i / samples), 0.0, 1.0), weight);&#10;        color += (texture(tex, uv) * weightPow);&#10;        count += weightPow;&#10;    }&#10;    color /= vec4(count);&#10;    return mix(origin.xyz, color.xyz, vec3(strength));&#10;}&#10;&#10;void main()&#10;{&#10;    float Float_195_Value = 4.0;&#10;    float Float_190_Value = 1.0;&#10;    vec4 Albedo_Color = texture(Albedo, v_UV);&#10;    float Float_187_Value = 12.0;&#10;    vec4 Flow_Color = texture(Flow, v_UV);&#10;    float Float_198_Value = 0.4000000059604644775390625;&#10;    float Float_208_Value = -431602080.0;&#10;    float Multiplication_197 = fs_ubo.u_Time * Float_198_Value;&#10;    float Mod_194 = mod(Multiplication_197, Float_195_Value);&#10;    vec2 param = v_UV;&#10;    float param_1 = Mod_194;&#10;    float param_2 = Float_187_Value;&#10;    float param_3 = Float_208_Value;&#10;    float param_4 = Float_190_Value;&#10;    vec3 _146 = FlowBlur(Albedo, Flow, param, param_1, param_2, param_3, param_4);&#10;    vec3 FlowBlur_207 = _146;&#10;    vec3 _BaseColor = FlowBlur_207;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    o_FragColor = vec4(_BaseColor, _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;A&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;B&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{28464478-da8d-4f01-9bbb-a325b95db553}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;B&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{9cf1ce26-59be-43a0-ae8d-30eab449904e}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;A&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{15352733-4bc1-4267-8094-fb4d91bdf522}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 5,&#10;            &quot;out_id&quot;: &quot;{563fbd1b-9633-4ba8-8e42-71461fe758d5}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 6,&#10;            &quot;out_id&quot;: &quot;{59512ae1-9309-49e4-b71b-ffa24fa50161}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 4,&#10;            &quot;out_id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 3,&#10;            &quot;out_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 2,&#10;            &quot;out_id&quot;: &quot;{724fa826-a71f-4943-884f-0083cdf87e9a}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{028d232f-1ece-49c5-a4fd-f0c7b5adceae}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{28464478-da8d-4f01-9bbb-a325b95db553}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;4.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_195&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -616,&#10;                &quot;y&quot;: 739&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;Mod_194&quot;,&#10;                &quot;name&quot;: &quot;Mod&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -447,&#10;                &quot;y&quot;: 665&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{59512ae1-9309-49e4-b71b-ffa24fa50161}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;1.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_190&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -497,&#10;                &quot;y&quot;: 935&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;Res://Blur/wheel.png&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Albedo&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -517,&#10;                &quot;y&quot;: 261&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;ShaderTemplate_188&quot;,&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 69,&#10;                &quot;y&quot;: 462&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;12.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_187&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -501,&#10;                &quot;y&quot;: 803&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{724fa826-a71f-4943-884f-0083cdf87e9a}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Attribute&quot;: &quot;uv0&quot;,&#10;                &quot;Variable&quot;: &quot;VertexAttribute_193&quot;,&#10;                &quot;name&quot;: &quot;VertexAttribute&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -567,&#10;                &quot;y&quot;: 548&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{028d232f-1ece-49c5-a4fd-f0c7b5adceae}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Atla&quot;: &quot;false&quot;,&#10;                &quot;Texture&quot;: &quot;Res://Blur/flowmap.png&quot;,&#10;                &quot;Type&quot;: &quot;General&quot;,&#10;                &quot;Variable&quot;: &quot;Flow&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -513,&#10;                &quot;y&quot;: 403&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{15352733-4bc1-4267-8094-fb4d91bdf522}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Shared&quot;: &quot;u_Time&quot;,&#10;                &quot;Variable&quot;: &quot;Shared_196&quot;,&#10;                &quot;name&quot;: &quot;Shared&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -902,&#10;                &quot;y&quot;: 597&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Variable&quot;: &quot;Multiplication_197&quot;,&#10;                &quot;name&quot;: &quot;Multiplication&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -596,&#10;                &quot;y&quot;: 620&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{9cf1ce26-59be-43a0-ae8d-30eab449904e}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;0.4&quot;,&#10;                &quot;Variable&quot;: &quot;Float_198&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -800,&#10;                &quot;y&quot;: 680&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8f9a3e00-f409-4517-915d-151d6a32786d}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Code&quot;: &quot;vec3 FlowBlur(sampler2D tex, sampler2D flow, vec2 uv, float length, float samples, float weight, float strength)\n{\n\tfloat step = length / samples / 100.0;\n\tvec4 origin = texture(tex, uv);\n\tvec4 color = origin;\n\tfloat count = 1.0;\n\t\n\tfor (float i = 1.0; i &lt;= samples; i += 1.0)\n\t{\n\t\tvec2 dir = texture(flow, uv).xy * 2.0 - 1.0;\n\t\tuv += dir * step;\n\t\t\n\t\tfloat weightPow = pow(clamp(1.0 - i / samples, 0.0, 1.0), weight);\n\t\tcolor += texture(tex, uv) * weightPow;\n\t\tcount += weightPow;\n\t}\n\n\tcolor /= count;\n\n\treturn mix(origin.xyz, color.xyz, strength);\n}&quot;,&#10;                &quot;FunctionName&quot;: &quot;FlowBlur&quot;,&#10;                &quot;Parameters&quot;: &quot;sampler2D tex, sampler2D flow, vec2 uv, float length, float samples, float weight, float strength&quot;,&#10;                &quot;ReturnType&quot;: &quot;vec3&quot;,&#10;                &quot;Variable&quot;: &quot;FlowBlur_207&quot;,&#10;                &quot;name&quot;: &quot;FlowBlur&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -158,&#10;                &quot;y&quot;: 463&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{563fbd1b-9633-4ba8-8e42-71461fe758d5}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Value&quot;: &quot;-431602080.0&quot;,&#10;                &quot;Variable&quot;: &quot;Float_208&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -501,&#10;                &quot;y&quot;: 869&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="Res://Blur/wheel.png" Uniforms.Flow="Res://Blur/flowmap.png" />
