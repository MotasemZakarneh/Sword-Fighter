extends KinematicBody

export var movement_friction = 9
export var stopping_friction = 4.5

export var angular_speed = 270
export var movement_speed = 10
export var gravity = 9.81

var rad_angular_speed = 0
var dir = Vector3(0,0,0)
var vel = Vector3(0,0,0)

func _ready():
	rad_angular_speed = deg2rad(angular_speed)
	pass

func recieve(movement_input):
	self.dir = movement_input
	pass

func _physics_process(delta):
	#_apply_turning(delta)
	#_update_vel(delta)
	_four_apply_turn(delta)
	_four_update_vel(delta)
	
	_apply_vel()
	pass

func _apply_turning(time):
	rotate_y(dir.x*rad_angular_speed*time)
	pass

func _update_vel(time):
	var xz_vel = dir.z*transform.basis.z*movement_speed
	var y_vel = -1*gravity*time
	
	var friction = movement_friction
	
	if xz_vel == Vector3(0,0,0):
		friction = stopping_friction
	
	vel.x = lerp(vel.x,xz_vel.x,friction*time)
	vel.z = lerp(vel.z,xz_vel.z,friction*time)
	
	vel.y = vel.y + y_vel
	pass

func _apply_vel():
	vel = move_and_slide(vel,Vector3.UP)
	pass

func _four_update_vel(time):
	dir = dir.normalized()
	var xz_vel = dir*movement_speed
	
	var friction = _get_friction()
	
	vel.y = vel.y+-1*gravity*time
	vel.x = lerp(vel.x,xz_vel.x,friction*time)
	vel.z = lerp(vel.z,xz_vel.z,friction*time)
	pass

func _get_friction():
	if dir == Vector3.ZERO:
		return stopping_friction
	return movement_friction

func _four_apply_turn(time):
	if dir != Vector3(0,0,0):
		rotation.y = atan2(dir.z,-dir.x) + PI/2 + PI
		#var look_point = translation - dir.normalized()
		#var t = transform.looking_at(look_point,Vector3.UP)
		#transform = t
	pass