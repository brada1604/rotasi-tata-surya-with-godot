extends "res://Script/Controller/primitif.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(ci: CanvasItem).(ci):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func linear(x):
	var y = (2*x)-150
	
	while (x < 150):
		put_pixel(x+514, 300-y, Color('#fcfc03'))
		x = x + 0.1
		y = (2*x)-150
pass

func linear_poin_poin(x):
	var y = (2*x)-150
	
	while (x < 150):
		put_pixel(x+514, 300-y, Color('#fcfc03'))
		x = x + 2
		y = (2*x)-150
pass

func kuadratik(x):
	var y = (2*pow(x,2))-12*x+9
	
	while (x < 200):
		put_pixel(x+514, 300-y, Color('#03fc39'))
		x = x + 0.01
		y = (2*pow(x,2))-12*x+9
pass

func kuadratik_dash_dash(x):
	var y = (2*pow(x,2))-12*x+9
	
	while (x < 200):
		if (fposmod(y, 3) != 0):
			put_pixel(x+514, 300-y, Color('#03fc39'))
		x = x + 0.1
		y = (2*pow(x,2))-12*x+9
pass

func trigonometri(x):
	var y = sin(3*x)*45
	var z = x*10
	
	while (x < 300):
		put_pixel(z+514, 300-y, Color('#ffffff'))
		x = x + 0.01
		z = x*10
		y = sin(2*x)*45
pass

func trigonometri_point_dash_point(x):
	var y = sin(3*x)*45
	var z = x*10
	
	while (x < 300):
		put_pixel(z+514, 300-y, Color('#ffffff'))
		x = x + 0.1
		z = x*10
		y = sin(2*x)*45
pass