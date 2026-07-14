.pragma library


// =============================================================
// CATEGORY HELPERS
// =============================================================

function _categoryLabel(category, romanian) {
    if (category === "Home")
        return romanian ? "Acasă" : "Home"

    if (category === "Body")
        return romanian ? "Corp" : "Body"

    if (category === "Mind")
        return romanian ? "Minte" : "Mind"

    if (category === "Money")
        return romanian ? "Bani" : "Money"

    if (category === "Work")
        return romanian ? "Muncă" : "Work"

    return "Social"
}


function _categoryColor(category) {
    if (category === "Home")
        return "#F2A889"

    if (category === "Body")
        return "#A9C7B0"

    if (category === "Mind")
        return "#C9DDE5"

    if (category === "Money")
        return "#D8C8A8"

    if (category === "Work")
        return "#C7C3D8"

    return "#E5BFC1"
}


// =============================================================
// CATEGORY ANALYSIS
// =============================================================

function _categories(stats) {
    return [
        {
            name: "Home",
            count: stats.home || 0
        },

        {
            name: "Body",
            count: stats.body || 0
        },

        {
            name: "Mind",
            count: stats.mind || 0
        },

        {
            name: "Money",
            count: stats.money || 0
        },

        {
            name: "Work",
            count: stats.work || 0
        },

        {
            name: "Social",
            count: stats.social || 0
        }
    ]
}


function _mostActiveCategory(stats) {
    var categories = _categories(stats)

    var best = categories[0]


    for (
        var i = 1;
        i < categories.length;
        i++
    ) {
        if (categories[i].count > best.count)
            best = categories[i]
    }


    return best
}


function _secondHighestCount(stats) {
    var categories = _categories(stats)

    var values = []


    for (
        var i = 0;
        i < categories.length;
        i++
    ) {
        values.push(
            categories[i].count
        )
    }


    values.sort(
        function(a, b) {
            return b - a
        }
    )


    if (values.length < 2)
        return 0


    return values[1]
}


function _leastActiveCategory(stats) {
    var categories = _categories(stats)

    var lowest = categories[0]


    for (
        var i = 1;
        i < categories.length;
        i++
    ) {
        if (categories[i].count < lowest.count)
            lowest = categories[i]
    }


    return lowest
}


// =============================================================
// RESULT HELPER
// =============================================================

function _result(
    title,
    body,
    tone,
    category,
    accent
) {
    return {
        title: title,
        body: body,
        tone: tone,
        category: category,
        accent: accent
    }
}


// =============================================================
// MAIN INSIGHT
// =============================================================

function insight(stats, romanian) {
    var total =
            stats.total || 0

    var today =
            stats.today || 0

    var week =
            stats.week || 0

    var streak =
            stats.streak || 0


    // ---------------------------------------------------------
    // NO HISTORY YET
    // ---------------------------------------------------------

    if (total === 0) {
        return _result(
            romanian
            ? "De aici începe."
            : "This is where it starts.",

            romanian
            ? "Primul lucru mic va schimba acest ecran."
            : "Your first small thing will change this screen.",

            "new",
            "",
            "#C9DDE5"
        )
    }


    // ---------------------------------------------------------
    // STRONG STREAK
    // ---------------------------------------------------------

    if (streak >= 7) {
        return _result(
            romanian
            ? "O săptămână întreagă."
            : "A full week of showing up.",

            romanian
            ? streak
              + " zile la rând. Ritmul există deja."
            : streak
              + " days in a row. The rhythm is already there.",

            "streak",
            "",
            "#F2A889"
        )
    }


    // ---------------------------------------------------------
    // BUILDING A RHYTHM
    // ---------------------------------------------------------

    if (streak >= 3) {
        return _result(
            romanian
            ? "Îți construiești un ritm."
            : "You’re building a rhythm.",

            romanian
            ? streak
              + " zile la rând. Păstrează-l mic."
            : streak
              + " days in a row. Keep it small.",

            "streak",
            "",
            "#F2A889"
        )
    }


    // ---------------------------------------------------------
    // A LOT DONE TODAY
    // ---------------------------------------------------------

    if (today >= 3) {
        return _result(
            romanian
            ? "Ai făcut destul pentru azi."
            : "You did enough today.",

            romanian
            ? today
              + " lucruri mici contează deja."
            : today
              + " small things already count.",

            "today",
            "",
            "#A9C7B0"
        )
    }


    // ---------------------------------------------------------
    // STRONG WEEK
    // ---------------------------------------------------------

    if (week >= 7) {
        return _result(
            romanian
            ? "Săptămâna asta are ritm."
            : "This week has momentum.",

            romanian
            ? week
              + " lucruri făcute, unul câte unul."
            : week
              + " things done, one at a time.",

            "week",
            "",
            "#D8C8A8"
        )
    }


    // ---------------------------------------------------------
    // DOMINANT CATEGORY
    // ---------------------------------------------------------

    var mostActive =
            _mostActiveCategory(stats)

    var secondHighest =
            _secondHighestCount(stats)


    if (
        mostActive.count >= 3
        && mostActive.count > secondHighest
    ) {
        return _result(
            romanian
            ? _categoryLabel(
                mostActive.name,
                true
              )
              + " este locul în care revii cel mai des."
            : _categoryLabel(
                mostActive.name,
                false
              )
              + " is where you return most.",

            romanian
            ? mostActive.count
              + " lucruri mici făcute în această categorie."
            : mostActive.count
              + " small things done in this category.",

            "category",
            mostActive.name,
            _categoryColor(
                mostActive.name
            )
        )
    }


    // ---------------------------------------------------------
    // GENTLE CATEGORY SUGGESTION
    // ---------------------------------------------------------

    var leastActive =
            _leastActiveCategory(stats)


    if (
        total >= 6
        && leastActive.count === 0
    ) {
        return _result(
            romanian
            ? "Poate puțin spațiu pentru "
              + _categoryLabel(
                    leastActive.name,
                    true
                )
              + "."
            : "Maybe a little room for "
              + _categoryLabel(
                    leastActive.name,
                    false
                )
              + ".",

            romanian
            ? "Nu este o obligație. Doar o opțiune."
            : "Not a requirement. Just an option.",

            "suggestion",
            leastActive.name,
            _categoryColor(
                leastActive.name
            )
        )
    }


    // ---------------------------------------------------------
    // SMALL TOTAL MILESTONE
    // ---------------------------------------------------------

    if (total >= 10) {
        return _result(
            romanian
            ? "Lucrurile mici s-au adunat."
            : "The small things added up.",

            romanian
            ? total
              + " lucruri terminate până acum."
            : total
              + " things completed so far.",

            "total",
            "",
            "#C9DDE5"
        )
    }


    // ---------------------------------------------------------
    // DEFAULT
    // ---------------------------------------------------------

    return _result(
        romanian
        ? "Ai continuat să apari."
        : "You kept showing up.",

        romanian
        ? total
          + " lucruri mici făcute până acum."
        : total
          + " small things done so far.",

        "total",
        "",
        "#C9DDE5"
    )
}
