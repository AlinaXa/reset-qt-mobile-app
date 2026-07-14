.pragma library


// =============================================================
// ACTION MODEL
// =============================================================

function _action(
    id,
    category,
    energyMin,
    energyMax,
    minutes,
    context,
    en,
    ro,
    easyMinutes,
    easyEn,
    easyRo
) {
    return {
        id: id,
        category: category,

        energyMin: energyMin,
        energyMax: energyMax,

        minutes: minutes,
        context: context,

        en: en,
        ro: ro,

        easyMinutes: easyMinutes,
        easyEn: easyEn,
        easyRo: easyRo
    }
}


// =============================================================
// HOME — 12 ACTIONS
// =============================================================

var HOME = [

    // ENERGY 1–2

    _action(
        "home_01",
        "Home",
        1,
        2,
        1,
        "Home",
        "Put away one object.",
        "Pune la loc un obiect.",
        1,
        "Move one object closer to where it belongs.",
        "Mută un obiect mai aproape de locul lui."
    ),

    _action(
        "home_02",
        "Home",
        1,
        2,
        1,
        "Home",
        "Throw away one obvious piece of trash.",
        "Aruncă un singur lucru care este clar gunoi.",
        1,
        "Pick up one piece of trash.",
        "Ridică un singur lucru de aruncat."
    ),

    _action(
        "home_03",
        "Home",
        1,
        2,
        2,
        "Home",
        "Clear a hand-sized spot.",
        "Eliberează un spațiu cât palma.",
        1,
        "Move one thing from a small visible spot.",
        "Mută un singur obiect dintr-un loc vizibil."
    ),

    _action(
        "home_04",
        "Home",
        1,
        2,
        1,
        "Home",
        "Let fresh air in for one minute.",
        "Lasă aer proaspăt să intre timp de un minut.",
        1,
        "Open the window just a little.",
        "Deschide puțin fereastra."
    ),


    // ENERGY 3

    _action(
        "home_05",
        "Home",
        3,
        3,
        5,
        "Home",
        "Clear one small surface.",
        "Eliberează o suprafață mică.",
        2,
        "Remove three things from one surface.",
        "Ia trei lucruri de pe o suprafață."
    ),

    _action(
        "home_06",
        "Home",
        3,
        3,
        4,
        "Home",
        "Put five things back where they belong.",
        "Pune cinci lucruri la locul lor.",
        2,
        "Put away two things.",
        "Pune două lucruri la loc."
    ),

    _action(
        "home_07",
        "Home",
        3,
        3,
        3,
        "Home",
        "Wipe one visible surface.",
        "Șterge o singură suprafață vizibilă.",
        1,
        "Wipe one small spot.",
        "Șterge doar un loc mic."
    ),

    _action(
        "home_08",
        "Home",
        3,
        3,
        4,
        "Home",
        "Reset one chair, corner or side of the bed.",
        "Aranjează un scaun, un colț sau o parte a patului.",
        2,
        "Straighten one cushion or blanket.",
        "Aranjează o pernă sau o pătură."
    ),


    // ENERGY 4–5

    _action(
        "home_09",
        "Home",
        4,
        5,
        10,
        "Home",
        "Reset one drawer for ten minutes.",
        "Aranjează un sertar timp de zece minute.",
        3,
        "Remove three things that do not belong there.",
        "Scoate trei lucruri care nu au ce căuta acolo."
    ),

    _action(
        "home_10",
        "Home",
        4,
        5,
        5,
        "Home",
        "Collect the cups and dishes you can see.",
        "Adună cănile și vasele pe care le vezi.",
        2,
        "Take one cup or plate to the kitchen.",
        "Du o cană sau o farfurie în bucătărie."
    ),

    _action(
        "home_11",
        "Home",
        4,
        5,
        10,
        "Home",
        "Start one small laundry step.",
        "Începe un singur pas legat de rufe.",
        3,
        "Collect a few clothes into one place.",
        "Adună câteva haine într-un singur loc."
    ),

    _action(
        "home_12",
        "Home",
        4,
        5,
        8,
        "Home",
        "Reset the area you see first when you come home.",
        "Aranjează zona pe care o vezi prima dată când intri în casă.",
        3,
        "Move three things from the entrance area.",
        "Mută trei lucruri din zona de intrare."
    )
]


// =============================================================
// BODY — 12 ACTIONS
// =============================================================

