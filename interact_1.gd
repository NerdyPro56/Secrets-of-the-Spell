extends Area2D
@onready var textbox: CanvasLayer = $"../Textbox"
var entered = false
var talking = false
@onready var player: CharacterBody2D = $"../player"
@onready var laser: AudioStreamPlayer = $"../Wizard/Mixkit-cinematic-laser-gun-thunder-1287"
@onready var timer: Timer = $"../Wizard/Timer"
var amogus = false
@onready var animation_player: AnimationPlayer = $"../Wizard/AnimationPlayer"
@onready var timer_3: Timer = $"../Wizard/Timer3"
@onready var e: Sprite2D = $"../Wizard/e"
@onready var timer_2: Timer = $"../Wizard/Timer2"
@onready var fire: AudioStreamPlayer = $"../fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")) && entered == true && talking == false:
		e.visible = false
		player.cutscene = true
		talking = true
		textbox.queue_text("Welcome...                ")
		textbox.queue_text("I see you have come to learn about my magic                 ")
		textbox.queue_text("In that case...              ")
		textbox.queue_text("YOU MUST PROVE THAT YOUR ARE WORTHY!              ")
		timer.start()
	if talking and (textbox.current_state == textbox.State.FINISHED or textbox.current_state == textbox.State.READY) and amogus:
		fire.stop()
		animation_player.play("wand")
		amogus = false
		timer_3.start()

func _on_body_entered(body: CharacterBody2D) -> void:
	print("entered")
	entered = true
	e.visible = true

func _on_body_shape_exited(body_rid: RID, body: CharacterBody2D, body_shape_index: int, local_shape_index: int) -> void:
	print("exited")
	entered = false
	e.visible = false


func _on_timer_timeout() -> void:
	amogus = true
