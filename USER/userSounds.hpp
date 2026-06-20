/*
*   Hier können eigene Sounds eingebunden werden.
*   Ist in CfgSounds included.
*/

// --- Convoy radio confirmations ------------------------------------------
// Played randomly from GRAD_convoyControl_fnc_start / _fnc_stop.
// titles[]: { time, "" } -> no subtitle. Volume 1, pitch 1.
class GRAD_convoy_start_01 { name = "GRAD_convoy_start_01"; sound[] = { "USER\sounds\convoy_start_01.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_start_02 { name = "GRAD_convoy_start_02"; sound[] = { "USER\sounds\convoy_start_02.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_start_03 { name = "GRAD_convoy_start_03"; sound[] = { "USER\sounds\convoy_start_03.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_start_04 { name = "GRAD_convoy_start_04"; sound[] = { "USER\sounds\convoy_start_04.ogg", 1, 1 }; titles[] = {}; };

class GRAD_convoy_stop_01 { name = "GRAD_convoy_stop_01"; sound[] = { "USER\sounds\convoy_stop_01.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_stop_02 { name = "GRAD_convoy_stop_02"; sound[] = { "USER\sounds\convoy_stop_02.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_stop_03 { name = "GRAD_convoy_stop_03"; sound[] = { "USER\sounds\convoy_stop_03.ogg", 1, 1 }; titles[] = {}; };
class GRAD_convoy_stop_04 { name = "GRAD_convoy_stop_04"; sound[] = { "USER\sounds\convoy_stop_04.ogg", 1, 1 }; titles[] = {}; };



class mission_01_briefing
{
    name = "mission_01_briefing";
    sound[] = { "USER\sounds\mission_01_briefing.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, Zulu — hier OPZ, KOMMEN. Auftrag: Begleitschutz UN-Versorgungs- und Bauzug entlang der Flussroute. Marschweg über die Kontrollpunkte Polka, Emil, Nora, Ida, Samuel. Endziel Samuel, abgeschlossen vor Sonnenaufgang. Eigene Luftaufklärung Heron steht über euch, erhalte durchgehend Feed. Feindlage: Aufständische werden den Zug mit allen Mitteln unterbinden wollen — rechnet mit Sprengfallen und Hinterhalten. Lima und Zulu koordinieren sich eigenständig untereinander — Luft und Boden im ständigen Funkkontakt, Feindmeldungen und Aufträge direkt absprechen, nicht alles über OPZ leiten. Einsatzregeln strikt beachten. OPZ ENDE."
    };
    duration = 55;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};