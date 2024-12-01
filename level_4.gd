extends Node2D
@onready var textbox: CanvasLayer = $Textbox
@onready var player: CharacterBody2D = $player
@onready var dark_tension_248083: AudioStreamPlayer = $"Dark-tension-248083"
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dark_tension_248083.play()
	textbox.queue_text("beware of ghosts that are only affected by spells            ")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body == player and !done:
		done = true
		textbox.queue_text("Woah there are tons of swords here!       ")
		textbox.queue_text("You have gotten back your sword!          ")
		player.sword = true


func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		get_tree().change_scene_to_file("res://scenes/finale.tscn")
