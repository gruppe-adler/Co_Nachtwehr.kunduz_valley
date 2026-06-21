/*
*   Hier können eigene Sounds eingebunden werden.
*   Ist in CfgSounds included.
*/

// --- Convoy radio confirmations ------------------------------------------
// Played randomly from GRAD_convoyControl_fnc_start / _fnc_stop.
// titles[]: { time, "" } -> no subtitle. Volume 1, pitch 1.


class GRAD_convoy_start_01
{
    name = "GRAD_convoy_start_01";
    sound[] = { "USER\sounds\convoy_start_01.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Hier KAMEL, bestätige, Konvoi in Bewegung. Ende."
    };
    duration = 4;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_start_02
{
    name = "GRAD_convoy_start_02";
    sound[] = { "USER\sounds\convoy_start_02.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, hier KAMEL, verstanden. Marsch wird fortgesetzt. KAMEL Ende."
    };
    duration = 5;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_start_03
{
    name = "GRAD_convoy_start_03";
    sound[] = { "USER\sounds\convoy_start_03.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Verstanden. Wir nehmen die Fahrt wieder auf. Ende."
    };
    duration = 4;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_start_04
{
    name = "GRAD_convoy_start_04";
    sound[] = { "USER\sounds\convoy_start_04.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "LIMA, KAMEL. Strecke frei. Marsch läuft. Ende."
    };
    duration = 5;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_stop_01
{
    name = "GRAD_convoy_stop_01";
    sound[] = { "USER\sounds\convoy_stop_01.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "KAMEL, Halt ausgeführt. Wir bleiben in Position. Ende."
    };
    duration = 5;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_stop_02
{
    name = "GRAD_convoy_stop_02";
    sound[] = { "USER\sounds\convoy_stop_02.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "KAMEL, Verstanden. Marsch Stop. Wir halten. KAMEL Ende."
    };
    duration = 5;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_stop_03
{
    name = "GRAD_convoy_stop_03";
    sound[] = { "USER\sounds\convoy_stop_03.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Hier KAMEL, Konvoi steht. Warten auf ihren Befehl. Ende."
    };
    duration = 5;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class GRAD_convoy_stop_04
{
    name = "GRAD_convoy_stop_04";
    sound[] = { "USER\sounds\convoy_stop_04.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Verstanden. Marsch gestoppt. KAMEL hält. Ende."
    };
    duration = 4;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};


class mission_01_briefing
{
    name = "mission_01_briefing";
    sound[] = { "USER\sounds\mission_01_briefing.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, Zulu — hier OPZ, KOMMEN. Auftrag: Begleitschutz UN-Versorgungs- und Bauzug entlang der Flussroute. Marschweg über die Kontrollpunkte Polka, Emil, Nora, Ida, Samuel. Endziel Samuel, abgeschlossen vor Sonnenaufgang. Eigene Luftaufklärung Heron steht über euch, erhalte durchgehend Feed. Feindlage: Aufständische werden den Zug mit allen Mitteln unterbinden wollen — rechnet mit Sprengfallen und Hinterhalten. Lima und Zulu koordinieren sich eigenständig untereinander — Luft und Boden im ständigen Funkkontakt, Feindmeldungen und Aufträge direkt absprechen, nicht alles über OPZ leiten. Einsatzregeln strikt beachten. OPZ ENDE."
    };
    duration = 52;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_02_crowd
{
    name = "mission_02_crowd";
    sound[] = { "USER\sounds\mission_02_crowd.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, hier OPZ — Heron meldet Menschenansammlung auf der Straße am Kontrollpunkt vor euch, geschätzt dreißig bis vierzig Zivilpersonen, keine Bewaffnung erkennbar. Auftrag: Marschweg freimachen, Lage deeskalieren. Keine Waffenwirkung gegen Zivilpersonen — Einzelansprache. KOMMEN."
    };
    duration = 22;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_03_polka
{
    name = "mission_03_polka";
    sound[] = { "USER\sounds\mission_03_polka.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, hier OPZ  - Dronen Feed ist sauber, Marschweg frei. Kontrollpunkt Polka passieren. Marsch fortsetzen, nächster Abschnitt. OPZ ENDE."
    };
    duration = 10;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_04_emil
{
    name = "mission_04_emil";
    sound[] = { "USER\sounds\mission_04_emil.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, hier OPZ — Heron bestätigt: Kontrollpunkt EMIL passiert. Konvoi geschlossen, Marschordnung gehalten. Feindlage unverändert. Auftrag bleibt bestehen: Bewegung fortsetzen Richtung NORA. OPZ ENDE."
    };
    duration = 17;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_05_nora
{
    name = "mission_05_nora";
    sound[] = { "USER\sounds\mission_05_nora.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, hier OPZ — Heron bestätigt: Kontrollpunkt NORA erreicht und passiert. Hälfte des Marschweges liegt hinter euch — weiter so. Marsch nach IDA fortsetzen. OPZ ENDE."
    };
    duration = 15;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_06_sprengfalle
{
    name = "mission_06_sprengfalle";
    sound[] = { "USER\sounds\mission_06_sprengfalle.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, hier OPZ — ACHTUNG, ACHTUNG! Heron erfasst verdächtige Wärmequelle am Fahrbahnrand, etwa zweihundert Meter in Marschrichtung. Verdacht Sprengfalle. Auftrag: Marsch STOPP, Tankfahrzeuge zurückhalten, Bereich abriegeln, Kampfmittel durch Lima beseitigen. Vollzug melden. ENDE."
    };
    duration = 22;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_07_bruecke
{
    name = "mission_07_bruecke";
    sound[] = { "USER\sounds\mission_07_bruecke.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, hier OPZ — Heron informiert: Brücke gesprengt, nicht mehr befahrbar. Schwere Fahrzeuge können den Fluss hier nicht queren. Neuer Auftrag: Umleitung über den südlichen Feldweg. Abschnitt nicht gesichert, erhöhtes Risiko. Zulu-1 vorausklären und Lima einweisen, Konvoi geschlossen nachführen. AUSFÜHREN."
    };
    duration = 23;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_07_bruecke_kamel
{
    name = "mission_07_bruecke_kamel";
    sound[] = { "USER\sounds\mission_07_bruecke_kamel.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "OPZ, hier Kamel — Bestätige. Marschweg vor uns nicht passierbar, wir weichen ab. Queren über die nächste Brücke weiter südlich und führen danach auf den Marschweg zurück. Konvoi bleibt geschlossen. Kamel Ende."
    };
    duration = 11;
    avatar = "user\rscMessage\kamel.paa";
    object = "KAMEL";
};

class mission_08_sandsturm
{
    name = "mission_08_sandsturm";
    sound[] = { "USER\sounds\mission_08_sandsturm.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "An alle, hier OPZ — Wetterlage: schwerer Sandsturm zieht von Norden auf, Sicht geht gegen null. Zulu, Flugbetrieb sofort einstellen, zurück zur Basis, am Boden bleiben — Wiederaufnahme auf meinen Befehl. Kamel, Marsch STOPP. Lima, erhöhte Wachsamkeit — Feind könnte Lage ausnutzen. OPZ ENDE."
    };
    duration = 22;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_09_sandsturm
{
    name = "mission_09_sandsturm";
    sound[] = { "USER\sounds\mission_09_sandsturm.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "An alle, hier OPZ — Wetterlage klart auf, Feed wieder verfügbar, Flugbetrieb freigegeben. Zulu-1, erneut aufsteigen, Aufklärung für Kameel und Lima aufnehmen. Kameel, Marsch fortsetzen — wir sind im Verzug, Marschgeschwindigkeit erhöhen. OPZ ENDE."
    };
    duration = 20;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_10_ida
{
    name = "mission_10_ida";
    sound[] = { "USER\sounds\mission_10_ida.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Lima, Kameel, hier OPZ — Heron zeigt: Kontrollpunkt IDA passiert. Letzter Abschnitt vor SAMUEL eingeleitet. Feindaktivität im Raum weiterhin möglich. Sicherung beibehalten, Konvoi geschlossen halten und ohne Halt durchschieben. OPZ ENDE."
    };
    duration = 19;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_11_samuel
{
    name = "mission_11_samuel";
    sound[] = { "USER\sounds\mission_11_samuel.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "An alle, hier OPZ — Zielraum Samuel erreicht, aber noch nicht sauber. Heron erfasst versprengte Feindkräfte im Zielraum, einzelne Schützen zwischen den Gebäuden, vereinzelter Widerstand. Auftrag: Zielraum freikämpfen, bevor abgesessen wird. Lima, einzeln vorgehen und niederkämpfen, Konvoi gedeckt halten. Zulu-1, erfasste Einzelziele bekämpfen — sauber wirken, eigene Kräfte und Zielobjekt am Boden. Lima und Zulu untereinander einweisen. AUSFÜHREN!"
    };
    duration = 32;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_12_RTB
{
    name = "mission_12_RTB";
    sound[] = { "USER\sounds\mission_12_RTB.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "An alle Kräfte, hier OPZ — NOTLAGE! Basis wird durch starke Feindkräfte angegriffen. Mehrere Feindansätze aus verschiedenen Richtungen, eigene Sicherungskräfte gebunden. Feind versucht in den inneren Bereich einzudringen. Lima, Lageänderung: Auftrag schnellstmöglich Kräfte zur Unterstützung der Basis herauslösen. Zulu, unverzüglich zur Basis verlegen und Feindkräfte bekämpfen. Priorität ist die Verteidigung des Gefechtsstandes und der kritischen Infrastruktur. OPZ an alle: Dringende Unterstützung angefordert. AUSFÜHREN! ENDE."
    };
    duration = 38;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};

class mission_13_missionEnd
{
    name = "mission_13_missionEnd";
    sound[] = { "USER\sounds\mission_13_missionEnd.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "An alle, hier OPZ — Auftrag NACHTWEHR abgeschlossen. Der Versorgungs- und Bauzug ist vollständig im Zielraum. Lima, Kamel, Zulu — hervorragende Luft-Boden-Zusammenarbeit unter schweren Bedingungen, das war saubere Arbeit. Übergabe an die Kräfte vor Ort ist erfolgt. Angriff auf die eigene Basis wurde erfolgreich abgewehrt. Es war mir eine Ehre. OPZ ENDE, NACHTWEHR ENDE."
    };
    duration = 38;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};



class medevac
{
    name = "medevac";
    sound[] = { "USER\sounds\medevac.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Zulu-2, hier OPZ — Verwundete im Konvoi, dringend. Auftrag MEDEVAC: Anflug Konvoi, Abschnitt nicht gesichert. Lima sichert und markiert die Landezone. Aufnahme und Abflug zügig. AUSFÜHREN."
    };
    duration = 14;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};



class ka137
{
    name = "ka137";
    sound[] = { "USER\sounds\ka137.ogg", 2, 1, 100 };
    titles[] = {0, ""};
    customsubtitle[] = {
        0, "Zulu, hier OPZ — ACHTUNG, Luftraumbedrohung! Heron erfasst mehrere unbemannte Luftfahrzeuge, Typ Ka-137, im Sektor — Bewaffnung nicht ausgeschlossen, behandelt sie als feindliche Kampfdrohnen. Priorität Luftabwehr: Drohnen aufklären und bekämpfen, bevor sie wirken können.AUSFÜHREN!"
    };
    duration = 22;
    avatar = "user\rscMessage\opz.paa";
    object = "OPZ";
};
