extends Node2D
const funcGen = preload ("res://Script/Controller/Shapes.gd")

var obj


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	obj = funcGen.new(self)


		
# Called every frame. 'delta' is the elapsed time since the previous frame.
var d = 0.0
var speed = 12.0
var sudut = 0

func _input(event):
	if event.is_action_pressed("stop"):
		get_tree().change_scene("res://Scene/Pola/Pola Page.tscn")

	if event.is_action_pressed("speed_1"):
		speed = 12.0

	if event.is_action_pressed("speed_2"):
		speed = 14.0

	if event.is_action_pressed("speed_3"):
		speed = 20.0

	if event.is_action_pressed("reverse"):
		speed = -3.0

func _process(delta):
	d += delta
	if sudut <= 360 :
		sudut += 20
	else :
		sudut = 0
	update()
	


func _on_Animasi_Page_draw():
	var center_x = get_viewport_rect().size.x / 2
	var center_y = get_viewport_rect().size.y / 2
	var midpoint = Vector2(center_x, center_y)
	var radius = 100
	
#	obj.lingkaran(midpoint.x + (sin(d*speed)*radius), midpoint.y + (cos(d*speed)*radius), radius, Color('#ffffff'))

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
	var radius_orbit_merkurius = 100
	var midpoint_merkurius = Vector2(center_x + (sin(d*(speed+2))*radius_orbit_merkurius), center_y + (cos(d*(speed+2))*radius_orbit_merkurius))
	obj.Merkurius(midpoint_merkurius, radius_merkurius)
	
#	Venus
	var radius_venus = 20
	var radius_orbit_venus = 100+25
	var midpoint_venus = Vector2(center_x + (sin(d*(speed+1))*radius_orbit_venus), center_y + (cos(d*(speed+1))*radius_orbit_venus))
	obj.Venus(midpoint_venus, radius_venus)
	
#	Bumi
	var radius_bumi = 20
	var radius_orbit_bumi = 100+25+25
	var midpoint_bumi = Vector2(center_x + (sin(d*(speed))*radius_orbit_bumi), center_y + (cos(d*(speed))*radius_orbit_bumi))
	obj.Bumi(midpoint_bumi, radius_bumi)

#	Bulan
	var radius_bulan = 5
	var radius_orbit_bulan = 35
	var midpoint_bulan = Vector2(midpoint_bumi.x + (sin(d*(speed+5))*radius_orbit_bulan), midpoint_bumi.y + (cos(d*(speed+5))*radius_orbit_bulan))
	obj.Bulan(midpoint_bulan, radius_bulan)
	
#	Mars
	var radius_mars = 21
	var radius_orbit_mars = 100+25+25+25
	var midpoint_mars = Vector2(center_x + (sin(d*(speed-1))*radius_orbit_mars), center_y + (cos(d*(speed-1))*radius_orbit_mars))
	obj.Mars(midpoint_mars, radius_mars)

#	Jupiter
	var radius_jupiter = 25
	var radius_orbit_jupiter = 225
	var midpoint_jupiter = Vector2(center_x + (sin(d*(speed-3))*radius_orbit_jupiter), center_y + (cos(d*(speed-3))*radius_orbit_jupiter))
	obj.Jupiter(midpoint_jupiter, radius_jupiter)

#	Saturnus
	var radius_saturnus = 30
	var radius_orbit_saturnus = 225+25
	var midpoint_saturnus = Vector2(center_x + (sin(d*(speed-5))*radius_orbit_saturnus), center_y + (cos(d*(speed-5))*radius_orbit_saturnus))
	obj.Saturnus(midpoint_saturnus, radius_saturnus)

#	Uranus
	var radius_uranus = 23
	var radius_orbit_uranus = 225+25+25
	var midpoint_uranus = Vector2(center_x + (sin(d*(speed-7))*radius_orbit_uranus), center_y + (cos(d*(speed-7))*radius_orbit_uranus))
	obj.Uranus(midpoint_uranus, radius_uranus)
	
#	Neptunus
	var radius_neptunus = 23
	var radius_orbit_neptunus = 225+25+25+25
	var midpoint_neptunus = Vector2(center_x + (sin(d*(speed-10))*radius_orbit_neptunus), center_y + (cos(d*(speed-10))*radius_orbit_neptunus))
	obj.Neptunus(midpoint_neptunus, radius_neptunus)
