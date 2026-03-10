extends CharacterBody2D

@export var movement: MovementComponent
@export var health: HealthComponent
@export var attack: AttackComponent

func _ready():
	add_to_group("player")
	
	if health:
		health.died.connect(_on_died)
	

func _physics_process(delta: float) -> void:
	if not movement:
		return
		
	var direction = Input.get_axis("left", "right")
	movement.move(delta, direction)
	
	if Input.is_action_just_pressed("jump"):
		movement.jump()
		
	if Input.is_action_just_pressed("attack"):
		attack.attack()
		
func take_damage(amout: int):
	if health:
		health.take_damage(amout)
		
func _on_died():
	queue_free()
