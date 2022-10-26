extends Node2D
const funcGen = preload ("res://Script/Controller/Shapes.gd")

var obj

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sudut = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	obj = funcGen.new(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("Back_Pola"):
		get_tree().change_scene("res://Scene/Main Menu/Main Page.tscn")
		
	if event.is_action_pressed("play"):
		get_tree().change_scene("res://Scene/Animasi/Animasi Page.tscn")
		
func _on_Pola_Page_draw():
	var center_x = get_viewport_rect().size.x / 2
	var center_y = get_viewport_rect().size.y / 2
	var midpoint = Vector2(center_x, center_y)

#	Orbit Dalam
	var radius_orbit_dalam = 100
	obj.Orbit_Dalam(midpoint,radius_orbit_dalam)

#	Orbit Luar
	var radius_orbit_luar = 225
	obj.Orbit_Luar(midpoint,radius_orbit_luar)

#	Matahari
	var radius_matahari = 50
	obj.Matahari(midpoint, radius_matahari, sudut)
	
#	Merkurius
	var radius_merkurius = 15
	var midpoint_merkurius = Vector2(center_x+100, center_y)
	obj.Merkurius(midpoint_merkurius, radius_merkurius)
	
#	Venus
	var radius_venus = 20
	var midpoint_venus = Vector2(center_x-100-25, center_y)
	obj.Venus(midpoint_venus, radius_venus)
	
#	Bumi
	var radius_bumi = 20
	var midpoint_bumi = Vector2(center_x+100+25+25, center_y)
	obj.Bumi(midpoint_bumi, radius_bumi)

#	Bulan
	var radius_bulan = 5
	var midpoint_bulan = Vector2(center_x+100+25+25+20+10, center_y)
	obj.Bulan(midpoint_bulan, radius_bulan)

#	Mars
	var radius_mars = 21
	var midpoint_mars = Vector2(center_x-100-25-25-25, center_y)
	obj.Mars(midpoint_mars, radius_mars)

#	Jupiter
	var radius_jupiter = 25
	var midpoint_jupiter = Vector2(center_x+225, center_y)
	obj.Jupiter(midpoint_jupiter, radius_jupiter)

#	Saturnus
	var radius_saturnus = 30
	var midpoint_saturnus = Vector2(center_x-225-25, center_y)
	obj.Saturnus(midpoint_saturnus, radius_saturnus)

#	Uranus
	var radius_uranus = 23
	var midpoint_uranus = Vector2(center_x+225+25+25, center_y)
	obj.Uranus(midpoint_uranus, radius_uranus)
	
#	Neptunus
	var radius_neptunus = 23
	var midpoint_neptunus = Vector2(center_x-225-25-25-25, center_y)
	obj.Neptunus(midpoint_neptunus, radius_neptunus)
	
