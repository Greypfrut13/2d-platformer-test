extends Node
class_name MovementComponent

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0

@export var parent: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_facing_right: bool = true;


func move(delta: float, direction: float) -> void:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta
		
	if direction != 0:
		parent.velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, speed)
		
	parent.move_and_slide()
	
	_update_animation(direction)

func jump() -> void:
	if parent.is_on_floor():
		parent.velocity.y = jump_velocity
		animated_sprite.play("jump")

func _update_animation(direction: float) -> void:
	if not parent.is_on_floor():
		if animated_sprite.animation != "jump":
			animated_sprite.play("jump")
	elif direction != 0:
		if animated_sprite.animation != "run":
			animated_sprite.play("run")
	else:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
