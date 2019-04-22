extends Area

signal on_zero_hp
export var start_health = 3
var current_health = 0

func _ready():
	current_health = start_health
	if name != "Health":
		name = "Health"
	pass

func take_damage(damage):
	current_health = current_health - damage
	if current_health <=0:
		emit_signal("on_zero_hp")
	pass