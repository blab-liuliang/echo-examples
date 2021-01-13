<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" path="Res://Blur/flow-blur.shader" Type="glsl" VertexShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;layout(location = 0) in vec3 a_Position;&#10;layout(location = 7) out vec2 v_UV;&#10;layout(location = 4) in vec2 a_UV;&#10;&#10;void main()&#10;{&#10;    vec4 worldPosition = vs_ubo.u_WorldMatrix * vec4(a_Position, 1.0);&#10;    vec4 clipPosition = vs_ubo.u_ViewProjMatrix * worldPosition;&#10;    gl_Position = clipPosition;&#10;    v_UV = a_UV;&#10;}&#10;&#10;" FragmentShader="#version 450&#10;&#10;layout(binding = 0, std140) uniform UBO&#10;{&#10;    float u_Time;&#10;} fs_ubo;&#10;&#10;layout(binding = 1) uniform sampler2D Albedo;&#10;layout(binding = 2) uniform sampler2D Flow;&#10;&#10;layout(location = 7) in vec2 v_UV;&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;vec3 SRgbToLinear(vec3 srgbIn)&#10;{&#10;    return srgbIn;&#10;}&#10;&#10;vec3 FlowBlur(sampler2D tex, sampler2D flow, inout vec2 uv, float _length, float samples, float strength)&#10;{&#10;    float _step = (_length / samples) / 100.0;&#10;    vec4 origin = texture(tex, uv);&#10;    vec4 color = origin;&#10;    float count = 1.0;&#10;    for (float i = 1.0; i &lt;= samples; i += 1.0)&#10;    {&#10;        vec2 dir = (texture(flow, uv).xy * 2.0) - vec2(1.0);&#10;        uv += (dir * _step);&#10;        color += texture(tex, uv);&#10;        count += 1.0;&#10;    }&#10;    color /= vec4(count);&#10;    return mix(origin.xyz, color.xyz, vec3(strength));&#10;}&#10;&#10;vec3 LinearToSRgb(vec3 linearIn)&#10;{&#10;    return linearIn;&#10;}&#10;&#10;void main()&#10;{&#10;    float Float_35_Value = 6.0;&#10;    vec4 Albedo_Color = texture(Albedo, v_UV);&#10;    vec3 param = Albedo_Color.xyz;&#10;    vec3 _111 = SRgbToLinear(param);&#10;    Albedo_Color = vec4(_111.x, _111.y, _111.z, Albedo_Color.w);&#10;    float Float_31_Value = 1.0;&#10;    vec4 Flow_Color = texture(Flow, v_UV);&#10;    vec3 param_1 = Flow_Color.xyz;&#10;    vec3 _123 = SRgbToLinear(param_1);&#10;    Flow_Color = vec4(_123.x, _123.y, _123.z, Flow_Color.w);&#10;    float Float_41_Value = 3.0;&#10;    float Float_45_Value = 0.5;&#10;    float Multiplication_44 = fs_ubo.u_Time * Float_45_Value;&#10;    float Mod_43 = mod(Multiplication_44, Float_41_Value);&#10;    vec2 param_2 = v_UV;&#10;    float param_3 = Mod_43;&#10;    float param_4 = Float_35_Value;&#10;    float param_5 = Float_31_Value;&#10;    vec3 _154 = FlowBlur(Albedo, Flow, param_2, param_3, param_4, param_5);&#10;    vec3 SpinBlur_159 = _154;&#10;    vec3 _BaseColor = SpinBlur_159;&#10;    float _Opacity = 1.0;&#10;    float _Metalic = 0.20000000298023223876953125;&#10;    float _PerceptualRoughness = 0.5;&#10;    vec3 param_6 = _BaseColor;&#10;    o_FragColor = vec4(LinearToSRgb(param_6), _Opacity);&#10;}&#10;&#10;" Graph="{&#10;    &quot;connections&quot;: [&#10;        {&#10;            &quot;in_id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 3,&#10;            &quot;out_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 4,&#10;            &quot;out_id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{028d232f-1ece-49c5-a4fd-f0c7b5adceae}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 5,&#10;            &quot;out_id&quot;: &quot;{59512ae1-9309-49e4-b71b-ffa24fa50161}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;in_id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;in_index&quot;: 2,&#10;            &quot;out_id&quot;: &quot;{724fa826-a71f-4943-884f-0083cdf87e9a}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;B&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{28464478-da8d-4f01-9bbb-a325b95db553}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;B&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;in_index&quot;: 1,&#10;            &quot;out_id&quot;: &quot;{9cf1ce26-59be-43a0-ae8d-30eab449904e}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;A&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{15352733-4bc1-4267-8094-fb4d91bdf522}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        },&#10;        {&#10;            &quot;converter&quot;: {&#10;                &quot;in&quot;: {&#10;                    &quot;id&quot;: &quot;any&quot;,&#10;                    &quot;name&quot;: &quot;A&quot;&#10;                },&#10;                &quot;out&quot;: {&#10;                    &quot;id&quot;: &quot;float&quot;,&#10;                    &quot;name&quot;: &quot;float&quot;&#10;                }&#10;            },&#10;            &quot;in_id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;in_index&quot;: 0,&#10;            &quot;out_id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;out_index&quot;: 0&#10;        }&#10;    ],&#10;    &quot;nodes&quot;: [&#10;        {&#10;            &quot;id&quot;: &quot;{db7fae7c-f90a-442a-8f1a-2efdecf88ff8}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;,&#10;                &quot;number&quot;: &quot;6.0&quot;,&#10;                &quot;variableName&quot;: &quot;Float_35&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -494,&#10;                &quot;y&quot;: 820&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{b7f7e787-366b-4d5a-b8f5-2168aa67d467}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;ShaderTemplate&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: 78,&#10;                &quot;y&quot;: 524&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{831c51b6-ccae-4af6-b402-f4b6fd8397e5}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;true&quot;,&#10;                &quot;isAtla&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;,&#10;                &quot;texture&quot;: &quot;Res://Blur/wheel.png&quot;,&#10;                &quot;type&quot;: &quot;General&quot;,&#10;                &quot;variableName&quot;: &quot;Albedo&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -517,&#10;                &quot;y&quot;: 261&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{59512ae1-9309-49e4-b71b-ffa24fa50161}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;,&#10;                &quot;number&quot;: &quot;1.0&quot;,&#10;                &quot;variableName&quot;: &quot;Float_31&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -492,&#10;                &quot;y&quot;: 897&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{9c1b933a-ebf4-478b-8f4f-f379f5fe6713}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Code&quot;: &quot;vec3 FlowBlur(sampler2D tex, sampler2D flow, vec2 uv, float length, float samples, float strength)\n{\n\tfloat step = length / samples / 100.0;\n\tvec4 origin = texture(tex, uv);\n\tvec4 color = origin;\n\tfloat count = 1.0;\n\t\n\tfor (float i = 1.0; i &lt;= samples; i += 1.0)\n\t{\n\t\tvec2 dir = texture(flow, uv).xy * 2.0 - 1.0;\n\t\tuv += dir * step;\n\t\t\n\t\tcolor += texture(tex, uv);\n\t\tcount += 1.0;\n\t}\n\n\tcolor /= count;\n\n\treturn mix(origin.xyz, color.xyz, strength);\n}&quot;,&#10;                &quot;FunctionName&quot;: &quot;FlowBlur&quot;,&#10;                &quot;Parameters&quot;: &quot;sampler2D tex, sampler2D flow, vec2 uv, float length, float samples, float strength&quot;,&#10;                &quot;ReturnType&quot;: &quot;vec3&quot;,&#10;                &quot;name&quot;: &quot;SpinBlur&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -188,&#10;                &quot;y&quot;: 525&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{028d232f-1ece-49c5-a4fd-f0c7b5adceae}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;true&quot;,&#10;                &quot;isAtla&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Texture&quot;,&#10;                &quot;texture&quot;: &quot;Res://Blur/flowmap.png&quot;,&#10;                &quot;type&quot;: &quot;General&quot;,&#10;                &quot;variableName&quot;: &quot;Flow&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -513,&#10;                &quot;y&quot;: 403&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{724fa826-a71f-4943-884f-0083cdf87e9a}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;VertexAttribute&quot;,&#10;                &quot;option&quot;: &quot;uv0&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -567,&#10;                &quot;y&quot;: 548&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{5283c659-0d8e-43d0-a0fc-fab5ab032ea1}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;Mod&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -447,&#10;                &quot;y&quot;: 665&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{28464478-da8d-4f01-9bbb-a325b95db553}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;,&#10;                &quot;number&quot;: &quot;3.0&quot;,&#10;                &quot;variableName&quot;: &quot;Float_41&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -616,&#10;                &quot;y&quot;: 739&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{15352733-4bc1-4267-8094-fb4d91bdf522}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;Shared&quot;,&#10;                &quot;option&quot;: &quot;u_Time&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -902,&#10;                &quot;y&quot;: 597&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{8099d4ac-ad12-4e54-ad78-3f2ff68c56e0}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;name&quot;: &quot;Multiplication&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -596,&#10;                &quot;y&quot;: 620&#10;            }&#10;        },&#10;        {&#10;            &quot;id&quot;: &quot;{9cf1ce26-59be-43a0-ae8d-30eab449904e}&quot;,&#10;            &quot;model&quot;: {&#10;                &quot;Export&quot;: &quot;false&quot;,&#10;                &quot;name&quot;: &quot;Float&quot;,&#10;                &quot;number&quot;: &quot;0.5&quot;,&#10;                &quot;variableName&quot;: &quot;Float_45&quot;&#10;            },&#10;            &quot;position&quot;: {&#10;                &quot;x&quot;: -800,&#10;                &quot;y&quot;: 680&#10;            }&#10;        }&#10;    ]&#10;}&#10;" CullMode="CULL_BACK" BlendMode="Opaque" Uniforms.Albedo="Res://Blur/wheel.png" Uniforms.Flow="Res://Blur/flowmap.png" />
