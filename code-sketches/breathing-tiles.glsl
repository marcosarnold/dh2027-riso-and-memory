void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    // define number of tiles
    float tiles = 8.0;
    
    // tile id
    vec2 id = floor(uv * tiles);
    
    // local coords within tile
    vec2 gv = fract(uv * tiles) - 0.5;

    // random seed per tile
    float seed = fract(sin(dot(id.xy ,vec2(12.9898,78.233))) * 43758.5453);
    
    // choose a random color from 4 options
    vec3 colors[4];
    colors[0] = vec3(0.9, 0.9, 0.8); // cream
    colors[1] = vec3(0.8, 0.2, 0.2); // red
    colors[2] = vec3(0.2, 0.2, 0.8); // blue
    colors[3] = vec3(0.8, 0.8, 0.2); // yellow
    
    vec3 col = colors[int(floor(seed*4.0))];

    // rotate tile randomly
    float angle = seed * 3.14159 * 2.0;
    float ca = cos(angle);
    float sa = sin(angle);
    gv = mat2(ca, -sa, sa, ca) * gv;
    
    // animate weaving lines
    float speed = 1.0;
    float t = iTime * speed;
    float line1 = smoothstep(-0.02, 0.02, gv.y + 0.5*gv.x + sin(t+seed*6.28)*0.1);
    float line2 = smoothstep(-0.02, 0.02, gv.y - 0.5*gv.x + cos(t+seed*6.28)*0.1);
    
    float pattern = max(line1, line2);
    
    // subtle noise for organic feel
    float n = fract(sin(dot(fragCoord.xy ,vec2(12.9898,78.233))) * 43758.5453);
    pattern = mix(pattern, pattern*n, 0.3);
    
    // mix base color with white for lines
    col = mix(col, vec3(1.0), pattern);
    
    fragColor = vec4(col, 1.0);
}