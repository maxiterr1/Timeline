var immagineVeraAmpiezza = sprite_get_width(anni[annoCorrente].immagine) * anni[annoCorrente].dimensioni
var immagineAnnoX = cerchioX - immagineVeraAmpiezza / 2 - room_height / 2
var immagineAnnoY = y - 600

// Disegna la linea della timeline
draw_line_width(room_width, y, 0, 650, 10)

// Disegna il cerchio
draw_circle(cerchioX, y, 34, false)

// Imposta la font
draw_set_font(fnt_font)

// Scrivi l'anno sopra il cerchio
draw_text_transformed(cerchioX - 15, y - 60, anni[annoCorrente].anno, 1, 1, 60)

// Disegna l'immagine dell'anno
draw_sprite_ext(anni[annoCorrente].immagine, -1, immagineAnnoX, immagineAnnoY, anni[annoCorrente].dimensioni, anni[annoCorrente].dimensioni, 0, -1, 1)

// Scrivi la descrizione
draw_text(immagineAnnoX + immagineVeraAmpiezza + 20, immagineAnnoY /*+ immagineVeraAltezza / 1.5*/, anni[annoCorrente].descrizione)

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
	if (annoCorrente != array_length(anni) - 1 or cerchioX < room_width / 2) and animStep == 1
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
	
	if cerchioX <= room_width / 2 and animStep == 2
		cerchioX += 10

// Se c'è un'animazione verso l'anno precedente in corso,
// Succede la stessa cosa dell'anno successivo, ma tutto invertito.
} else {
	if (annoCorrente != 0 or cerchioX > room_width / 2) and animStep == 3
		cerchioX -= 10
	
	
	if cerchioX <= 0 {
		cerchioX = room_width + 70
		animStep = 4
		annoCorrente--
	}
	
	if cerchioX > room_width / 2 and animStep == 4
		cerchioX -= 10

}

// Se non c'è nessuna animazione in corso, imposta il flag di animazione su 0
// e il cerchio al centro perfetto.
if cerchioX == 676 or cerchioX == 690 {
	animStep = 0
	cerchioX = room_width / 2
}
//676