extends Weapon

export (NodePath) var follow_target_path
export var left_turn_max = -90
export var right_turn_max = 90
export var left_turn_speed = 360
export var right_turn_speed = -360

var follow_target = null
var rad_left_turn_speed
var rad_right_turn_speed
var follow_offset = Vector3(0,0,0)

func _ready():
	follow_target = get_node(follow_target_path)
	rad_left_turn_speed = deg2rad(left_turn_speed)
	rad_right_turn_speed = deg2rad(right_turn_speed)
	
	if follow_target != null:
		follow_offset = translation - follow_target.translation
	pass

func _process(delta):
	if follow_target != null:
		translation = follow_offset + follow_target.translation
	pass

func attack_left_continious(time):
	rotate_y(rad_left_turn_speed*time)
	pass

func attack_right_continious(time):
	rotate_y(rad_right_turn_speed*time)
	pass