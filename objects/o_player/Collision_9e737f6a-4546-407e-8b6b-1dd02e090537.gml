/// @description Insert description here
// You can write your code in this editor
if place_meeting(x-hspeed, y, o_wall)
{
	x += hspeed;
}

if place_meeting(x+hspeed, y, o_wall)
{
	x -= hspeed;
}

if (other.y < y && place_free(x, y+vspeed))
{
	vspeed = 0;
	move_contact_solid(270,12);
}