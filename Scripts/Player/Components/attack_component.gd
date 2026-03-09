extends Node
class_name AttackComponent

@export var attack_damage: int = 1
@export var attack_coldown: float = 0.3
@export var turn_off_hitbox_timer: float = 0.1

@export var parent: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var attack_area: Area2D

var can_attack: bool = true
var is_attacking: bool = false
var coldown_timer: Timer

func _ready():
	attack_area.monitoring = false
	attack_area.body_entered.connect(_on_attack_area_entered)
	
	coldown_timer = Timer.new()
	coldown_timer.one_shot = true
	coldown_timer.timeout.connect(_on_coldown_finished)
	add_child(coldown_timer)

func attack() -> void:
	if not can_attack:
		return
	
	is_attacking = true
	animated_sprite.play("attack")
	attack_area.monitoring = true
	
	await get_tree().create_timer(turn_off_hitbox_timer).timeout
	attack_area.monitoring = false
	
	can_attack = false
	coldown_timer.start(attack_coldown)
	
	await animated_sprite.animation_finished
	is_attacking = false
	

func _on_coldown_finished():
	can_attack = true

func _on_attack_area_entered(body: Node) -> void:
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(attack_damage)
