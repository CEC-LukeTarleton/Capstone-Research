extends Area2D

@export var healAmount: int = 1

func _on_area_entered(area: Area2D) -> void:
	if area.name == "hurtbox":
		var player = area.get_parent()
		player.heal(healAmount)
