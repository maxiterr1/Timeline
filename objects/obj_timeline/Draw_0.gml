draw_line_width(160, room_height, 160, 0, 10)
draw_circle(160, altezzaCerchio, 34, false)
draw_text_transformed(220 , altezzaCerchio - 20, anni[annoCorrente], 1, 1, 18)
draw_sprite_ext(immagine[annoCorrente], -1, 400, altezzaCerchio - sprite_get_height(Sprite1), dimensioni[annoCorrente], dimensioni[annoCorrente], 0, -1, 1)
draw_set_font(fnt_font)
draw_text(400, altezzaCerchio + 20, descrizione[annoCorrente])

//Freccia verso su
if annoCorrente != array_length(anni) - 1 {
	draw_sprite_ext(spr_freccia, -1, 160 - sprite_get_width(spr_freccia) / 2 * 0.5, -timer + sprite_get_height(spr_freccia) * 0.5 + 40, 0.5, 0.5, 90, -1, 1)
}

//Freccia verso giù
if annoCorrente != 0 {
	draw_sprite_ext(spr_freccia, -1, 160 + sprite_get_width(spr_freccia) / 2 * 0.5, room_height + timer - sprite_get_height(spr_freccia) * 0.5 - 40, 0.5, 0.5, -90, -1, 1)
}

if keyboard_check_released(vk_up) || mouse_wheel_up() {
	animStep = 1
}

if keyboard_check_released(vk_down) || mouse_wheel_down() {
	animStep = 3	
}

if animStep != 0 && animStep < 3 {
	if (annoCorrente != array_length(anni) - 1 || altezzaCerchio < room_height / 2) && animStep == 1{
		altezzaCerchio += 7
	}
	
	if altezzaCerchio >= room_height + 70 {
		altezzaCerchio = 0
		animStep = 2
		annoCorrente++
	}
	
	if altezzaCerchio < room_height / 2 && animStep == 2 {
		altezzaCerchio += 7
	}
} else {
	if (annoCorrente != 0 || altezzaCerchio > room_height / 2) && animStep == 3{
		altezzaCerchio -= 7
	}
	
	if altezzaCerchio <= 0 {
		altezzaCerchio = room_height + 70
		animStep = 4
		annoCorrente--
	}
	
	if altezzaCerchio > room_height / 2 && animStep == 4 {
		altezzaCerchio -= 7
	}
}