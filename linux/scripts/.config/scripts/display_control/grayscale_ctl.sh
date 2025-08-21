#!/bin/bash

STATE_FILE="$HOME/.cache/display_control/grayscale_ctl"
compositor="picom"

# Check if shader is supported
if $compositor --help | grep -q legacy-backends; then
    use_experimental_backends=1
else
    use_experimental_backends=0
fi

apply_grayscale() {
    if (( use_experimental_backends == 1 )); then
        tmpfile=$(mktemp)
        trap 'rm -f "${tmpfile}"' EXIT
        cat > "${tmpfile}" <<EOF
#version 330
in vec2 texcoord;

uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec4 c = default_post_processing(texelFetch(tex, ivec2(texcoord), 0));
    float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    c = opacity*vec4(y, y, y, c.a);
    return c;
}
EOF
        $compositor -b --backend glx --window-shader-fg "${tmpfile}"
    else
        shader='uniform sampler2D tex; uniform float opacity; void main() { vec4 c = texture2D(tex, gl_TexCoord[0].xy); float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722)); gl_FragColor = opacity*vec4(y, y, y, c.a); }'
        $compositor -b --backend glx --glx-fshader-win "${shader}"
    fi
}

# Support manual "restore" if called with `--apply`
if [ "$1" == "--apply" ]; then
    [ -f "$STATE_FILE" ] && apply_grayscale
    exit 0
fi

# Toggle logic
if [ -f "$STATE_FILE" ]; then
    pkill -x $compositor
    sleep 1
    # $compositor --config ~/.config/picom/picom.conf -b
    rm -f "$STATE_FILE"
    notify-send "🎨 Color Mode Restored"
else
    pkill -x $compositor
    sleep 1
    apply_grayscale
    echo "enabled" > "$STATE_FILE"
    notify-send "🖤 Grayscale Enabled"
fi

