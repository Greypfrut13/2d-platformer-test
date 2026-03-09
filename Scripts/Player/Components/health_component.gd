extends Node
class_name HealthComponent

signal died
signal health_changed(current: int)

@export var max_health: int = 3

var current_health: int

func _ready():
	current_health = max_health
	health_changed.emit(current_health)
	
func take_damage(damage: int) -> void:
	if current_health <= 0:
		return
	
	current_health -= damage
	health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()
		
		
func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health)
