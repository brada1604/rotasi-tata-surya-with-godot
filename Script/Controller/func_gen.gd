extends "res://Script/Controller/line.gd"
#func _process(delta):
#	pass

func _init(ci: CanvasItem).(ci):
	pass
	
func bingkai():
	var left = 10 
	var top = 10
	var right = 1014
	var bottom = 590
	var color = Color( 0.96, 1, 0.98, 1)
	
	#garis atas
	for i in range(left,right):
		put_pixel(i,top,color)
	
	#garis bawah
	for i in range(left,right):
		put_pixel(i,bottom,color)
	
	#garis kiri
	for i in range(top,bottom):
		put_pixel(left,i,color)
	
	#garis kanan
	for i in range(top,bottom):
		put_pixel(right,i,color)
pass
	
func kartesius():
	#garis horizontal
	line_dda(10, 300, 1014, 300, Color( 0.96, 1, 0.98, 1), 'thin')
	#garis vertikal
	line_dda(514, 10, 514, 590, Color( 0.96, 1, 0.98, 1), 'thin')
pass
