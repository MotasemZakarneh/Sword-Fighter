extends Spatial

export (NodePath) var cam_path
var dir = Vector3(0,0,0)
var camera = null

func _ready():
	camera = get_node(cam_path)
	$"Player Sword".connect("on_dealt_damage",self,"_on_damage_dealt")
	pass

func _on_damage_dealt():
	
	pass

func _process(delta):
	_read_input()
	$"Player Body".recieve(dir)
	
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