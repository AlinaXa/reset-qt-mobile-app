.pragma library

.import "ActionLibrary.js" as ActionLibrary


// =============================================================
// EXCLUSION HELPERS
// =============================================================

function _buildExcludedList(
    excludedIds,
    previousId
) {
    var result = []


    if (
        excludedIds
        && excludedIds.length
    ) {
        for (
            var i = 0;
            i < excludedIds.length;
            i++
        ) {
            var id =
                    excludedIds[i]


            if (
                id
                && result.indexOf(id) === -1
            ) {
                result.push(id)
            }
        }
    }


    if (
        previousId
        && result.indexOf(previousId) === -1
    ) {
        result.push(previousId)
    }


    return result
}


function _isExcluded(
    actionId,
    excludedIds
) {
    return excludedIds.indexOf(
        actionId
    ) !== -1
}


// =============================================================
// FILTER HELPERS
// =============================================================

function _matchesTime(
    action,
    maxMinutes
) {
    if (
        !maxMinutes
        || maxMinutes <= 0
    ) {
        return true
    }


    return action.minutes <= maxMinutes
}


function _matchesContext(
    action,
    context
) {
    if (
        !context
        || context === "Any"
    ) {
        return true
    }


    if (
        action.context === "Anywhere"
    ) {
        return true
    }


    return action.context === context
}


// =============================================================
// RANDOM PICK
// =============================================================

function _pickRandom(items) {
    if (
        !items
        || items.length === 0
    ) {
        return null
    }


    var index =
            Math.floor(
                Math.random()
                * items.length
            )


    return items[index]
}


// =============================================================
// DISCOVER AVAILABLE ACTIONS
//
// ActionLibrary already owns the real action data.
//
// We ask it for multiple actions and build a temporary pool.
// Recent completed actions can be excluded from this pool.
// =============================================================

function _discoverCandidates(
    category,
    energy,
    romanian,
    excludedIds
) {
    var candidates = []

    var seen = {}

    var previousDiscoveryId = ""


    for (
        var attempt = 0;
        attempt < 64;
        attempt++
    ) {
        var action =
                ActionLibrary.pickAction(
                    category,
                    energy,
                    previousDiscoveryId,
                    romanian
                )


        if (
            !action
            || !action.id
        ) {
            continue
        }


        previousDiscoveryId =
                action.id


        if (
            seen[action.id]
        ) {
            continue
        }


        seen[action.id] = true


        if (
            _isExcluded(
                action.id,
                excludedIds
            )
        ) {
            continue
        }


        candidates.push(action)
    }


    return candidates
}


// =============================================================
// CHOOSE BEST CANDIDATE
//
// Priority:
//
// 1. Time + place
// 2. Time
// 3. Place
// 4. Any available action
// =============================================================

function _chooseFromPool(
    candidates,
    maxMinutes,
    context
) {
    if (
        !candidates
        || candidates.length === 0
    ) {
        return null
    }


    var perfect = []
    var timeMatches = []
    var contextMatches = []


    for (
        var i = 0;
        i < candidates.length;
        i++
    ) {
        var action =
                candidates[i]


        var matchesTime =
                _matchesTime(
                    action,
                    maxMinutes
                )


        var matchesContext =
                _matchesContext(
                    action,
                    context
                )


        if (
            matchesTime
            && matchesContext
        ) {
            perfect.push(action)
        }


        if (matchesTime)
            timeMatches.push(action)


        if (matchesContext)
            contextMatches.push(action)
    }


    if (perfect.length > 0)
        return _pickRandom(perfect)


    if (timeMatches.length > 0)
        return _pickRandom(timeMatches)


    if (contextMatches.length > 0)
        return _pickRandom(contextMatches)


    return _pickRandom(candidates)
}


// =============================================================
// SMART PICK
//
// excludedIds is optional.
//
// Old calls still work:
//
// pickSmart(
//     category,
//     energy,
//     previousId,
//     romanian,
//     maxMinutes,
//     context
// )
//
// New calls can add:
//
// excludedIds
// =============================================================

function pickSmart(
    category,
    energy,
    previousId,
    romanian,
    maxMinutes,
    context,
    excludedIds
) {
    var safeMaxMinutes =
            typeof maxMinutes === "number"
            ? maxMinutes
            : 0


    var safeContext =
            context
            ? context
            : "Any"


    // ---------------------------------------------------------
    // FIRST TRY
    // Avoid previous action + recent completed actions
    // ---------------------------------------------------------

    var strictExcluded =
            _buildExcludedList(
                excludedIds,
                previousId
            )


    var candidates =
            _discoverCandidates(
                category,
                energy,
                romanian,
                strictExcluded
            )


    var selected =
            _chooseFromPool(
                candidates,
                safeMaxMinutes,
                safeContext
            )


    if (selected)
        return selected


    // ---------------------------------------------------------
    // SECOND TRY
    // Recent list was too restrictive.
    // Still avoid the immediately previous action.
    // ---------------------------------------------------------

    var previousOnly = []


    if (previousId)
        previousOnly.push(previousId)


    candidates =
            _discoverCandidates(
                category,
                energy,
                romanian,
                previousOnly
            )


    selected =
            _chooseFromPool(
                candidates,
                safeMaxMinutes,
                safeContext
            )


    if (selected)
        return selected


    // ---------------------------------------------------------
    // FINAL FALLBACK
    // Always return something valid.
    // ---------------------------------------------------------

    return ActionLibrary.pickAction(
        category,
        energy,
        previousId,
        romanian
    )
}


// =============================================================
// EASIER VERSION
// =============================================================

function easierVersion(
    id,
    energy,
    romanian
) {
    return ActionLibrary.easierVersion(
        id,
        energy,
        romanian
    )
}


// =============================================================
// TRANSLATE EXISTING ACTION
// =============================================================

function translateAction(
    id,
    energy,
    romanian,
    easy
) {
    return ActionLibrary.translateAction(
        id,
        energy,
        romanian,
        easy
    )
}


// =============================================================
// RECOMMENDED TIME BY ENERGY
// =============================================================

function recommendedMinutes(
    energy
) {
    if (energy <= 2)
        return 5


    if (energy === 3)
        return 10


    return 0
}


// =============================================================
// TIME LABEL
// =============================================================

function timeLabel(
    maxMinutes,
    romanian
) {
    if (
        !maxMinutes
        || maxMinutes <= 0
    ) {
        return romanian
                ? "Oricât"
                : "Any time"
    }


    return "≤ "
            + maxMinutes
            + " min"
}


// =============================================================
// CONTEXT LABEL
// =============================================================

function contextLabel(
    context,
    romanian
) {
    if (
        !context
        || context === "Any"
    ) {
        return romanian
                ? "Oriunde"
                : "Anywhere"
    }


    if (context === "Home")
        return romanian
                ? "Acasă"
                : "Home"


    if (context === "Desk")
        return romanian
                ? "La birou"
                : "At desk"


    if (context === "Outside")
        return romanian
                ? "Afară"
                : "Outside"


    return romanian
            ? "Oriunde"
            : "Anywhere"
}
