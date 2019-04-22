extends Spatial

export (NodePath) var cam_path
export var acceleration = 5
export var movement_friction = 9
export var stopping_friction = 4.5

export var angular_speed = 270
export var movement_speed = 10
export var gravity = 9.81

var dir = Vector3(0,0,0)
var vel = Vector3(0,0,0)
var camera = null
var rad_angular_speed

func _ready():
	camera = get_node(cam_path)
	rad_angular_speed = deg2rad(angular_speed)
	$"Player Sword".connect("on_dealt_damage",self,"_on_damage_dealt")
	pass

func _on_damage_dealt():
	
	pass

func _process(delta):
	_read_input()
	_apply_turning(delta)
	_update_vel(delta)
	_apply_vel()
	
	_attack(delta)
	pass

func _attack(time):
	if Input.is_action_pressed("attack_right"):
		$"Player Sword".attack_right_continious(time)
	if Input.is_action_pressed("attack_left"):
		$"Player Sword".attack_left_continious(time)
	pass

func _read_input():
	dir = Vector3(0,0,0)
	
	if Input.is_action_pressed("right"):
		dir.x-=1
	if Input.is_action_pressed("left"):
		dir.x+=1
	if Input.is_action_pressed("forward"):
		dir.z+=1
	if Input.is_action_pressed("backward"):
		dir.z-=1
	
	pass

func _apply_turning(time):
	$"Player Body".rotate_y(dir.x*rad_angular_speed*time)
	pass

func _update_vel(time):
	var xz_vel = dir.z*$"Player Body".transform.basis.z*movement_speed
	var y_vel = -1*gravity*time
	
	var friction = movement_friction
	
	if xz_vel == Vector3(0,0,0):
		friction = stopping_friction
	
	vel.x = lerp(vel.x,xz_vel.x,friction*time)
	vel.z = lerp(vel.z,xz_vel.z,friction*time)
	
	vel.y = vel.y + y_vel
	pass

func _apply_vel():
	vel = $"Player Body".move_and_slide(vel,Vector3.UP)
	pass

func _four_dir_movement():
	dir = dir.normalized()
	vel = dir*movement_speed
	
	if dir != Vector3(0,0,0):
		look_at(transform.origin-dir,Vector3.UP)
	pass