var BODY = [

    // ENERGY 1–2

    _action(
        "body_01",
        "Body",
        1,
        2,
        1,
        "Anywhere",
        "Take a few sips of water.",
        "Bea câteva înghițituri de apă.",
        1,
        "Take one sip of water.",
        "Ia o singură înghițitură de apă."
    ),

    _action(
        "body_02",
        "Body",
        1,
        2,
        1,
        "Anywhere",
        "Unclench your jaw and lower your shoulders.",
        "Relaxează maxilarul și lasă umerii în jos.",
        1,
        "Relax your jaw.",
        "Relaxează doar maxilarul."
    ),

    _action(
        "body_03",
        "Body",
        1,
        2,
        1,
        "Anywhere",
        "Stretch your arms and back for twenty seconds.",
        "Întinde brațele și spatele timp de douăzeci de secunde.",
        1,
        "Take one slow stretch.",
        "Fă o singură întindere lentă."
    ),

    _action(
        "body_04",
        "Body",
        1,
        2,
        2,
        "Home",
        "Wash or refresh your face.",
        "Spală-te sau răcorește-ți fața.",
        1,
        "Splash a little cool water on your face.",
        "Dă-ți puțină apă rece pe față."
    ),


    // ENERGY 3

    _action(
        "body_05",
        "Body",
        3,
        3,
        2,
        "Anywhere",
        "Drink one glass of water.",
        "Bea un pahar cu apă.",
        1,
        "Drink half a glass of water.",
        "Bea jumătate de pahar cu apă."
    ),

    _action(
        "body_06",
        "Body",
        3,
        3,
        3,
        "Anywhere",
        "Stretch gently for two minutes.",
        "Întinde-te ușor timp de două minute.",
        1,
        "Stretch for thirty seconds.",
        "Întinde-te timp de treizeci de secunde."
    ),

    _action(
        "body_07",
        "Body",
        3,
        3,
        5,
        "Home",
        "Prepare one simple snack.",
        "Pregătește o gustare simplă.",
        2,
        "Get one easy thing to eat.",
        "Ia ceva simplu de mâncat."
    ),

    _action(
        "body_08",
        "Body",
        3,
        3,
        5,
        "Anywhere",
        "Walk around for five minutes.",
        "Mergi puțin timp de cinci minute.",
        2,
        "Walk around for one minute.",
        "Mergi puțin timp de un minut."
    ),


    // ENERGY 4–5

    _action(
        "body_09",
        "Body",
        4,
        5,
        10,
        "Outside",
        "Take a ten-minute walk.",
        "Fă o plimbare de zece minute.",
        3,
        "Walk outside for three minutes.",
        "Ieși la o plimbare de trei minute."
    ),

    _action(
        "body_10",
        "Body",
        4,
        5,
        10,
        "Home",
        "Take a quick refreshing shower.",
        "Fă un duș rapid și revigorant.",
        3,
        "Wash your face and hands.",
        "Spală-te pe față și pe mâini."
    ),

    _action(
        "body_11",
        "Body",
        4,
        5,
        15,
        "Home",
        "Prepare a simple balanced meal.",
        "Pregătește o masă simplă și echilibrată.",
        5,
        "Prepare one useful part of the meal.",
        "Pregătește o singură parte a mesei."
    ),

    _action(
        "body_12",
        "Body",
        4,
        5,
        8,
        "Anywhere",
        "Do a short mobility routine.",
        "Fă o scurtă rutină de mobilitate.",
        2,
        "Move three joints gently.",
        "Mișcă ușor trei articulații."
    )
]


// =============================================================
// MIND — 12 ACTIONS
// =============================================================

