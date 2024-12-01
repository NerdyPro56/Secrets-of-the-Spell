extends Area2D

# Variables
var speed = 300

var target: CharacterBody2D = null
var damage = 20
@onready var player: CharacterBody2D = $".."
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var enabled = false
# Set the player reference
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready():
	_target_character_body()
func _process(delta):
	if enabled:
		if target and is_instance_valid(target):
			var direction = (target.global_position - global_position).normalized()
			global_position += direction * speed * delta
			rotation = direction.angle()
			enabled = false
		else:
			if animated_sprite_2d.flip_h:
				animation_player.play("arrowNull_2")
				enabled = false
			else:
				animation_player.play("arrowNull")
				enabled = false

func _on_Area2D_body_entered(body):
	if body is CharacterBody2D and body != player:
		if body.has_method("hurt"):
			body.hurt(damage)
		enabled = false
		visible = false
func _target_character_body():
	# Search the entire scene for CharacterBody2D nodes
	var all_nodes = get_tree().get_root().get_children()
	for node in all_nodes:
		if node is CharacterBody2D and node != self and node != player:
			target = node
			return
