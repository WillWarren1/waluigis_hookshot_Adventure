image_speed = 0.4;
state = "move";
isRunning = false

grv = 0.5;
walksp = 4;
rollspd = 6;
jsp = 12;
hsp = 0;
vsp = 0;
airjump = 1;
gliding = 0;

mx = x; //hook x
my = y; //hook y
active = false; //grappling

/// dependencies
input = instance_create_layer(0,0,"Instances", o_input);