shader_type canvas_item;

uniform float scroll_offset;

void vertex()
{
    UV.x += scroll_offset;
}