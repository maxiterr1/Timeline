draw_line_width(160, room_height, 160, 0, 10)
draw_circle(160, altezzaCerchio, 34, false)
draw_text_ext_transformed(220 , altezzaCerchio - 20, anni[annoCorrente], 4, 9, 2, 2, 18)

if keyboard_check_released(vk_up) || mouse_wheel_up() {
	animStep = 1
}

if keyboard_check_released(vk_down) || mouse_wheel_down() {
	animStep = 3	
}

if animStep != 0 && animStep < 3 {
	if annoCorrente != array_length(anni) - 1 && animStep == 1{
		altezzaCerchio -= 7
	}
	
	if altezzaCerchio <= 0 {
		show_debug_message("Tolgo cerchio")
		altezzaCerchio = room_height + 70
		animStep = 2
		annoCorrente++
	}
	
	if altezzaCerchio > room_height / 2 && animStep == 2 {
		altezzaCerchio -= 7
	}
	
} else {
	if annoCorrente != 0 && animStep == 3{
		altezzaCerchio += 7
	}
	
	if altezzaCerchio >= room_height + 70 {
		show_debug_message("Tolgo cerchio")
		altezzaCerchio = 0
		animStep = 4
		annoCorrente--
	}
	
	if altezzaCerchio < room_height / 2 && animStep == 4 {
		altezzaCerchio += 7
	}
}