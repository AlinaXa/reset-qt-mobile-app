.pragma library

.import QtQuick.LocalStorage 2.0 as Sql


// =============================================================
// DATABASE
// =============================================================

function _database() {
    return Sql.LocalStorage.openDatabaseSync(
        "ResetHistory",
        "1.0",
        "Reset completed actions",
        1000000
    )
}


// =============================================================
// DATE HELPERS
// =============================================================

function _twoDigits(value) {
    return value < 10
            ? "0" + value
            : String(value)
}


function _localDateString(date) {
    return date.getFullYear()
            + "-"
            + _twoDigits(date.getMonth() + 1)
            + "-"
            + _twoDigits(date.getDate())
}


function _todayString() {
    return _localDateString(
        new Date()
    )
}


function _copyDate(date) {
    return new Date(
        date.getFullYear(),
        date.getMonth(),
        date.getDate()
    )
}


function _addDays(date, amount) {
    var result = _copyDate(date)

    result.setDate(
        result.getDate() + amount
    )

    return result
}


function _mondayOfWeek(date) {
    var result = _copyDate(date)

    var day = result.getDay()

    var distanceFromMonday =
            (day + 6) % 7

    result.setDate(
        result.getDate()
        - distanceFromMonday
    )

    return result
}


// =============================================================
// INITIALIZE DATABASE
// =============================================================

function init() {
    var db = _database()


    db.transaction(
        function(tx) {
            tx.executeSql(
                "CREATE TABLE IF NOT EXISTS completions (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "completed_at TEXT NOT NULL, " +
                "local_date TEXT NOT NULL, " +
                "action_id TEXT NOT NULL, " +
                "category TEXT NOT NULL, " +
                "energy INTEGER NOT NULL, " +
                "minutes INTEGER NOT NULL, " +
                "context TEXT NOT NULL, " +
                "easy INTEGER NOT NULL DEFAULT 0" +
                ")"
            )


            tx.executeSql(
                "CREATE INDEX IF NOT EXISTS " +
                "idx_completions_local_date " +
                "ON completions(local_date)"
            )


            tx.executeSql(
                "CREATE INDEX IF NOT EXISTS " +
                "idx_completions_category " +
                "ON completions(category)"
            )


            tx.executeSql(
                "CREATE INDEX IF NOT EXISTS " +
                "idx_completions_action_id " +
                "ON completions(action_id)"
            )
        }
    )
}


// =============================================================
// SAVE COMPLETION
// =============================================================

function addCompletion(
    actionId,
    category,
    energy,
    minutes,
    context,
    easy
) {
    var db = _database()

    var now = new Date()

    var completedAt =
            now.toISOString()

    var localDate =
            _localDateString(now)

    var easyValue =
            easy ? 1 : 0


    db.transaction(
        function(tx) {
            tx.executeSql(
                "INSERT INTO completions (" +
                "completed_at, " +
                "local_date, " +
                "action_id, " +
                "category, " +
                "energy, " +
                "minutes, " +
                "context, " +
                "easy" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                [
                    completedAt,
                    localDate,
                    actionId,
                    category,
                    energy,
                    minutes,
                    context,
                    easyValue
                ]
            )
        }
    )
}


// =============================================================
// TOTAL COUNT
// =============================================================

function totalCount() {
    var db = _database()
    var count = 0


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT COUNT(*) AS total " +
                "FROM completions"
            )


            if (result.rows.length > 0)
                count = result.rows.item(0).total
        }
    )


    return count
}


// =============================================================
// TODAY COUNT
// =============================================================

function todayCount() {
    var db = _database()
    var count = 0


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT COUNT(*) AS total " +
                "FROM completions " +
                "WHERE local_date = ?",
                [
                    _todayString()
                ]
            )


            if (result.rows.length > 0)
                count = result.rows.item(0).total
        }
    )


    return count
}


// =============================================================
// THIS WEEK COUNT
// =============================================================

function weekCount() {
    var db = _database()
    var count = 0

    var today = new Date()

    var monday =
            _mondayOfWeek(today)

    var startDate =
            _localDateString(monday)

    var endDate =
            _localDateString(today)


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT COUNT(*) AS total " +
                "FROM completions " +
                "WHERE local_date >= ? " +
                "AND local_date <= ?",
                [
                    startDate,
                    endDate
                ]
            )


            if (result.rows.length > 0)
                count = result.rows.item(0).total
        }
    )


    return count
}


// =============================================================
// CATEGORY COUNT
// =============================================================

function categoryCount(category) {
    var db = _database()
    var count = 0


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT COUNT(*) AS total " +
                "FROM completions " +
                "WHERE category = ?",
                [
                    category
                ]
            )


            if (result.rows.length > 0)
                count = result.rows.item(0).total
        }
    )


    return count
}


// =============================================================
// RECENT ACTION IDS
//
// Returns unique recently completed action IDs.
//
// Example:
//
// [
//     "home_03",
//     "home_08",
//     "home_01"
// ]
//
// This lets the task picker avoid recycling the same actions.
// =============================================================

