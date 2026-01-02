extends CanvasLayer

signal start_game # game has started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_message(text: String) -> void:
	$Message.text = text;
	$Message.show();
	$MessageTimer.start();


func show_game_over() -> void:
	show_message("Game Over");
	await $MessageTimer.timeout; # wait for the message timer to finish

	$Message.text = "Dodge the Creeps!";
	$Message.show();

	# Make one shot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout;
	$StartButton.show();


func update_score(score: int) -> void:
	$ScoreLabel.text = str(score);



func _on_start_button_pressed() -> void:
	$StartButton.hide();
	start_game.emit();


func _on_message_timer_timeout() -> void:
	$Message.hide();
