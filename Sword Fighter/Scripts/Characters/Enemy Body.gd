extends KinematicBody

export var move_speed =3
export var stopping_dist = 0.5
var curr_point = 0
var path = []

func _physics_process(delta):
	var player = Global.player
	var nav = Global.nav
	
	if player == null or nav == null:
		return
	
	path = nav.get_simple_path(global_transform.origin,player.get_body_position())
	
	if path.size()==0:
		return
	
	var dist = path[0].distance_to(global_transform.origin)
	if dist<stopping_dist:
		path.remove(0)
	
	if path.size()==0:
		return
	
	var dir : Vector3 = (path[0]-global_transform.origin).normalized()
	move_and_slide(dir*move_speed,Vector3.UP)
	
	rotation.y = atan2(dir.z,-dir.x) + PI/2 
	pass