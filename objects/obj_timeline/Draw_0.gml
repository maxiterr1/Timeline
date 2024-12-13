// Disegna la linea della timeline
draw_line_width(160, room_height, 160, 0, 10)

// Disegna il cerchio
draw_circle(160, altezzaCerchio, 34, false)

// Imposta la font
draw_set_font(fnt_font)

// Scrivi l'anno affianco al cerchio
draw_text_transformed(220 , altezzaCerchio - 20, anni[annoCorrente], 1, 1, 18)

// Disegna l'immagine dell'anno
draw_sprite_ext(immagine[annoCorrente], -1, 400, altezzaCerchio - sprite_get_height(immagine[annoCorrente]) * dimensioni[annoCorrente], dimensioni[annoCorrente], dimensioni[annoCorrente], 0, -1, 1)


// Scrivi la descrizione
draw_text(400, altezzaCerchio + 20, descrizione[annoCorrente])

// Se la timeline non si sta muovendo
if animStep == 0 {
	// Disegna la freccia verso su
	if annoCorrente != array_length(anni) - 1 {
		draw_sprite_ext(spr_freccia, -1, 160 - sprite_get_width(spr_freccia) / 2 * 0.5, -timer + sprite_get_height(spr_freccia) * 0.5 + 40, 0.5, 0.5, 90, -1, trasparenzaFrecce)
	}

	// Disegna la freccia verso giù
	if annoCorrente != 0 {
		draw_sprite_ext(spr_freccia, -1, 160 + sprite_get_width(spr_freccia) / 2 * 0.5, room_height + timer - sprite_get_height(spr_freccia) * 0.5 - 40, 0.5, 0.5, -90, -1, trasparenzaFrecce)
	}
}

// Se l'utente ha cliccato la freccia su sulla tastiera o è andato su con la rotella del mouse
if keyboard_check_released(vk_up) or mouse_wheel_up() {
	// Avvia l'animazione verso l'anno successivo
	animStep = 1
	
	// Imposta il timer del mouse per la trasparenza delle frecce a 0
	mouseTimer = 0
}

// Se l'utente ha cliccato la freccia giù sulla tastiera o è andato giù con la rotella del mouse
if keyboard_check_released(vk_down) or mouse_wheel_down() {
	// Avvia l'animazione verso l'anno precedente
	animStep = 3
	
	// Imposta il timer del mouse per la trasparenza delle frecce a 0
	mouseTimer = 0
}

// Se c'è un'animazione verso l'anno successivo in corso
if animStep != 0 and animStep < 3 {
	
	// Controlla se si può passare all'anno successivo controllando se non è l'ultimo 
	// valore dell'array di anni. Se non lo è, avvia l'animazione verso giù.
	// altezzaCerchio < room_height / 2 risolve un bug non importante.
	if (annoCorrente != array_length(anni) - 1 or altezzaCerchio < room_height / 2) and animStep == 1
		// Porta giù il cerchio di 7 pixel
		altezzaCerchio += 7
	
	// Controlla se il cerchio ha raggiunto la fine della stanza verso il basso
	if altezzaCerchio >= room_height + 70 {
		// Imposta l'altezza del cerchio alla massima altezza della stanza per portarlo sopra
		altezzaCerchio = 0
		
		// Imposta l'animazione verso giù dall'alto fino a metà stanza
		animStep = 2
		
		// Prossimo anno
		annoCorrente++
	}
	
	if altezzaCerchio <= room_height / 2 and animStep == 2
		altezzaCerchio += 7

// Se c'è un'animazione verso l'anno precedente in corso,
// Succede la stessa cosa dell'anno successivo, ma tutto invertito.
} else {
	if (annoCorrente != 0 or altezzaCerchio > room_height / 2) and animStep == 3
		altezzaCerchio -= 7
	
	
	if altezzaCerchio <= 0 {
		altezzaCerchio = room_height + 70
		animStep = 4
		annoCorrente--
	}
	
	if altezzaCerchio > room_height / 2 and animStep == 4
		altezzaCerchio -= 7

}

// Se non c'è nessuna animazione in corso, imposta il flag di animazione su 0
if altezzaCerchio == room_height / 2 + 1 or altezzaCerchio == room_height / 2 - 1
	animStep = 0