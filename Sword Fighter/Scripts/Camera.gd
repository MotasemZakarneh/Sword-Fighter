extends Camera

export (NodePath) var follow_target_path
export var follow_speed = 15
export var follow_dist = 5

var offset = Vector3(0,0,0)
var follow_target : KinematicBody = null

func _ready():
	follow_target = get_node(follow_target_path)
	connect("tree_exiting",self,"_on_out_of_scene")
	Global.main_cam = self
	offset = transform.origin - follow_target.transform.origin
	pass

func _physics_process(delta):
	var target = follow_target.transform.origin+offset
	transform.origin = transform.origin.linear_interpolate(target,follow_speed*delta)
	pass

func _on_out_of_scene():
	Global.main_cam = null
	pass

func shake_u(mag,dur):
	$Shaker.shake(mag,dur)
	pass

func shake():
	$Shaker.shake()
	pass