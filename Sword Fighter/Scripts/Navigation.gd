extends Navigation

func _ready():
	Global.nav = self
	connect("tree_exiting",self,"_on_out_of_scene")
	pass

func _on_out_of_scene():
	Global.nav = null
	pass