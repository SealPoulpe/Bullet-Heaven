class_name Tile
extends Node2D

const Player = preload("res://Scenes/Player/Player.gd")
var grid_x;
var grid_y;

signal tile_entered(body: Player)

func _ready():
	get_node("RichTextLabel").text = "(" + str(grid_x) + ", " + str(grid_y) +")"
	pass 


func _on_body_entered(body):
	var player = body as Player
	if not player:
		return;
	
	tile_entered.emit(body)
