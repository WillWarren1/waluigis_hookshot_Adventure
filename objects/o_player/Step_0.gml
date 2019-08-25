
vsp = vsp + grv;


switch (state)
{
	case "move":
		#region Move State

		if place_meeting(x, y+1, o_wall) && keyboard_check(vk_nokey){
			isRunning = false
			sprite_index=s_wah_idle
			image_speed=0.15
		}
// aerial animations
		if !place_meeting(x, y+1, o_wall) && gliding < 1
		{
			sprite_index=s_wah_jump;
			image_speed = 0.175;
		}
		
		if gliding == 1
		{
			isRunning = false
			sprite_index = s_wah_glide;
		}
		
//horizontal movement and collision

		if isRunning == true {
			sprite_index=s_wah_run;
		}
		if input.right && place_meeting(x, y+1, o_wall)
		{
			move_and_collide(walksp, 0);
			isRunning = true;
			image_xscale = 1;
			image_speed = 0.4;	
		}
		
		if input.right && !place_meeting(x, y+1, o_wall)
		{
			isRunning = false
			move_and_collide(walksp, 0);
			image_xscale = 1;
		}

		if input.left && place_meeting(x, y+1, o_wall)
		{
			move_and_collide(-walksp,0);
			isRunning = true;
			image_xscale = -1;
			image_speed = 0.4;
		}
		
		if input.left && !place_meeting(x, y+1, o_wall)
		{
			isRunning = false
			move_and_collide(-walksp,0);
			image_xscale = -1;
		}
	

// jumping and multi jumping
		if place_meeting(x, y+1, o_wall) 
		{
			airjump = 1;
			vsp = 0;
			
			if input.jump {
			vsp = -jsp;
			}
		
} else {
			if (vsp < 12) 
			{
				vsp += grv;
			}
	
			if airjump > 0 
				{
					if input.jump
					{
						vsp = -jsp;
						airjump -= 1;	
					}

				}
		}
	
// variable jumping
		
		if (vsp < 0) && (!input.jump_held) vsp = max(vsp,0)
		
//tranition to roll state
		if input.roll and place_meeting(x, y+1, o_wall)
		{
			state = "roll";
		}
		
		
//transition to attack one
		if input.attack
		{
			state = "attack one";
		}

//gliding

		if !place_meeting(x,y+1,o_wall) and input.glide
		{
			gliding = 1;
			grv = .005;
			airjump = 0;
		} else {
		
		if (place_meeting(x,y+1,o_wall)) || input.glide_release
			{
				gliding = 0;
				grv = 0.5;
				airjump += 1;
			}
		}
		
// checking hook
	if input.hook
	{
		
		mx = mouse_x;
		my = mouse_y;
		if !place_meeting(x+1,y,o_wall) && !place_meeting(x-1,y,o_wall) && !place_meeting(x,y-1,o_wall) 
		{
			active = false
		}
		if place_meeting(mx,my,o_wallg)
		{
			active = true;
		}
	}
	
	if active = true 
	{
		x += (mx-x) * 0.1;
		y += (my-y) * 0.1;
		grv = 0;
		airjump = 0;
	}
	if input.hook_release
	{
		active = false;
		grv = 0.5;
		airjump = 1
	}
		
		#endregion
		break;

		
	case "roll":
	
		#region Roll State
		set_state_sprite(s_skeleton_roll_7, 0.6, 0);
	
		if image_xscale == 1 
		{
			move_and_collide(rollspd, 0);
		}
		if image_xscale == -1 
		{
			move_and_collide(-rollspd, 0);
		}
		#endregion
		break;

	case "attack one":
		#region Attack One State

		set_state_sprite(s_side_attack, 0.4, 1)
		
		if !place_meeting(x,y+1,o_wall)
			{
				if input.right
				{
					move_and_collide(4,0)
				}
				if input.left
				{
					move_and_collide(-4,0)
				}
			}
			

		if input.attack and animation_hit_frame_range(6,8)
			{
				state = "attack two";
			}
		#endregion
		break;
		
	case "attack two":
		#region Attack Two State
		set_state_sprite(s_attack_ground_down, 0.6, 0);
		if !place_meeting(x,y+1,o_wall)
			{
				if input.right
				{
					image_xscale = 1;
					move_and_collide(4,0)
				}
				if input.left
				{
					image_xscale = -1;
					move_and_collide(-4,0)
				}
			}
		
		if input.attack and animation_hit_frame_range(2,5)
			{
				state = "attack three";
			}
		#endregion
		break;
		
	case "attack three":
		#region Attack Three State
		set_state_sprite(s_attack_ground_down, 0.6, 0);
		image_yscale = -1;
		if !place_meeting(x,y+1,o_wall)
			{
				if input.right
				{
					image_xscale = 1;
					move_and_collide(4,0)
				}
				if input.left
				{
					image_xscale = -1;
					move_and_collide(-4,0)
				}
			}

		
		#endregion
		break;
}




// Vertical Collision
	
		if place_meeting(x, y+vsp, o_wall)
		{
			while !place_meeting(x, y+sign(vsp), o_wall)
			{
				y = y+sign(vsp)
			}
			vsp = 0;	
		}
		y = y + vsp;
		
//Horizontal Collision
		/*if place_meeting(x+hsp, y, o_wall)
		{
			while !place_meeting(x+sign(hsp), y, o_wall)
			{
				x = x+sign(hsp)
			}
			hsp = 0;
		}
		
		x = x + vsp; */