var MIND = [

    // ENERGY 1–2

    _action(
        "mind_01",
        "Mind",
        1,
        2,
        1,
        "Anywhere",
        "Close your eyes for twenty seconds.",
        "Închide ochii timp de douăzeci de secunde.",
        1,
        "Close your eyes for one slow breath.",
        "Închide ochii pentru o respirație lentă."
    ),

    _action(
        "mind_02",
        "Mind",
        1,
        2,
        1,
        "Anywhere",
        "Take three slow breaths.",
        "Respiră lent de trei ori.",
        1,
        "Take one slow breath.",
        "Respiră lent o singură dată."
    ),

    _action(
        "mind_03",
        "Mind",
        1,
        2,
        2,
        "Anywhere",
        "Write one sentence about what is bothering you.",
        "Scrie o propoziție despre ce te apasă.",
        1,
        "Write one word for how you feel.",
        "Scrie un singur cuvânt despre cum te simți."
    ),

    _action(
        "mind_04",
        "Mind",
        1,
        2,
        10,
        "Anywhere",
        "Mute non-essential notifications for ten minutes.",
        "Oprește notificările neimportante timp de zece minute.",
        1,
        "Silence one distracting app.",
        "Oprește notificările unei singure aplicații."
    ),


    // ENERGY 3

    _action(
        "mind_05",
        "Mind",
        3,
        3,
        3,
        "Anywhere",
        "Step away from screens for three minutes.",
        "Stai departe de ecrane timp de trei minute.",
        1,
        "Look away from the screen for thirty seconds.",
        "Privește în altă parte timp de treizeci de secunde."
    ),

    _action(
        "mind_06",
        "Mind",
        3,
        3,
        5,
        "Anywhere",
        "Write five lines of whatever is in your head.",
        "Scrie cinci rânduri cu orice îți trece prin minte.",
        2,
        "Write two lines.",
        "Scrie două rânduri."
    ),

    _action(
        "mind_07",
        "Mind",
        3,
        3,
        3,
        "Anywhere",
        "Name three things you can control today.",
        "Numește trei lucruri pe care le poți controla azi.",
        1,
        "Name one thing you can control.",
        "Numește un singur lucru pe care îl poți controla."
    ),

    _action(
        "mind_08",
        "Mind",
        3,
        3,
        4,
        "Desk",
        "Remove one digital distraction.",
        "Elimină o singură distragere digitală.",
        1,
        "Close one unnecessary tab.",
        "Închide un singur tab inutil."
    ),


    // ENERGY 4–5

    _action(
        "mind_09",
        "Mind",
        4,
        5,
        10,
        "Anywhere",
        "Journal for ten minutes without editing yourself.",
        "Scrie într-un jurnal timp de zece minute fără să te corectezi.",
        3,
        "Write for three minutes.",
        "Scrie timp de trei minute."
    ),

    _action(
        "mind_10",
        "Mind",
        4,
        5,
        8,
        "Desk",
        "Organize one page of notes.",
        "Organizează o singură pagină de notițe.",
        3,
        "Group three notes together.",
        "Grupează trei notițe."
    ),

    _action(
        "mind_11",
        "Mind",
        4,
        5,
        10,
        "Anywhere",
        "Read five pages of something calming.",
        "Citește cinci pagini din ceva liniștitor.",
        3,
        "Read one page.",
        "Citește o singură pagină."
    ),

    _action(
        "mind_12",
        "Mind",
        4,
        5,
        5,
        "Desk",
        "Plan tomorrow in three simple bullets.",
        "Planifică ziua de mâine în trei puncte simple.",
        2,
        "Write one priority for tomorrow.",
        "Scrie o singură prioritate pentru mâine."
    )
]


// =============================================================
// MONEY — 12 ACTIONS
// =============================================================

