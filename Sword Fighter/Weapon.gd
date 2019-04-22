extends Area
class_name Weapon

signal on_dealt_damage
export var damage = 1

func _ready():
	connect("area_entered",self,"_on_area_entered")
	pass

func _on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		emit_signal("on_dealt_damage")
	pass

func attack_left_continious(delta):
	
	pass

func attack_right_continious(delta):
	
	pass