/*ini_open("info.ini")
if ini_read_real("start", 1, 1) {
	if show_question("Sembra che sia la tua prima volta in Timeline.\nVuoi capire come si usa?") {
		url_open(game_save_id + "h.html")
	}
}
ini_close()
*/

if !file_exists("linea.ini") {
	show_message("File linea.ini non trovato!")
	game_end(1)
}

ini_open("linea.ini")

window_set_caption(ini_read_string("info", "caption", "Timeline"))

for (var i = 0; ini_section_exists(i); i++) {
	anno = ini_read_real(i, "a", 0)
	descrizione = ini_string(ini_read_string(i, "des", ""))
	file = ini_read_string(i, "imm", "")
	if file == "none"
		immagine = spr_none
	else if !file_exists(file) {
		show_message("File " + file + " non trovato!")
		game_end(1)
	} else
		immagine = sprite_add(file, 1, false, false, 0, 0)
	dimensioni = ini_read_real(i, "dim", 0)
	anni[i] = nuovo_anno(anno, descrizione, immagine, dimensioni)
}

header = ini_string(ini_read_string("intro", "header", ""))
textdim = ini_read_real("intro", "textdim", 1)
ini_close()

intro = 1
exMouseX = mouse_x
exMouseY = mouse_y
cerchioX = room_width / 2
timer = 0
mouseTimer = 0
animStep = 0
annoCorrente = 0
trasparenzaFrecce = 1
timerSuOGiu = false
y = 650