var MONEY = [

    // ENERGY 1–2

    _action(
        "money_01",
        "Money",
        1,
        2,
        1,
        "Anywhere",
        "Check one account balance.",
        "Verifică soldul unui singur cont.",
        1,
        "Open the banking app.",
        "Deschide aplicația bancară."
    ),

    _action(
        "money_02",
        "Money",
        1,
        2,
        1,
        "Anywhere",
        "Look at your latest transaction.",
        "Uită-te la ultima tranzacție.",
        1,
        "Open your transaction list.",
        "Deschide lista de tranzacții."
    ),

    _action(
        "money_03",
        "Money",
        1,
        2,
        2,
        "Anywhere",
        "Save one receipt you may need.",
        "Păstrează un bon de care ai putea avea nevoie.",
        1,
        "Put one receipt in one safe place.",
        "Pune un bon într-un loc sigur."
    ),

    _action(
        "money_04",
        "Money",
        1,
        2,
        2,
        "Anywhere",
        "Remove one thing from an online cart.",
        "Scoate un singur produs dintr-un coș online.",
        1,
        "Look at one item before buying it.",
        "Privește atent un produs înainte să îl cumperi."
    ),


    // ENERGY 3

    _action(
        "money_05",
        "Money",
        3,
        3,
        3,
        "Anywhere",
        "Check your last expense.",
        "Verifică ultima cheltuială.",
        1,
        "Look only at the amount.",
        "Uită-te doar la sumă."
    ),

    _action(
        "money_06",
        "Money",
        3,
        3,
        5,
        "Anywhere",
        "Review one subscription.",
        "Verifică un singur abonament.",
        2,
        "Find one subscription you are paying for.",
        "Găsește un singur abonament pe care îl plătești."
    ),

    _action(
        "money_07",
        "Money",
        3,
        3,
        3,
        "Anywhere",
        "Note one upcoming bill.",
        "Notează o singură factură care urmează.",
        1,
        "Check the due date of one bill.",
        "Verifică data limită a unei facturi."
    ),

    _action(
        "money_08",
        "Money",
        3,
        3,
        5,
        "Desk",
        "Write down one financial task you have been avoiding.",
        "Scrie un lucru financiar pe care îl tot eviți.",
        1,
        "Name the financial task.",
        "Numește doar lucrul financiar."
    ),


    // ENERGY 4–5

    _action(
        "money_09",
        "Money",
        4,
        5,
        10,
        "Desk",
        "Review one recurring payment.",
        "Verifică o plată recurentă.",
        3,
        "Find one recurring payment.",
        "Găsește o singură plată recurentă."
    ),

    _action(
        "money_10",
        "Money",
        4,
        5,
        8,
        "Desk",
        "Make a simple spending plan for today.",
        "Fă un plan simplu de cheltuieli pentru azi.",
        2,
        "Set one spending limit for today.",
        "Stabilește o singură limită pentru azi."
    ),

    _action(
        "money_11",
        "Money",
        4,
        5,
        10,
        "Desk",
        "Categorize five recent transactions.",
        "Clasifică cinci tranzacții recente.",
        3,
        "Categorize two transactions.",
        "Clasifică două tranzacții."
    ),

    _action(
        "money_12",
        "Money",
        4,
        5,
        5,
        "Anywhere",
        "Set one reminder for a payment or bill.",
        "Setează un reminder pentru o plată sau factură.",
        2,
        "Find the date of one upcoming payment.",
        "Găsește data unei singure plăți."
    )
]


// =============================================================
// WORK — 12 ACTIONS
// =============================================================

var WORK = [

    // ENERGY 1–2

    _action(
        "work_01",
        "Work",
        1,
        2,
        1,
        "Desk",
        "Open the task you have been avoiding.",
        "Deschide lucrul pe care îl eviți.",
        1,
        "Open the file or page.",
        "Deschide doar fișierul sau pagina."
    ),

    _action(
        "work_02",
        "Work",
        1,
        2,
        2,
        "Desk",
        "Write the first sentence.",
        "Scrie prima propoziție.",
        1,
        "Write three words.",
        "Scrie trei cuvinte."
    ),

    _action(
        "work_03",
        "Work",
        1,
        2,
        2,
        "Desk",
        "Rename one messy file.",
        "Redenumește un singur fișier dezordonat.",
        1,
        "Find one badly named file.",
        "Găsește un singur fișier cu nume neclar."
    ),

    _action(
        "work_04",
        "Work",
        1,
        2,
        1,
        "Desk",
        "Close one unnecessary tab.",
        "Închide un singur tab inutil.",
        1,
        "Look at your open tabs.",
        "Privește doar taburile deschise."
    ),


    // ENERGY 3

    _action(
        "work_05",
        "Work",
        3,
        3,
        5,
        "Desk",
        "Work for five minutes on the smallest next step.",
        "Lucrează cinci minute la cel mai mic pas următor.",
        2,
        "Work on it for two minutes.",
        "Lucrează la el timp de două minute."
    ),

    _action(
        "work_06",
        "Work",
        3,
        3,
        5,
        "Desk",
        "Finish one tiny task.",
        "Termină un task foarte mic.",
        2,
        "Do only the first half of it.",
        "Fă doar prima jumătate."
    ),

    _action(
        "work_07",
        "Work",
        3,
        3,
        5,
        "Desk",
        "Reply to one important message.",
        "Răspunde unui mesaj important.",
        2,
        "Write a two-line reply.",
        "Scrie un răspuns de două rânduri."
    ),

    _action(
        "work_08",
        "Work",
        3,
        3,
        4,
        "Desk",
        "Choose your top three priorities.",
        "Alege cele mai importante trei priorități.",
        1,
        "Choose only the first priority.",
        "Alege doar prima prioritate."
    ),


    // ENERGY 4–5

    _action(
        "work_09",
        "Work",
        4,
        5,
        15,
        "Desk",
        "Do one fifteen-minute focus sprint.",
        "Fă un sprint de concentrare de cincisprezece minute.",
        5,
        "Focus for five minutes.",
        "Concentrează-te timp de cinci minute."
    ),

    _action(
        "work_10",
        "Work",
        4,
        5,
        10,
        "Desk",
        "Organize one project folder.",
        "Organizează un folder de proiect.",
        3,
        "Move three files into the right place.",
        "Mută trei fișiere la locul lor."
    ),

    _action(
        "work_11",
        "Work",
        4,
        5,
        15,
        "Desk",
        "Draft the next section of your work.",
        "Scrie o primă variantă pentru următoarea secțiune.",
        5,
        "Write the heading and one sentence.",
        "Scrie titlul și o propoziție."
    ),

    _action(
        "work_12",
        "Work",
        4,
        5,
        5,
        "Desk",
        "Schedule one difficult task.",
        "Programează un singur task dificil.",
        2,
        "Choose a day for it.",
        "Alege doar o zi pentru el."
    )
]


