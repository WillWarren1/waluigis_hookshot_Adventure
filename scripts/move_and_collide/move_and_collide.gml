///@arg xspeed
///@arg yspeed
var xpeed = argument0;
var yspeed = argument1;

if not place_meeting(x+xpeed, y, o_wall)
{
	x+=xpeed;
}
if not place_meeting(x, y+yspeed, o_wall)
{
	y+=yspeed;
}