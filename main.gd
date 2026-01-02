extends Node

@export var mob_scene: PackedScene;
var score;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop();
	$MobTimer.stop();


func start_game() -> void:
	score = 0;
	$Player.start($StartPosition.position);
	$StartTimer.start();


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate();
	
	var mob_spawn_location = $MobPath/MobSpawnLocation;
	mob_spawn_location.progress_ratio = randf(); # Choose a random location on Path2D.
	
	mob.position = mob_spawn_location.position;
	
	var direction = mob_spawn_location.rotation + PI / 2 # Set the mob's direction perpendicular to the path direction.
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0);
	mob.linear_velocity = velocity.rotated(direction);

	add_child(mob); # spawn the mob by adding it to the main scene

func _on_score_timer_timeout() -> void:
	score += 1;


func _on_start_timer_timeout() -> void:
	$MobTimer.start();
	$ScoreTimer.start();