// =============================================================
// SOCIAL — 12 ACTIONS
// =============================================================

var SOCIAL = [

    // ENERGY 1–2

    _action(
        "social_01",
        "Social",
        1,
        2,
        1,
        "Anywhere",
        "Send one short message.",
        "Trimite un mesaj scurt.",
        1,
        "Send one word or symbol.",
        "Trimite un cuvânt sau un simbol."
    ),

    _action(
        "social_02",
        "Social",
        1,
        2,
        1,
        "Anywhere",
        "Tell someone you are thinking of them.",
        "Spune cuiva că te-ai gândit la el.",
        1,
        "Send a simple hello.",
        "Trimite un simplu salut."
    ),

    _action(
        "social_03",
        "Social",
        1,
        2,
        2,
        "Anywhere",
        "Reply to one easy message.",
        "Răspunde unui singur mesaj ușor.",
        1,
        "Open one message.",
        "Deschide un singur mesaj."
    ),

    _action(
        "social_04",
        "Social",
        1,
        2,
        2,
        "Anywhere",
        "Send someone something that made you think of them.",
        "Trimite cuiva ceva care ți-a amintit de el.",
        1,
        "Save it to send later.",
        "Salvează-l ca să îl trimiți mai târziu."
    ),


    // ENERGY 3

    _action(
        "social_05",
        "Social",
        3,
        3,
        4,
        "Anywhere",
        "Reply to one person.",
        "Răspunde unei singure persoane.",
        2,
        "Write a short two-line reply.",
        "Scrie un răspuns scurt de două rânduri."
    ),

    _action(
        "social_06",
        "Social",
        3,
        3,
        3,
        "Anywhere",
        "Check in with someone.",
        "Întreabă pe cineva ce mai face.",
        1,
        "Send: How are you?",
        "Trimite: Ce mai faci?"
    ),

    _action(
        "social_07",
        "Social",
        3,
        3,
        3,
        "Anywhere",
        "Send a voice note under one minute.",
        "Trimite un mesaj vocal de sub un minut.",
        1,
        "Record a ten-second voice note.",
        "Înregistrează un mesaj vocal de zece secunde."
    ),

    _action(
        "social_08",
        "Social",
        3,
        3,
        5,
        "Anywhere",
        "Make one simple plan with someone.",
        "Fă un plan simplu cu cineva.",
        2,
        "Ask if they are free this week.",
        "Întreabă dacă este liber săptămâna aceasta."
    ),


    // ENERGY 4–5

    _action(
        "social_09",
        "Social",
        4,
        5,
        10,
        "Anywhere",
        "Call someone for ten minutes.",
        "Sună pe cineva timp de zece minute.",
        3,
        "Ask if they have three minutes to talk.",
        "Întreabă dacă are trei minute să vorbiți."
    ),

    _action(
        "social_10",
        "Social",
        4,
        5,
        8,
        "Outside",
        "Plan a coffee, walk or short visit.",
        "Planifică o cafea, o plimbare sau o vizită scurtă.",
        2,
        "Suggest one possible day.",
        "Propune o singură zi."
    ),

    _action(
        "social_11",
        "Social",
        4,
        5,
        8,
        "Anywhere",
        "Send one thoughtful message.",
        "Trimite un mesaj atent și personal.",
        2,
        "Write the first sentence.",
        "Scrie doar prima propoziție."
    ),

    _action(
        "social_12",
        "Social",
        4,
        5,
        10,
        "Anywhere",
        "Reconnect with someone you have missed.",
        "Reia legătura cu cineva de care ți-a fost dor.",
        2,
        "Send a simple: I thought of you today.",
        "Trimite simplu: M-am gândit la tine azi."
    )
]


