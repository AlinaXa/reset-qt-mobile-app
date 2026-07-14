import QtQuick
import QtQuick.Controls
import QtCore
import Reset

import "ActionLibrary.js" as ActionLibrary
import "SmartPicker.js" as SmartPicker
import "HistoryStore.js" as HistoryStore
import "InsightEngine.js" as InsightEngine


Window {
    id: root

    width: Constants.width
    height: Constants.height

    visible: true
    color: "#F7F1E8"


    // =========================================================
    // RESPONSIVE APP CANVAS
    //
    // The UI was designed at 390 × 844. Desktop keeps scale 1.
    // Android expands the native Window to the device size, so
    // the fixed design canvas is scaled uniformly to fit.
    // =========================================================

    readonly property real designWidth: Constants.width
    readonly property real designHeight: Constants.height


    onClosing: {
        root.saveTimerState()
    }


    // =========================================================
    // GLOBAL STATE
    // =========================================================

    property bool romanian: false

    property int energyLevel: 3
    property string selectedCategory: ""

    property int maxMinutes: 10
    property string selectedContext: "Any"

    property bool timerMode: false
    property bool timerPaused: false
    property bool completed: false

    property int secondsLeft: 300

    property int sessionCompleted: 0
    property int totalCompleted: 0


    // =========================================================
    // HISTORY STATE
    // =========================================================

    property int historyTodayCount: 0
    property int historyWeekCount: 0
    property int historyStreakCount: 0
    property int historyTotalCount: 0

    property int historyHomeCount: 0
    property int historyBodyCount: 0
    property int historyMindCount: 0
    property int historyMoneyCount: 0
    property int historyWorkCount: 0
    property int historySocialCount: 0

    property int historyChartMaxCount: 1

    property var historyLast7Days: []
    property var historyRecentItems: []


    // =========================================================
    // INSIGHT STATE
    // =========================================================

    property string historyInsightTitle: ""
    property string historyInsightBody: ""
    property string historyInsightTone: ""
    property string historyInsightCategory: ""
    property string historyInsightAccent: "#C9DDE5"


    // =========================================================
    // CURRENT ACTION
    // =========================================================

    property var currentAction: ({
        id: "",
        category: "",
        text: "",
        detail: "",
        minutes: 5,
        context: "Anywhere",
        easy: false
    })


    property var pendingAction: ({
        id: "",
        category: "",
        text: "",
        detail: "",
        minutes: 5,
        context: "Anywhere",
        easy: false
    })


    // =========================================================
    // STARTUP
    // =========================================================

    Component.onCompleted: {
        HistoryStore.init()

        root.loadHistoryData()

        Qt.callLater(
            root.restoreInterruptedTimer
        )
    }


    // =========================================================
    // PERSISTENT PREFERENCES
    // =========================================================

    Settings {
        id: persistentSettings

        location:
                StandardPaths.writableLocation(
                    StandardPaths.AppConfigLocation
                ) + "/reset.ini"

        category: "ResetPreferences"

        property alias romanian:
                root.romanian

        property alias maxMinutes:
                root.maxMinutes

        property alias selectedContext:
                root.selectedContext


        property bool savedTimerActive: false
        property int savedTimerSeconds: 0
        property string savedTimerActionId: ""
        property string savedTimerCategory: ""
        property int savedTimerEnergy: 3
        property bool savedTimerEasy: false
    }


    // =========================================================
    // INTERRUPTED TIMER PERSISTENCE
    // =========================================================

    function saveTimerState() {
        if (
            !root.timerMode
            || root.completed
            || !root.currentAction
            || root.currentAction.id === ""
        ) {
            return
        }


        persistentSettings.savedTimerActive = true
        persistentSettings.savedTimerSeconds =
                Math.max(
                    1,
                    root.secondsLeft
                )

        persistentSettings.savedTimerActionId =
                root.currentAction.id

        persistentSettings.savedTimerCategory =
                root.selectedCategory

        persistentSettings.savedTimerEnergy =
                root.energyLevel

        persistentSettings.savedTimerEasy =
                root.currentAction.easy
    }


    function clearSavedTimer() {
        persistentSettings.savedTimerActive = false
        persistentSettings.savedTimerSeconds = 0
        persistentSettings.savedTimerActionId = ""
        persistentSettings.savedTimerCategory = ""
        persistentSettings.savedTimerEnergy = 3
        persistentSettings.savedTimerEasy = false
    }


    function restoreInterruptedTimer() {
        if (!persistentSettings.savedTimerActive)
            return


        if (
            persistentSettings.savedTimerActionId === ""
            || persistentSettings.savedTimerCategory === ""
            || persistentSettings.savedTimerSeconds <= 0
        ) {
            root.clearSavedTimer()
            return
        }


        var restoredAction =
                SmartPicker.translateAction(
                    persistentSettings.savedTimerActionId,
                    persistentSettings.savedTimerEnergy,
                    root.romanian,
                    persistentSettings.savedTimerEasy
                )


        if (
            !restoredAction
            || !restoredAction.id
            || restoredAction.id === ""
        ) {
            root.clearSavedTimer()
            return
        }


        root.selectedCategory =
                persistentSettings.savedTimerCategory

        root.energyLevel =
                persistentSettings.savedTimerEnergy

        root.currentAction =
                restoredAction

        root.secondsLeft =
                Math.max(
                    1,
                    persistentSettings.savedTimerSeconds
                )

        root.sessionCompleted = 0
        root.completed = false
        root.timerMode = true
        root.timerPaused = true


        stackView.push(
            actionScreenComponent
        )
    }


    // =========================================================
    // ENERGY
    // =========================================================

    function setEnergy(level) {
        root.energyLevel = level

        root.maxMinutes =
                SmartPicker.recommendedMinutes(
                    level
                )
    }


    // =========================================================
    // LANGUAGE
    // =========================================================

    function setLanguage(useRomanian) {
        root.romanian = useRomanian


        if (
            root.currentAction
            && root.currentAction.id !== ""
        ) {
            root.currentAction =
                    SmartPicker.translateAction(
                        root.currentAction.id,
                        root.energyLevel,
                        root.romanian,
                        root.currentAction.easy
                    )
        }


        if (
            root.pendingAction
            && root.pendingAction.id !== ""
        ) {
            root.pendingAction =
                    SmartPicker.translateAction(
                        root.pendingAction.id,
                        root.energyLevel,
                        root.romanian,
                        root.pendingAction.easy
                    )
        }


        root.loadHistoryData()
    }


    // =========================================================
    // RECENT ACTION EXCLUSIONS
    // =========================================================

    function recentExcludedActionIds() {
        if (
            !root.selectedCategory
            || root.selectedCategory === ""
        ) {
            return []
        }


        return HistoryStore.recentActionIds(
            root.selectedCategory,
            4
        )
    }


    // =========================================================
    // SMART ACTION PICKER
    // =========================================================

    function chooseFirstAction() {
        var excludedIds =
                root.recentExcludedActionIds()


        root.currentAction =
                SmartPicker.pickSmart(
                    root.selectedCategory,
                    root.energyLevel,
                    "",
                    root.romanian,
                    root.maxMinutes,
                    root.selectedContext,
                    excludedIds
                )
    }


    function chooseAnotherAction() {
        var excludedIds =
                root.recentExcludedActionIds()


        root.pendingAction =
                SmartPicker.pickSmart(
                    root.selectedCategory,
                    root.energyLevel,
                    root.currentAction.id,
                    root.romanian,
                    root.maxMinutes,
                    root.selectedContext,
                    excludedIds
                )
    }


    function chooseEasierAction() {
        root.pendingAction =
                SmartPicker.easierVersion(
                    root.currentAction.id,
                    root.energyLevel,
                    root.romanian
                )
    }


    // =========================================================
    // HISTORY LABEL HELPERS
    // =========================================================

    function categoryLabel(category) {
        if (category === "Home")
            return root.romanian
                    ? "Acasă"
                    : "Home"


        if (category === "Body")
            return root.romanian
                    ? "Corp"
                    : "Body"


        if (category === "Mind")
            return root.romanian
                    ? "Minte"
                    : "Mind"


        if (category === "Money")
            return root.romanian
                    ? "Bani"
                    : "Money"


        if (category === "Work")
            return root.romanian
                    ? "Muncă"
                    : "Work"


        return "Social"
    }


    function historyMetaText(item) {
        return item.localDate
                + "  ·  "
                + root.categoryLabel(
                    item.category
                )
                + "  ·  "
                + item.minutes
                + " min"
    }


    // =========================================================
    // LOAD HISTORY FROM SQLITE
    // =========================================================

    function loadHistoryData() {
        var stats =
                HistoryStore.stats()


        // -----------------------------------------------------
        // MAIN STATS
        // -----------------------------------------------------

        root.historyTodayCount =
                stats.today

        root.historyWeekCount =
                stats.week

        root.historyStreakCount =
                stats.streak

        root.historyTotalCount =
                stats.total


        // -----------------------------------------------------
        // CATEGORY STATS
        // -----------------------------------------------------

        root.historyHomeCount =
                stats.home

        root.historyBodyCount =
                stats.body

        root.historyMindCount =
                stats.mind

        root.historyMoneyCount =
                stats.money

        root.historyWorkCount =
                stats.work

        root.historySocialCount =
                stats.social


        // -----------------------------------------------------
        // COMPLETION TOTAL
        // -----------------------------------------------------

        root.totalCompleted =
                stats.total


        // -----------------------------------------------------
        // INSIGHT
        // -----------------------------------------------------

        var currentInsight =
                InsightEngine.insight(
                    stats,
                    root.romanian
                )


        root.historyInsightTitle =
                currentInsight.title

        root.historyInsightBody =
                currentInsight.body

        root.historyInsightTone =
                currentInsight.tone

        root.historyInsightCategory =
                currentInsight.category

        root.historyInsightAccent =
                currentInsight.accent


        // -----------------------------------------------------
        // LAST 7 DAYS
        // -----------------------------------------------------

        var days =
                stats.last7Days
                ? stats.last7Days
                : []


        root.historyLast7Days =
                days


        // -----------------------------------------------------
        // FIND HIGHEST BAR VALUE
        // -----------------------------------------------------

        var highestCount = 1


        for (
            var dayIndex = 0;
            dayIndex < days.length;
            dayIndex++
        ) {
            if (
                days[dayIndex].count
                > highestCount
            ) {
                highestCount =
                        days[dayIndex].count
            }
        }


        root.historyChartMaxCount =
                highestCount


        // -----------------------------------------------------
        // RECENT ITEMS
        // -----------------------------------------------------

        var storedItems =
                HistoryStore.recent(5)

        var displayItems = []


        for (
            var i = 0;
            i < storedItems.length;
            i++
        ) {
            var stored =
                    storedItems[i]


            var translated =
                    ActionLibrary.translateAction(
                        stored.actionId,
                        stored.energy,
                        root.romanian,
                        stored.easy
                    )


            var displayText =
                    stored.actionId


            if (
                translated
                && translated.text !== ""
            ) {
                displayText =
                        translated.text
            }


            displayItems.push({
                text:
                        displayText,

                meta:
                        root.historyMetaText(
                            stored
                        ),

                category:
                        stored.category,

                easy:
                        stored.easy
            })
        }


        root.historyRecentItems =
                displayItems
    }


    // =========================================================
    // COMPLETE CURRENT ACTION
    // =========================================================

    function completeCurrentAction() {
        if (root.completed)
            return


        countdownTimer.stop()

        root.timerPaused = false
        root.timerMode = false

        root.clearSavedTimer()


        if (
            root.currentAction
            && root.currentAction.id !== ""
        ) {
            HistoryStore.addCompletion(
                root.currentAction.id,
                root.selectedCategory,
                root.energyLevel,
                root.currentAction.minutes,
                root.currentAction.context,
                root.currentAction.easy
            )
        }


        root.sessionCompleted += 1


        root.loadHistoryData()


        root.completed = true
    }


    // =========================================================
    // TIME FILTER
    // =========================================================

    function cycleTimeFilter(direction) {
        var options = [
            0,
            5,
            10,
            15
        ]


        var currentIndex =
                options.indexOf(
                    root.maxMinutes
                )


        if (currentIndex < 0)
            currentIndex = 0


        var newIndex =
                currentIndex + direction


        if (newIndex < 0)
            newIndex =
                    options.length - 1


        if (newIndex >= options.length)
            newIndex = 0


        root.maxMinutes =
                options[newIndex]
    }


    // =========================================================
    // CONTEXT FILTER
    // =========================================================

    function cycleContextFilter(direction) {
        var options = [
            "Any",
            "Home",
            "Desk",
            "Outside"
        ]


        var currentIndex =
                options.indexOf(
                    root.selectedContext
                )


        if (currentIndex < 0)
            currentIndex = 0


        var newIndex =
                currentIndex + direction


        if (newIndex < 0)
            newIndex =
                    options.length - 1


        if (newIndex >= options.length)
            newIndex = 0


        root.selectedContext =
                options[newIndex]
    }


    // =========================================================
    // TIMER FORMAT
    // =========================================================

    function formatTime(totalSeconds) {
        var minutes =
                Math.floor(
                    totalSeconds / 60
                )

        var seconds =
                totalSeconds % 60


        var minuteText =
                minutes < 10
                ? "0" + minutes
                : minutes


        var secondText =
                seconds < 10
                ? "0" + seconds
                : seconds


        return minuteText
                + ":"
                + secondText
    }


    // =========================================================
    // COMPLETION LABELS
    // =========================================================

    function sessionCountText() {
        if (root.romanian) {
            if (root.sessionCompleted === 1)
                return "1 lucru mic făcut"


            return root.sessionCompleted
                    + " lucruri mici făcute"
        }


        if (root.sessionCompleted === 1)
            return "1 small thing done"


        return root.sessionCompleted
                + " small things done"
    }


    function totalCountText() {
        if (root.romanian)
            return root.totalCompleted
                    + " în total"


        return root.totalCompleted
                + " total"
    }


    function completionCountText() {
        return root.sessionCountText()
                + "  ·  "
                + root.totalCountText()
    }


    // =========================================================
    // TIMER
    // =========================================================

    Timer {
        id: countdownTimer

        interval: 1000
        repeat: true


        onTriggered: {
            if (root.secondsLeft > 0)
                root.secondsLeft -= 1


            if (root.secondsLeft <= 0) {
                root.completeCurrentAction()
            } else {
                root.saveTimerState()
            }
        }
    }


    // =========================================================
    // SCREEN 1 — ENERGY
    // =========================================================

    Component {
        id: energyScreenComponent


        Item {
            id: energyPage

            width: stackView.width
            height: stackView.height

            property bool historyHover: false
            property bool historyPressed: false

            property bool settingsHover: false
            property bool settingsPressed: false


            Screen01 {
                id: energyScreen

                anchors.fill: parent

                romanian:
                        root.romanian

                energyLevel:
                        root.energyLevel

                titleReveal: 0
                subtitleReveal: 0
                dialReveal: 0
            }


            // -------------------------------------------------
            // INTRO
            // -------------------------------------------------

            ParallelAnimation {
                id: energyIntro


                NumberAnimation {
                    target: energyScreen
                    property: "titleReveal"

                    from: 0
                    to: 1

                    duration: 360

                    easing.type:
                            Easing.OutCubic
                }


                SequentialAnimation {
                    PauseAnimation {
                        duration: 110
                    }


                    NumberAnimation {
                        target: energyScreen
                        property: "subtitleReveal"

                        from: 0
                        to: 1

                        duration: 300

                        easing.type:
                                Easing.OutCubic
                    }
                }


                SequentialAnimation {
                    PauseAnimation {
                        duration: 180
                    }


                    NumberAnimation {
                        target: energyScreen
                        property: "dialReveal"

                        from: 0
                        to: 1

                        duration: 420

                        easing.type:
                                Easing.OutCubic
                    }
                }
            }


            Component.onCompleted: {
                energyIntro.start()
            }


            // -------------------------------------------------
            // SETTINGS BUTTON
            // -------------------------------------------------

            Rectangle {
                x: 148
                y: 26

                width: 32
                height: 32

                radius: 16

                scale:
                        energyPage.settingsPressed
                        ? 0.94
                        : energyPage.settingsHover
                          ? 1.04
                          : 1.0

                color:
                        energyPage.settingsPressed
                        ? "#E8E5DF"
                        : energyPage.settingsHover
                          ? "#F1EEE8"
                          : "transparent"


                Behavior on scale {
                    NumberAnimation {
                        duration: 130

                        easing.type:
                                Easing.OutCubic
                    }
                }


                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }


                Item {
                    anchors.centerIn: parent

                    width: 16
                    height: 16


                    Rectangle {
                        x: 1
                        y: 3

                        width: 14
                        height: 1

                        color: "#555D63"
                    }


                    Rectangle {
                        x: 1
                        y: 8

                        width: 14
                        height: 1

                        color: "#555D63"
                    }


                    Rectangle {
                        x: 1
                        y: 13

                        width: 14
                        height: 1

                        color: "#555D63"
                    }


                    Rectangle {
                        x: 4
                        y: 1

                        width: 4
                        height: 4

                        radius: 2

                        color: "#F2A889"
                    }


                    Rectangle {
                        x: 9
                        y: 6

                        width: 4
                        height: 4

                        radius: 2

                        color: "#A9C7B0"
                    }


                    Rectangle {
                        x: 3
                        y: 11

                        width: 4
                        height: 4

                        radius: 2

                        color: "#C9DDE5"
                    }
                }
            }


            MouseArea {
                x: 148
                y: 26

                width: 32
                height: 32

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    energyPage.settingsHover = true
                }


                onExited: {
                    energyPage.settingsHover = false
                }


                onPressed: {
                    energyPage.settingsPressed = true
                }


                onReleased: {
                    energyPage.settingsPressed = false
                }


                onCanceled: {
                    energyPage.settingsPressed = false
                }


                onClicked: {
                    stackView.push(
                        settingsScreenComponent
                    )
                }
            }


            // -------------------------------------------------
            // HISTORY BUTTON
            // -------------------------------------------------

            Rectangle {
                x: 188
                y: 26

                width: 82
                height: 32

                radius: 16

                scale:
                        energyPage.historyPressed
                        ? 0.96
                        : energyPage.historyHover
                          ? 1.03
                          : 1.0

                color:
                        energyPage.historyPressed
                        ? "#E8E5DF"
                        : energyPage.historyHover
                          ? "#F1EEE8"
                          : "transparent"


                Behavior on scale {
                    NumberAnimation {
                        duration: 130

                        easing.type:
                                Easing.OutCubic
                    }
                }


                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }


                Text {
                    anchors.centerIn: parent

                    text:
                            root.romanian
                            ? "Istoric"
                            : "History"

                    color: "#555D63"

                    font.pixelSize: 11
                    font.bold: true
                }
            }


            MouseArea {
                x: 188
                y: 26

                width: 82
                height: 32

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    energyPage.historyHover = true
                }


                onExited: {
                    energyPage.historyHover = false
                }


                onPressed: {
                    energyPage.historyPressed = true
                }


                onReleased: {
                    energyPage.historyPressed = false
                }


                onCanceled: {
                    energyPage.historyPressed = false
                }


                onClicked: {
                    root.loadHistoryData()


                    stackView.push(
                        historyScreenComponent
                    )
                }
            }


            // -------------------------------------------------
            // LANGUAGE
            // -------------------------------------------------

            MouseArea {
                x: 282
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            MouseArea {
                x: 318
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }


            // -------------------------------------------------
            // ENERGY 1
            // -------------------------------------------------

            MouseArea {
                x: 112
                y: 518

                width: 36
                height: 48

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setEnergy(1)
                }
            }


            // -------------------------------------------------
            // ENERGY 2
            // -------------------------------------------------

            MouseArea {
                x: 143
                y: 518

                width: 36
                height: 48

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setEnergy(2)
                }
            }


            // -------------------------------------------------
            // ENERGY 3
            // -------------------------------------------------

            MouseArea {
                x: 177
                y: 518

                width: 36
                height: 48

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setEnergy(3)
                }
            }


            // -------------------------------------------------
            // ENERGY 4
            // -------------------------------------------------

            MouseArea {
                x: 211
                y: 518

                width: 36
                height: 48

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setEnergy(4)
                }
            }


            // -------------------------------------------------
            // ENERGY 5
            // -------------------------------------------------

            MouseArea {
                x: 242
                y: 518

                width: 36
                height: 48

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setEnergy(5)
                }
            }


            // -------------------------------------------------
            // CONTINUE
            // -------------------------------------------------

            MouseArea {
                x: 30
                y: parent.height - 100

                width: 330
                height: 60

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.selectedCategory = ""
                    root.sessionCompleted = 0


                    stackView.push(
                        categoryScreenComponent
                    )
                }
            }
        }
    }


    // =========================================================
    // SCREEN 2 — CATEGORY
    // =========================================================

    Component {
        id: categoryScreenComponent


        Item {
            width: stackView.width
            height: stackView.height


            Screen02 {
                id: categoryScreen

                anchors.fill: parent

                romanian:
                        root.romanian

                selectedCategory:
                        root.selectedCategory

                titleReveal: 0
                cardsReveal: 0
                buttonReveal: 0
            }


            ParallelAnimation {
                id: categoryIntro


                NumberAnimation {
                    target: categoryScreen
                    property: "titleReveal"

                    from: 0
                    to: 1

                    duration: 320

                    easing.type:
                            Easing.OutCubic
                }


                SequentialAnimation {
                    PauseAnimation {
                        duration: 120
                    }


                    NumberAnimation {
                        target: categoryScreen
                        property: "cardsReveal"

                        from: 0
                        to: 1

                        duration: 380

                        easing.type:
                                Easing.OutCubic
                    }
                }


                SequentialAnimation {
                    PauseAnimation {
                        duration: 260
                    }


                    NumberAnimation {
                        target: categoryScreen
                        property: "buttonReveal"

                        from: 0
                        to: 1

                        duration: 300

                        easing.type:
                                Easing.OutCubic
                    }
                }
            }


            Component.onCompleted: {
                categoryIntro.start()
            }


            // BACK

            MouseArea {
                x: 25
                y: 25

                width: 40
                height: 40

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    stackView.pop()
                }
            }


            // LANGUAGE EN

            MouseArea {
                x: 282
                y: 26

                width: 40
                height: 34

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            // LANGUAGE RO

            MouseArea {
                x: 322
                y: 26

                width: 40
                height: 34

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }


            // HOME

            MouseArea {
                x: 28
                y: 235

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Home"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Home"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Home"
                }
            }


            // BODY

            MouseArea {
                x: 207
                y: 235

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Body"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Body"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Body"
                }
            }


            // MIND

            MouseArea {
                x: 28
                y: 358

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Mind"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Mind"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Mind"
                }
            }


            // MONEY

            MouseArea {
                x: 207
                y: 358

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Money"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Money"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Money"
                }
            }


            // WORK

            MouseArea {
                x: 28
                y: 481

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Work"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Work"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Work"
                }
            }


            // SOCIAL

            MouseArea {
                x: 207
                y: 481

                width: 155
                height: 98

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    categoryScreen.hoverCategory = "Social"
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    categoryScreen.pressedCategory = "Social"
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    root.selectedCategory = "Social"
                }
            }


            // CONTINUE

            MouseArea {
                x: 30
                y: 756

                width: 330
                height: 58

                enabled:
                        root.selectedCategory !== ""

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        categoryScreen.hoverCategory =
                                "Continue"
                    }
                }


                onExited: {
                    categoryScreen.hoverCategory = ""
                }


                onPressed: {
                    if (enabled) {
                        categoryScreen.pressedCategory =
                                "Continue"
                    }
                }


                onReleased: {
                    categoryScreen.pressedCategory = ""
                }


                onCanceled: {
                    categoryScreen.pressedCategory = ""
                }


                onClicked: {
                    countdownTimer.stop()

                    root.timerMode = false
                    root.timerPaused = false
                    root.completed = false

                    root.clearSavedTimer()

                    root.secondsLeft = 300

                    root.chooseFirstAction()


                    stackView.push(
                        actionScreenComponent
                    )
                }
            }
        }
    }


    // =========================================================
    // SCREEN 3 — ACTION
    // =========================================================

    Component {
        id: actionScreenComponent


        Item {
            id: actionPage

            width: stackView.width
            height: stackView.height

            property string completionHover: ""
            property string completionPressed: ""


            Screen03 {
                id: actionScreen

                anchors.fill: parent

                romanian:
                        root.romanian

                selectedCategory:
                        root.selectedCategory

                energyLevel:
                        root.energyLevel

                actionText:
                        root.currentAction.text

                actionDetail:
                        root.currentAction.detail

                actionMinutes:
                        root.currentAction.minutes

                actionContext:
                        root.currentAction.context

                maxMinutes:
                        root.maxMinutes

                selectedContext:
                        root.selectedContext

                timerMode:
                        root.timerMode

                timerPaused:
                        root.timerPaused

                completed:
                        root.completed

                secondsLeft:
                        root.secondsLeft

                timerText:
                        root.formatTime(
                            root.secondsLeft
                        )

                actionReveal: 0
                timerReveal: 1
                completeReveal: 1
            }


            // =================================================
            // ANIMATIONS
            // =================================================

            NumberAnimation {
                id: actionIntro

                target: actionScreen
                property: "actionReveal"

                from: 0
                to: 1

                duration: 380

                easing.type:
                        Easing.OutCubic
            }


            SequentialAnimation {
                id: actionSwap


                NumberAnimation {
                    target: actionScreen
                    property: "actionReveal"

                    to: 0

                    duration: 120

                    easing.type:
                            Easing.InCubic
                }


                ScriptAction {
                    script: {
                        root.currentAction =
                                root.pendingAction
                    }
                }


                NumberAnimation {
                    target: actionScreen
                    property: "actionReveal"

                    to: 1

                    duration: 220

                    easing.type:
                            Easing.OutCubic
                }
            }


            NumberAnimation {
                id: timerIntro

                target: actionScreen
                property: "timerReveal"

                from: 0
                to: 1

                duration: 380

                easing.type:
                        Easing.OutCubic
            }


            NumberAnimation {
                id: completeIntro

                target: actionScreen
                property: "completeReveal"

                from: 0
                to: 1

                duration: 460

                easing.type:
                        Easing.OutBack

                easing.overshoot: 0.55
            }


            SequentialAnimation {
                id: completionToAction


                NumberAnimation {
                    target: actionScreen
                    property: "completeReveal"

                    to: 0

                    duration: 140

                    easing.type:
                            Easing.InCubic
                }


                ScriptAction {
                    script: {
                        root.chooseAnotherAction()

                        root.currentAction =
                                root.pendingAction

                        root.timerMode = false
                        root.timerPaused = false
                        root.completed = false

                        actionScreen.actionReveal = 0
                    }
                }


                NumberAnimation {
                    target: actionScreen
                    property: "actionReveal"

                    from: 0
                    to: 1

                    duration: 320

                    easing.type:
                            Easing.OutCubic
                }
            }


            Component.onCompleted: {
                actionIntro.start()
            }


            Connections {
                target: root


                function onTimerModeChanged() {
                    if (root.timerMode) {
                        actionScreen.timerReveal = 0

                        timerIntro.restart()
                    }
                }


                function onCompletedChanged() {
                    if (root.completed) {
                        actionScreen.completeReveal = 0

                        completeIntro.restart()
                    }
                }
            }


            // BACK

            MouseArea {
                x: 25
                y: 25

                width: 34
                height: 34

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Back"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Back"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    countdownTimer.stop()

                    root.timerMode = false
                    root.timerPaused = false
                    root.completed = false

                    root.clearSavedTimer()

                    stackView.pop()
                }
            }


            // LANGUAGE EN

            MouseArea {
                x: 282
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            // LANGUAGE RO

            MouseArea {
                x: 318
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }


            // TIME PREVIOUS

            MouseArea {
                x: 36
                y: 248

                width: 30
                height: 30

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        actionScreen.hoverControl =
                                "TimePrev"
                    }
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    if (enabled) {
                        actionScreen.pressedControl =
                                "TimePrev"
                    }
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.cycleTimeFilter(-1)

                    root.chooseAnotherAction()

                    actionSwap.restart()
                }
            }


            // TIME NEXT

            MouseArea {
                x: 149
                y: 248

                width: 30
                height: 30

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        actionScreen.hoverControl =
                                "TimeNext"
                    }
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    if (enabled) {
                        actionScreen.pressedControl =
                                "TimeNext"
                    }
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.cycleTimeFilter(1)

                    root.chooseAnotherAction()

                    actionSwap.restart()
                }
            }


            // PLACE PREVIOUS

            MouseArea {
                x: 211
                y: 248

                width: 30
                height: 30

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        actionScreen.hoverControl =
                                "PlacePrev"
                    }
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    if (enabled) {
                        actionScreen.pressedControl =
                                "PlacePrev"
                    }
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.cycleContextFilter(-1)

                    root.chooseAnotherAction()

                    actionSwap.restart()
                }
            }


            // PLACE NEXT

            MouseArea {
                x: 324
                y: 248

                width: 30
                height: 30

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        actionScreen.hoverControl =
                                "PlaceNext"
                    }
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    if (enabled) {
                        actionScreen.pressedControl =
                                "PlaceNext"
                    }
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.cycleContextFilter(1)

                    root.chooseAnotherAction()

                    actionSwap.restart()
                }
            }


            // START

            MouseArea {
                x: 30
                y: 575

                width: 330
                height: 58

                enabled:
                        !root.timerMode
                        && !root.completed

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Start"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Start"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.secondsLeft =
                            Math.max(
                                1,
                                root.currentAction.minutes
                            ) * 60

                    root.timerPaused = false
                    root.completed = false
                    root.timerMode = true

                    root.saveTimerState()

                    countdownTimer.restart()
                }
            }


            // TOO MUCH

            MouseArea {
                x: 30
                y: 650

                width: 155
                height: 50

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Easier"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Easier"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.chooseEasierAction()

                    actionSwap.restart()
                }
            }


            // ANOTHER

            MouseArea {
                x: 205
                y: 650

                width: 155
                height: 50

                enabled:
                        !root.timerMode
                        && !root.completed
                        && !actionSwap.running

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Another"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Another"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.chooseAnotherAction()

                    actionSwap.restart()
                }
            }


            // PAUSE / RESUME

            MouseArea {
                x: 30
                y: 650

                width: 155
                height: 56

                enabled:
                        root.timerMode
                        && !root.completed

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Pause"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Pause"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    if (countdownTimer.running) {
                        countdownTimer.stop()

                        root.timerPaused = true
                    } else {
                        countdownTimer.start()

                        root.timerPaused = false
                    }


                    root.saveTimerState()
                }
            }


            // DONE

            MouseArea {
                x: 205
                y: 650

                width: 155
                height: 56

                enabled:
                        root.timerMode
                        && !root.completed

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionScreen.hoverControl = "Done"
                }


                onExited: {
                    actionScreen.hoverControl = ""
                }


                onPressed: {
                    actionScreen.pressedControl = "Done"
                }


                onReleased: {
                    actionScreen.pressedControl = ""
                }


                onCanceled: {
                    actionScreen.pressedControl = ""
                }


                onClicked: {
                    root.completeCurrentAction()
                }
            }


            // COMPLETION COUNT

            Text {
                visible:
                        root.completed

                x: 30
                y: 557

                width: 330
                height: 24

                opacity:
                        actionScreen.completeReveal

                text:
                        root.completionCountText()

                color: "#6F746F"

                font.pixelSize: 12
                font.bold: true
                font.letterSpacing: 0.4

                horizontalAlignment:
                        Text.AlignHCenter

                verticalAlignment:
                        Text.AlignVCenter
            }


            // ANOTHER SMALL THING

            Rectangle {
                visible:
                        root.completed

                x: 30
                y: 590

                width: 330
                height: 58

                radius: 29

                opacity:
                        actionScreen.completeReveal

                scale:
                        actionPage.completionPressed
                        === "Another"
                        ? 0.985
                        : actionPage.completionHover
                          === "Another"
                          ? 1.012
                          : 1.0

                color:
                        actionPage.completionHover
                        === "Another"
                        ? "#202A36"
                        : "#18202A"


                Behavior on scale {
                    NumberAnimation {
                        duration: 140

                        easing.type:
                                Easing.OutCubic
                    }
                }


                Text {
                    anchors.centerIn: parent

                    text:
                            root.romanian
                            ? "Încă un lucru mic"
                            : "Another small thing"

                    color: "#FFFDFC"

                    font.pixelSize: 15
                    font.bold: true
                }
            }


            MouseArea {
                x: 30
                y: 590

                width: 330
                height: 58

                enabled:
                        root.completed
                        && !completionToAction.running

                hoverEnabled: true

                cursorShape:
                        enabled
                        ? Qt.PointingHandCursor
                        : Qt.ArrowCursor


                onEntered: {
                    if (enabled) {
                        actionPage.completionHover =
                                "Another"
                    }
                }


                onExited: {
                    actionPage.completionHover = ""
                }


                onPressed: {
                    if (enabled) {
                        actionPage.completionPressed =
                                "Another"
                    }
                }


                onReleased: {
                    actionPage.completionPressed = ""
                }


                onCanceled: {
                    actionPage.completionPressed = ""
                }


                onClicked: {
                    actionPage.completionHover = ""

                    completionToAction.restart()
                }
            }


            // DONE FOR NOW

            Rectangle {
                visible:
                        root.completed

                x: 30
                y: 662

                width: 330
                height: 50

                radius: 25

                opacity:
                        actionScreen.completeReveal

                scale:
                        actionPage.completionPressed
                        === "Finish"
                        ? 0.985
                        : actionPage.completionHover
                          === "Finish"
                          ? 1.01
                          : 1.0

                color:
                        actionPage.completionHover
                        === "Finish"
                        ? "#F7F4EE"
                        : "#FFFDFC"

                border.color:
                        actionPage.completionHover
                        === "Finish"
                        ? "#BFC2C0"
                        : "#D8D9D6"

                border.width: 1


                Text {
                    anchors.centerIn: parent

                    text:
                            root.romanian
                            ? "Gata pentru acum"
                            : "Done for now"

                    color: "#18202A"

                    font.pixelSize: 14
                }
            }


            MouseArea {
                x: 30
                y: 662

                width: 330
                height: 50

                enabled:
                        root.completed

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    actionPage.completionHover =
                            "Finish"
                }


                onExited: {
                    actionPage.completionHover = ""
                }


                onPressed: {
                    actionPage.completionPressed =
                            "Finish"
                }


                onReleased: {
                    actionPage.completionPressed = ""
                }


                onCanceled: {
                    actionPage.completionPressed = ""
                }


                onClicked: {
                    countdownTimer.stop()

                    root.timerMode = false
                    root.timerPaused = false
                    root.completed = false

                    root.clearSavedTimer()

                    root.selectedCategory = ""

                    actionPage.completionHover = ""
                    actionPage.completionPressed = ""


                    stackView.pop(null)
                }
            }
        }
    }


    // =========================================================
    // SCREEN 4 — HISTORY
    // =========================================================

    Component {
        id: historyScreenComponent


        Item {
            width: stackView.width
            height: stackView.height


            Screen04 {
                id: historyScreen

                anchors.fill: parent

                romanian:
                        root.romanian


                // MAIN STATS

                todayCount:
                        root.historyTodayCount

                weekCount:
                        root.historyWeekCount

                streakCount:
                        root.historyStreakCount

                totalCount:
                        root.historyTotalCount


                // INSIGHT

                insightTitle:
                        root.historyInsightTitle

                insightBody:
                        root.historyInsightBody

                insightTone:
                        root.historyInsightTone

                insightCategory:
                        root.historyInsightCategory

                insightAccent:
                        root.historyInsightAccent


                // CHART

                chartMaxCount:
                        root.historyChartMaxCount

                last7Days:
                        root.historyLast7Days


                // CATEGORIES

                homeCount:
                        root.historyHomeCount

                bodyCount:
                        root.historyBodyCount

                mindCount:
                        root.historyMindCount

                moneyCount:
                        root.historyMoneyCount

                workCount:
                        root.historyWorkCount

                socialCount:
                        root.historySocialCount


                // RECENT

                recentItems:
                        root.historyRecentItems


                contentReveal: 0
            }


            // -------------------------------------------------
            // INTRO
            // -------------------------------------------------

            NumberAnimation {
                id: historyIntro

                target: historyScreen
                property: "contentReveal"

                from: 0
                to: 1

                duration: 420

                easing.type:
                        Easing.OutCubic
            }


            Component.onCompleted: {
                root.loadHistoryData()

                historyIntro.start()
            }


            // -------------------------------------------------
            // BACK
            // -------------------------------------------------

            MouseArea {
                x: 25
                y: 25

                width: 34
                height: 34

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    historyScreen.hoverControl = "Back"
                }


                onExited: {
                    historyScreen.hoverControl = ""
                }


                onPressed: {
                    historyScreen.pressedControl = "Back"
                }


                onReleased: {
                    historyScreen.pressedControl = ""
                }


                onCanceled: {
                    historyScreen.pressedControl = ""
                }


                onClicked: {
                    stackView.pop()
                }
            }


            // -------------------------------------------------
            // LANGUAGE EN
            // -------------------------------------------------

            MouseArea {
                x: 282
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            // -------------------------------------------------
            // LANGUAGE RO
            // -------------------------------------------------

            MouseArea {
                x: 318
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }
        }
    }


    // =========================================================
    // SCREEN 5 — SETTINGS
    // =========================================================

    Component {
        id: settingsScreenComponent


        Item {
            width: stackView.width
            height: stackView.height


            Screen05 {
                id: settingsScreen

                anchors.fill: parent

                romanian:
                        root.romanian

                selectedContext:
                        root.selectedContext

                totalCount:
                        root.historyTotalCount

                contentReveal: 0
            }


            // -------------------------------------------------
            // INTRO
            // -------------------------------------------------

            NumberAnimation {
                id: settingsIntro

                target: settingsScreen
                property: "contentReveal"

                from: 0
                to: 1

                duration: 360

                easing.type:
                        Easing.OutCubic
            }


            Component.onCompleted: {
                root.loadHistoryData()

                settingsIntro.start()
            }


            // -------------------------------------------------
            // BACK
            // -------------------------------------------------

            MouseArea {
                x: 25
                y: 25

                width: 34
                height: 34

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    settingsScreen.hoverControl = "Back"
                }


                onExited: {
                    settingsScreen.hoverControl = ""
                }


                onPressed: {
                    settingsScreen.pressedControl = "Back"
                }


                onReleased: {
                    settingsScreen.pressedControl = ""
                }


                onCanceled: {
                    settingsScreen.pressedControl = ""
                }


                onClicked: {
                    settingsScreen.confirmReset = false

                    stackView.pop()
                }
            }


            // -------------------------------------------------
            // TOP LANGUAGE EN
            // -------------------------------------------------

            MouseArea {
                x: 282
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            // -------------------------------------------------
            // TOP LANGUAGE RO
            // -------------------------------------------------

            MouseArea {
                x: 318
                y: 26

                width: 36
                height: 32

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }


            // -------------------------------------------------
            // LANGUAGE EN
            // -------------------------------------------------

            MouseArea {
                x: 45
                y: 238

                width: 150
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(false)
                }
            }


            // -------------------------------------------------
            // LANGUAGE RO
            // -------------------------------------------------

            MouseArea {
                x: 195
                y: 238

                width: 150
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.setLanguage(true)
                }
            }


            // -------------------------------------------------
            // PLACE ANY
            // -------------------------------------------------

            MouseArea {
                x: 45
                y: 407

                width: 75
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.selectedContext = "Any"
                }
            }


            // -------------------------------------------------
            // PLACE HOME
            // -------------------------------------------------

            MouseArea {
                x: 120
                y: 407

                width: 75
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.selectedContext = "Home"
                }
            }


            // -------------------------------------------------
            // PLACE DESK
            // -------------------------------------------------

            MouseArea {
                x: 195
                y: 407

                width: 75
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.selectedContext = "Desk"
                }
            }


            // -------------------------------------------------
            // PLACE OUTSIDE
            // -------------------------------------------------

            MouseArea {
                x: 270
                y: 407

                width: 75
                height: 44

                cursorShape:
                        Qt.PointingHandCursor


                onClicked: {
                    root.selectedContext = "Outside"
                }
            }


            // -------------------------------------------------
            // RESET HISTORY
            // -------------------------------------------------

            MouseArea {
                x: 46
                y: 756

                width: 298
                height: 44

                hoverEnabled: true

                cursorShape:
                        Qt.PointingHandCursor


                onEntered: {
                    settingsScreen.hoverControl = "Reset"
                }


                onExited: {
                    settingsScreen.hoverControl = ""
                }


                onPressed: {
                    settingsScreen.pressedControl = "Reset"
                }


                onReleased: {
                    settingsScreen.pressedControl = ""
                }


                onCanceled: {
                    settingsScreen.pressedControl = ""
                }


                onClicked: {
                    if (!settingsScreen.confirmReset) {
                        settingsScreen.confirmReset = true

                        return
                    }


                    HistoryStore.clearAll()

                    root.sessionCompleted = 0

                    root.loadHistoryData()

                    settingsScreen.confirmReset = false
                }
            }
        }
    }


    // =========================================================
    // RESPONSIVE NAVIGATION CANVAS
    // =========================================================

    Item {
        id: appCanvas

        width: root.designWidth
        height: root.designHeight

        anchors.centerIn: parent

        scale: Math.min(
                   root.width / root.designWidth,
                   root.height / root.designHeight
               )

        transformOrigin: Item.Center
        clip: true


        StackView {
            id: stackView

            anchors.fill: parent

        initialItem:
                energyScreenComponent


        pushEnter: Transition {
            ParallelAnimation {

                NumberAnimation {
                    property: "x"

                    from:
                            stackView.width * 0.08

                    to: 0

                    duration: 300

                    easing.type:
                            Easing.OutCubic
                }


                NumberAnimation {
                    property: "opacity"

                    from: 0
                    to: 1

                    duration: 240
                }
            }
        }


        pushExit: Transition {
            ParallelAnimation {

                NumberAnimation {
                    property: "x"

                    from: 0

                    to:
                            -stackView.width * 0.035

                    duration: 260

                    easing.type:
                            Easing.OutCubic
                }


                NumberAnimation {
                    property: "opacity"

                    from: 1
                    to: 0.72

                    duration: 220
                }
            }
        }


        popEnter: Transition {
            ParallelAnimation {

                NumberAnimation {
                    property: "x"

                    from:
                            -stackView.width * 0.035

                    to: 0

                    duration: 280

                    easing.type:
                            Easing.OutCubic
                }


                NumberAnimation {
                    property: "opacity"

                    from: 0.72
                    to: 1

                    duration: 230
                }
            }
        }


        popExit: Transition {
            ParallelAnimation {

                NumberAnimation {
                    property: "x"

                    from: 0

                    to:
                            stackView.width * 0.08

                    duration: 270

                    easing.type:
                            Easing.InOutCubic
                }


                NumberAnimation {
                    property: "opacity"

                    from: 1
                    to: 0

                    duration: 220
                }
            }
        }
        }
    }
}
