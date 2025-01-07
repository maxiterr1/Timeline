/*ini_open("info.ini")
if ini_read_real("start", 1, 1) {
	if show_question("Sembra che sia la tua prima volta in Timeline.\nVuoi capire come si usa?") {
		url_open(game_save_id + "h.html")
	}
}
ini_close()
*/

if !file_exists("linea.ini") {
	show_message($"File linea.ini non trovato! {game_save_id}")
	game_end(1)
}

ini_open("linea.ini")

window_set_caption(ini_read_string("info", "caption", "Timeline"))

for (var i = 0; ini_section_exists(i); i++) {
	anno = ini_read_real(i, "a", 0)
	descrizione = ini_string(ini_read_string(i, "des", ""))
	immagine = importa_immagine(ini_read_string(i, "imm", "none"))
	dimensioni = ini_read_real(i, "dim", 1)
	anni[i] = nuovo_anno(anno, descrizione, immagine, dimensioni)
}

if ini_section_exists("intro") {
	intro = 1
	iniHeader = ini_read_string("intro", "header", "")
	header = ini_string(iniHeader)
	headerIntroNewLineCount = string_count("&&", iniHeader)
	headerdim = ini_read_real("intro", "headerdim", 1)
	headerdove = ini_read_string("intro", "headerdove", "affianco")
	introimm = importa_immagine(ini_read_string("intro", "imm", "none"))
	introimmdim = ini_read_real("intro", "dim", 1)
	descrizioneIntro = ini_string(ini_read_string("intro", "text", ""))
	descrizioneIntroDim = ini_read_real("intro", "textdim", 1)
} else intro = 2

ini_close()

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