// =============================================================
// LIBRARY ACCESS
// =============================================================

function _listFor(category) {
    if (category === "Home")
        return HOME

    if (category === "Body")
        return BODY

    if (category === "Mind")
        return MIND

    if (category === "Money")
        return MONEY

    if (category === "Work")
        return WORK

    if (category === "Social")
        return SOCIAL

    return []
}


function _findById(id) {
    var categories = [
        HOME,
        BODY,
        MIND,
        MONEY,
        WORK,
        SOCIAL
    ]

    for (var c = 0; c < categories.length; c++) {
        var list = categories[c]

        for (var i = 0; i < list.length; i++) {
            if (list[i].id === id)
                return list[i]
        }
    }

    return null
}


function _detailForEnergy(energy, romanian, easy) {
    if (easy) {
        return romanian
                ? "Atât este suficient."
                : "That is enough."
    }

    if (energy <= 2) {
        return romanian
                ? "Foarte puțin este suficient pentru azi."
                : "Very small is enough today."
    }

    if (energy === 3) {
        return romanian
                ? "Atât este suficient pentru acum."
                : "That’s enough for now."
    }

    return romanian
            ? "Fă doar atât. Restul poate aștepta."
            : "Do only this. The rest can wait."
}


function _localized(action, romanian, easy, energy) {
    if (action === null) {
        return {
            id: "",
            category: "",
            text: "",
            detail: "",
            minutes: 0,
            context: "",
            easy: false
        }
    }

    return {
        id: action.id,
        category: action.category,

        text: romanian
              ? (easy ? action.easyRo : action.ro)
              : (easy ? action.easyEn : action.en),

        detail: _detailForEnergy(
            energy,
            romanian,
            easy
        ),

        minutes: easy
                 ? action.easyMinutes
                 : action.minutes,

        context: action.context,
        easy: easy
    }
}


// =============================================================
// PUBLIC FUNCTIONS
// =============================================================

function pickAction(category, energy, previousId, romanian) {
    var source = _listFor(category)
    var candidates = []

    for (var i = 0; i < source.length; i++) {
        var item = source[i]

        if (
            energy >= item.energyMin
            && energy <= item.energyMax
        ) {
            candidates.push(item)
        }
    }

    if (candidates.length === 0)
        candidates = source.slice(0)

    if (candidates.length > 1 && previousId !== "") {
        var withoutPrevious = []

        for (var j = 0; j < candidates.length; j++) {
            if (candidates[j].id !== previousId)
                withoutPrevious.push(candidates[j])
        }

        if (withoutPrevious.length > 0)
            candidates = withoutPrevious
    }

    if (candidates.length === 0)
        return _localized(null, romanian, false, energy)

    var randomIndex = Math.floor(
        Math.random() * candidates.length
    )

    return _localized(
        candidates[randomIndex],
        romanian,
        false,
        energy
    )
}


function easierVersion(id, energy, romanian) {
    var action = _findById(id)

    return _localized(
        action,
        romanian,
        true,
        energy
    )
}


function translateAction(id, energy, romanian, easy) {
    var action = _findById(id)

    return _localized(
        action,
        romanian,
        easy,
        energy
    )
}


function actionCount(category, energy) {
    var source = _listFor(category)
    var count = 0

    for (var i = 0; i < source.length; i++) {
        if (
            energy >= source[i].energyMin
            && energy <= source[i].energyMax
        ) {
            count += 1
        }
    }

    return count
}


function totalActionCount() {
    return HOME.length
            + BODY.length
            + MIND.length
            + MONEY.length
            + WORK.length
            + SOCIAL.length
}
