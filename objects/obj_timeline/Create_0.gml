/*ini_open("info.ini")
if ini_read_real("start", 1, 1) {
	if show_question("Sembra che sia la tua prima volta in Timeline.\nVuoi capire come si usa?") {
		url_open(game_save_id + "h.html")
	}
}
ini_close()
*/

window_set_caption("Timeline")

if !file_exists("linea.ini") {
	show_message($"File linea.ini non trovato! {game_save_id}")
	game_restart()
}

ini_open("linea.ini")

window_set_caption(ini_read_string("info", "caption", "Timeline"))
debug = ini_read_string("info", "debug", "false") == "true"

var i = 0
while (ini_section_exists(i)) {
	var anno = ini_read_string(i, "a", 0)
	var descrizione = ini_string(ini_read_string(i, "des", ""))
	var immagine = importa_immagine(ini_read_string(i, "imm", "none"))
	var dimensioni = ini_read_real(i, "dim", 1)
	anni[i] = nuovo_anno(anno, descrizione, immagine, dimensioni)
	i++
}

if i == 0 {
	show_message("Nessun anno trovato nel file linea.ini!")
	game_end(1)
}

i = 0
while (ini_section_exists($"intro{i}")) {
	var sezioneCorrente = $"intro{i}"
	var iniHeader = ini_read_string(sezioneCorrente, "header", "")
	var header = ini_string(iniHeader)
	var headerIntroNewLineCount = string_count("&&", iniHeader)
	var headerdim = ini_read_real(sezioneCorrente, "headerdim", 1)
	var headerdove = ini_read_string(sezioneCorrente, "headerdove", "affianco")
	var introimm = importa_immagine(ini_read_string(sezioneCorrente, "imm", "none"))
	var introimmdim = ini_read_real(sezioneCorrente, "dim", 1)
	var introimmdove = ini_read_string(sezioneCorrente, "immdove", "sin")
	var descrizioneIntro = ini_string(ini_read_string(sezioneCorrente, "text", ""))
	var descrizioneIntroDim = ini_read_real(sezioneCorrente, "textdim", 1)
	intro[i] = nuova_intro(header, headerIntroNewLineCount, headerdim, headerdove, introimm, introimmdim, introimmdove, descrizioneIntro, descrizioneIntroDim)
	i++
}

introCorrente = i == 0 ? -1 : 0

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