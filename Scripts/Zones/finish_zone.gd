extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node):
	if body.is_in_group("player"):
		print("Level FInished. Restart Level")
		get_tree().reload_current_scene()
