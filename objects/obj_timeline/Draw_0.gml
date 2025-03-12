// Imposta la font
draw_set_font(fnt_font)

if introCorrente != -1 {
	var immagineVeraAmpiezza = sprite_get_width(intro[introCorrente].introimm) * intro[introCorrente].introimmdim
	var immagineVeraAltezza = sprite_get_height(intro[introCorrente].introimm) * intro[introCorrente].introimmdim
	var headerY
	var headerX
	var descrizioneY
	if intro[introCorrente].headerdove == "affianco" && intro[introCorrente].introimm != spr_none {
		headerX = immagineVeraAmpiezza + 57
		headerY = 50
		descrizioneY = immagineVeraAltezza + 50
	} else {
		headerX = 50
		headerY = immagineVeraAltezza + 50
		descrizioneY = headerY + intro[introCorrente].headerIntroNewLineCount * intro[introCorrente].headerdim * font_get_size(fnt_font) * 2 + 40
	}
	var y_offset = 50
	var x_offset = intro[introCorrente].introimm == spr_none ? 20 : 0
	draw_text_transformed(headerX, headerY, intro[introCorrente].header, intro[introCorrente].headerdim, intro[introCorrente].headerdim, 0)
	draw_text_transformed(50 + x_offset, descrizioneY, intro[introCorrente].descrizioneIntro, intro[introCorrente].descrizioneIntroDim, intro[introCorrente].descrizioneIntroDim, 0)
	var immX = intro[introCorrente].introimmdove == "cen" ? room_width / 2 - immagineVeraAmpiezza / 2 : 50
	draw_sprite_ext(intro[introCorrente].introimm, -1, immX, 50, intro[introCorrente].introimmdim, intro[introCorrente].introimmdim, 0, -1, 1)
	if keyboard_check_released(vk_right) or mouse_wheel_up() {
		if introCorrente != array_length(intro) - 1
			introCorrente++
		else
			introCorrente = -1
	}
	if keyboard_check_released(vk_left) && introCorrente != 0
		introCorrente--
} else {
	if debug {
		var numeroPremuto = keyboard_key - 48
		if numeroPremuto < 10 && numeroPremuto > 0 {
			if numeroPremuto < array_length(anni)
				annoCorrente = numeroPremuto
		}
		if keyboard_check_pressed(vk_space) && annoCorrente != array_length(anni) - 1
				annoCorrente++
	}
	var immagineVeraAmpiezza = sprite_get_width(anni[annoCorrente].immagine) * anni[annoCorrente].dimensioni
	var immagineAnnoX = cerchioX - immagineVeraAmpiezza / 2 - room_height / 2
	var immagineAnnoY = y - 600

	// Disegna la linea della timeline
	draw_line_width(room_width, y, 0, 650, 10)

	// Disegna il cerchio
	draw_circle(cerchioX, y, 34, false)

	// Scrivi l'anno sopra il cerchio
	draw_text_transformed(cerchioX - 15, y - 60, anni[annoCorrente].anno, 1, 1, 60)

	// Disegna l'immagine dell'anno
	draw_sprite_ext(anni[annoCorrente].immagine, -1, immagineAnnoX * 2, immagineAnnoY, anni[annoCorrente].dimensioni, anni[annoCorrente].dimensioni, 0, -1, 1)

	// Scrivi la descrizione
	draw_text(immagineAnnoX * 2 + immagineVeraAmpiezza + 20, immagineAnnoY, anni[annoCorrente].descrizione)

	// Se la timeline non si sta muovendo
	if animStep == 0 {
		// Disegna la freccia verso sinistra
		if annoCorrente != array_length(anni) - 1 {
			draw_sprite_ext(spr_freccia, -1, -timer + sprite_get_height(spr_freccia) * 0.5, y + sprite_get_width(spr_freccia) / 2 * 0.5, 0.5, 0.5, 180, -1, trasparenzaFrecce)
		}

		// Disegna la freccia verso destra
		if annoCorrente != 0 {
			draw_sprite_ext(spr_freccia, -1, room_width - (-timer + sprite_get_width(spr_freccia) * 0.5), y - sprite_get_width(spr_freccia) / 2 * 0.5, 0.5, 0.5, 0, -1, trasparenzaFrecce)
		}
	}

	// Se l'utente ha cliccato la freccia su sulla tastiera o è andato su con la rotella del mouse
	if keyboard_check_released(vk_left) or mouse_wheel_up() {
		// Avvia l'animazione verso l'anno successivo
		animStep = 1
	
		// Imposta il timer del mouse per la trasparenza delle frecce a 0
		mouseTimer = 0
	}

	// Se l'utente ha cliccato la freccia giù sulla tastiera o è andato giù con la rotella del mouse
	if keyboard_check_released(vk_right) or mouse_wheel_down() {
			if annoCorrente == 0 && array_length(intro) != 0
				introCorrente = array_length(intro) - 1
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
		if animStep == 1 and (annoCorrente != array_length(anni) - 1 or cerchioX < room_width / 2)
			// Porta giù il cerchio di 7 pixel
			cerchioX += 10
	
		// Controlla se il cerchio ha raggiunto la fine della stanza verso il basso
		if cerchioX >= room_width + 70 {
			// Imposta l'altezza del cerchio alla massima altezza della stanza per portarlo sopra
			cerchioX = 0
		
			// Imposta l'animazione verso giù dall'alto fino a metà stanza
			animStep = 2
		
			// Prossimo anno
			annoCorrente++
		}
	
		if animStep == 2 and cerchioX <= room_width / 2
			cerchioX += 10

	// Se c'è un'animazione verso l'anno precedente in corso,
	// Succede la stessa cosa dell'anno successivo, ma tutto invertito.
	} else {
		if animStep == 3 and (annoCorrente != 0 or cerchioX > room_width / 2)
			cerchioX -= 10
	
	
		if cerchioX <= 0 {
			cerchioX = room_width + 70
			animStep = 4
			annoCorrente--
		}
	
		if animStep == 4 and cerchioX > room_width / 2
			cerchioX -= 10

	}

	// Se non c'è nessuna animazione in corso, imposta il flag di animazione su 0
	// e il cerchio al centro perfetto.
	if cerchioX == 683 or cerchioX == 690 or cerchioX == 676{
		animStep = 0
		cerchioX = room_width / 2
	}
}