function recentActionIds(
    category,
    limit
) {
    var db = _database()

    var ids = []

    var safeLimit =
            Math.max(
                1,
                Math.min(
                    20,
                    limit
                )
            )


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT action_id " +
                "FROM completions " +
                "WHERE category = ? " +
                "ORDER BY id DESC",
                [
                    category
                ]
            )


            for (
                var i = 0;
                i < result.rows.length;
                i++
            ) {
                var actionId =
                        result.rows.item(i).action_id


                if (
                    ids.indexOf(actionId) === -1
                ) {
                    ids.push(actionId)
                }


                if (
                    ids.length >= safeLimit
                ) {
                    break
                }
            }
        }
    )


    return ids
}


// =============================================================
// ACTIVE DATES
// =============================================================

function _activeDateMap() {
    var db = _database()

    var dates = {}


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT DISTINCT local_date " +
                "FROM completions"
            )


            for (
                var i = 0;
                i < result.rows.length;
                i++
            ) {
                var row =
                        result.rows.item(i)

                dates[row.local_date] = true
            }
        }
    )


    return dates
}


// =============================================================
// CURRENT STREAK
// =============================================================

function streakCount() {
    var activeDates =
            _activeDateMap()

    var today =
            new Date()

    var todayKey =
            _localDateString(today)

    var startDate =
            today


    if (!activeDates[todayKey]) {
        var yesterday =
                _addDays(today, -1)

        var yesterdayKey =
                _localDateString(
                    yesterday
                )


        if (!activeDates[yesterdayKey])
            return 0


        startDate = yesterday
    }


    var streak = 0
    var cursor = _copyDate(startDate)


    while (true) {
        var key =
                _localDateString(cursor)


        if (!activeDates[key])
            break


        streak += 1

        cursor =
                _addDays(cursor, -1)
    }


    return streak
}


// =============================================================
// LAST 7 DAYS
// =============================================================

function last7Days() {
    var db = _database()

    var today =
            new Date()

    var startDate =
            _addDays(today, -6)

    var startKey =
            _localDateString(startDate)

    var endKey =
            _localDateString(today)

    var countByDate = {}


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT " +
                "local_date, " +
                "COUNT(*) AS total " +
                "FROM completions " +
                "WHERE local_date >= ? " +
                "AND local_date <= ? " +
                "GROUP BY local_date",
                [
                    startKey,
                    endKey
                ]
            )


            for (
                var i = 0;
                i < result.rows.length;
                i++
            ) {
                var row =
                        result.rows.item(i)

                countByDate[row.local_date] =
                        row.total
            }
        }
    )


    var days = []


    for (
        var offset = -6;
        offset <= 0;
        offset++
    ) {
        var date =
                _addDays(
                    today,
                    offset
                )

        var key =
                _localDateString(date)


        days.push({
            date: key,

            weekday:
                    date.getDay(),

            count:
                    countByDate[key]
                    ? countByDate[key]
                    : 0
        })
    }


    return days
}


// =============================================================
// RECENT COMPLETIONS
// =============================================================

function recent(limit) {
    var db = _database()

    var items = []


    var safeLimit =
            Math.max(
                1,
                Math.min(
                    100,
                    limit
                )
            )


    db.readTransaction(
        function(tx) {
            var result = tx.executeSql(
                "SELECT " +
                "id, " +
                "completed_at, " +
                "local_date, " +
                "action_id, " +
                "category, " +
                "energy, " +
                "minutes, " +
                "context, " +
                "easy " +
                "FROM completions " +
                "ORDER BY id DESC " +
                "LIMIT " + safeLimit
            )


            for (
                var i = 0;
                i < result.rows.length;
                i++
            ) {
                var row =
                        result.rows.item(i)


                items.push({
                    id:
                            row.id,

                    completedAt:
                            row.completed_at,

                    localDate:
                            row.local_date,

                    actionId:
                            row.action_id,

                    category:
                            row.category,

                    energy:
                            row.energy,

                    minutes:
                            row.minutes,

                    context:
                            row.context,

                    easy:
                            row.easy === 1
                })
            }
        }
    )


    return items
}


// =============================================================
// FULL STATS
// =============================================================

function stats() {
    return {
        total:
                totalCount(),

        today:
                todayCount(),

        week:
                weekCount(),

        streak:
                streakCount(),

        home:
                categoryCount("Home"),

        body:
                categoryCount("Body"),

        mind:
                categoryCount("Mind"),

        money:
                categoryCount("Money"),

        work:
                categoryCount("Work"),

        social:
                categoryCount("Social"),

        last7Days:
                last7Days()
    }
}


// =============================================================
// DELETE ALL HISTORY
// =============================================================

function clearAll() {
    var db = _database()


    db.transaction(
        function(tx) {
            tx.executeSql(
                "DELETE FROM completions"
            )
        }
    )
}
