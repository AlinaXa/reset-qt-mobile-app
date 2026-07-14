import QtQuick
import QtQuick.Controls
import Reset

Rectangle {
    id: screen04Root

    property bool romanian: false

    property int todayCount: 0
    property int weekCount: 0
    property int streakCount: 0
    property int totalCount: 0

    property int homeCount: 0
    property int bodyCount: 0
    property int mindCount: 0
    property int moneyCount: 0
    property int workCount: 0
    property int socialCount: 0

    property int chartMaxCount: 1

    property var last7Days: []
    property var recentItems: []

    // =========================================================
    // INSIGHT
    // =========================================================
    property string insightTitle: romanian ? "De aici începe." : "This is where it starts."

    property string insightBody: romanian ? "Primul lucru mic va schimba acest ecran." : "Your first small thing will change this screen."

    property string insightTone: "new"
    property string insightCategory: ""
    property string insightAccent: "#C9DDE5"

    property string hoverControl: ""
    property string pressedControl: ""

    property real contentReveal: 1.0

    width: Constants.width
    height: Constants.height

    color: "#F7F1E8"
    clip: true

    // =========================================================
    // BACKGROUND
    // =========================================================
    Rectangle {
        width: 350
        height: 350

        x: 205
        y: 105

        radius: 175

        color: "#C9DDE5"
        opacity: 0.14
    }

    Rectangle {
        width: 310
        height: 310

        x: -185
        y: 650

        radius: 155

        color: "#A9C7B0"
        opacity: 0.15
    }

    Rectangle {
        width: 260
        height: 150

        x: 185
        y: 500

        radius: 75
        rotation: -22

        color: "transparent"

        border.color: "#F2A889"
        border.width: 1

        opacity: 0.18
    }

    // =========================================================
    // TOP RAIL
    // =========================================================
    Rectangle {
        id: topRail

        x: 18
        y: 18

        width: 354
        height: 48

        radius: 24

        color: "#FFFDFC"
        opacity: 0.84

        border.color: "#D8D9D6"
        border.width: 1

        // BACK
        Rectangle {
            x: 7
            y: 7

            width: 34
            height: 34

            radius: 17

            scale: screen04Root.pressedControl
                   === "Back" ? 0.94 : screen04Root.hoverControl === "Back" ? 1.04 : 1.0

            color: screen04Root.hoverControl === "Back" ? "#F1EEE8" : "#F7F4EE"

            Behavior on scale {
                NumberAnimation {
                    duration: 140
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Text {
                anchors.centerIn: parent

                text: "‹"

                color: "#18202A"

                font.pixelSize: 25
            }
        }

        // LOGO
        Item {
            x: 53
            y: 12

            width: 24
            height: 24

            Rectangle {
                width: 24
                height: 24

                radius: 12

                color: "#555D63"
            }

            Rectangle {
                width: 18
                height: 18

                x: 3
                y: 3

                radius: 9

                color: "#FFFDFC"
            }

            Rectangle {
                width: 10
                height: 8

                x: 15
                y: 14

                color: "#FFFDFC"
            }

            Rectangle {
                width: 6
                height: 6

                x: 16
                y: 2

                radius: 3

                color: "#F2A889"
            }
        }

        Text {
            x: 84
            y: 16

            text: "RESET"

            color: "#18202A"

            font.pixelSize: 12
            font.bold: true
            font.letterSpacing: 2
        }

        // LANGUAGE
        Rectangle {
            x: 264
            y: 8

            width: 72
            height: 32

            radius: 16

            color: "#EFECE6"

            Rectangle {
                width: 36
                height: 32

                radius: 16

                color: screen04Root.romanian ? "transparent" : "#FFFDFC"

                Text {
                    anchors.centerIn: parent

                    text: "EN"

                    color: screen04Root.romanian ? "#6F746F" : "#18202A"

                    font.pixelSize: 12
                    font.bold: !screen04Root.romanian
                }
            }

            Rectangle {
                x: 36

                width: 36
                height: 32

                radius: 16

                color: screen04Root.romanian ? "#FFFDFC" : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: "RO"

                    color: screen04Root.romanian ? "#18202A" : "#6F746F"

                    font.pixelSize: 12
                    font.bold: screen04Root.romanian
                }
            }
        }
    }

    // =========================================================
    // SCROLL
    // =========================================================
    Flickable {
        x: 0
        y: 78

        width: parent.width
        height: parent.height - 78

        contentWidth: width

        contentHeight: historyContent.height + 34

        clip: true

        boundsBehavior: Flickable.StopAtBounds

        opacity: screen04Root.contentReveal

        Item {
            id: historyContent

            width: parent.width

            height: 1140 + (screen04Root.recentItems.length * 92)

            // =================================================
            // TITLE
            // =================================================
            Text {
                x: 28
                y: 12

                text: screen04Root.romanian ? "Istoric" : "History"

                color: "#18202A"

                font.pixelSize: 30
                font.bold: true
            }

            Text {
                x: 28
                y: 54

                text: screen04Root.romanian ? "Lucrurile mici se adună." : "Small things add up."

                color: "#6F746F"

                font.pixelSize: 14
            }

            // =================================================
            // TODAY
            // =================================================
            Rectangle {
                x: 28
                y: 96

                width: 156
                height: 112

                radius: 24

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                Rectangle {
                    width: 68
                    height: 68

                    x: 12
                    y: 22

                    radius: 34

                    color: "#EAF3F6"

                    Text {
                        anchors.centerIn: parent

                        text: screen04Root.todayCount

                        color: "#18202A"

                        font.pixelSize: 30
                        font.bold: true
                    }
                }

                Text {
                    x: 94
                    y: 27

                    text: screen04Root.romanian ? "AZI" : "TODAY"

                    color: "#8B8F8B"

                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                Text {
                    x: 94
                    y: 48

                    width: 50

                    text: screen04Root.romanian ? "lucruri\nfăcute" : "things\ndone"

                    color: "#18202A"

                    font.pixelSize: 12
                    font.bold: true

                    wrapMode: Text.WordWrap
                }
            }

            // =================================================
            // THIS WEEK
            // =================================================
            Rectangle {
                x: 206
                y: 96

                width: 156
                height: 112

                radius: 24

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                Rectangle {
                    width: 68
                    height: 68

                    x: 12
                    y: 22

                    radius: 34

                    color: "#F4EEDD"

                    Text {
                        anchors.centerIn: parent

                        text: screen04Root.weekCount

                        color: "#18202A"

                        font.pixelSize: 30
                        font.bold: true
                    }
                }

                Text {
                    x: 94
                    y: 27

                    text: screen04Root.romanian ? "SĂPT." : "WEEK"

                    color: "#8B8F8B"

                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                Text {
                    x: 94
                    y: 48

                    width: 50

                    text: screen04Root.romanian ? "lucruri\nfăcute" : "things\ndone"

                    color: "#18202A"

                    font.pixelSize: 12
                    font.bold: true

                    wrapMode: Text.WordWrap
                }
            }

            // =================================================
            // STREAK
            // =================================================
            Rectangle {
                x: 28
                y: 226

                width: 334
                height: 72

                radius: 24

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                Item {
                    x: 15
                    y: 10

                    width: 52
                    height: 52

                    Rectangle {
                        anchors.centerIn: parent

                        width: 52
                        height: 52

                        radius: 26

                        color: "#FBEDE4"
                    }

                    Rectangle {
                        anchors.centerIn: parent

                        width: 34
                        height: 34

                        radius: 17

                        color: "#FFFDFC"
                    }

                    Rectangle {
                        anchors.centerIn: parent

                        width: 10
                        height: 10

                        radius: 5

                        color: "#F2A889"
                    }
                }

                Text {
                    x: 82
                    y: 13

                    text: screen04Root.romanian ? "SERIE CURENTĂ" : "CURRENT STREAK"

                    color: "#8B8F8B"

                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                Text {
                    x: 82
                    y: 31

                    text: screen04Root.streakCount + (screen04Root.romanian ? (screen04Root.streakCount === 1 ? " zi" : " zile") : (screen04Root.streakCount === 1 ? " day" : " days"))

                    color: "#18202A"

                    font.pixelSize: 21
                    font.bold: true
                }

                Rectangle {
                    x: 247
                    y: 14

                    width: 70
                    height: 44

                    radius: 22

                    color: "#EDF3EE"

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        y: 5

                        text: "TOTAL"

                        color: "#8B8F8B"

                        font.pixelSize: 8
                        font.bold: true
                        font.letterSpacing: 1
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        y: 17

                        text: screen04Root.totalCount

                        color: "#18202A"

                        font.pixelSize: 19
                        font.bold: true
                    }
                }
            }

            // =================================================
            // INSIGHT CARD
            // =================================================
            Rectangle {
                id: insightCard

                x: 28
                y: 316

                width: 334
                height: 120

                radius: 26

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                // SOFT ACCENT GLOW
                Rectangle {
                    width: 116
                    height: 116

                    x: 255
                    y: -29

                    radius: 58

                    color: screen04Root.insightAccent

                    opacity: 0.18
                }

                // ACCENT LINE
                Rectangle {
                    x: 18
                    y: 18

                    width: 4
                    height: 84

                    radius: 2

                    color: screen04Root.insightAccent
                }

                // LABEL
                Text {
                    x: 36
                    y: 17

                    text: screen04Root.romanian ? "OBSERVAȚIE" : "INSIGHT"

                    color: screen04Root.insightAccent

                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: 1.3
                }

                // TITLE
                Text {
                    x: 36
                    y: 38

                    width: 245
                    height: 34

                    text: screen04Root.insightTitle

                    color: "#18202A"

                    font.pixelSize: 16
                    font.bold: true

                    wrapMode: Text.WordWrap

                    maximumLineCount: 2
                }

                // BODY
                Text {
                    x: 36
                    y: 76

                    width: 260
                    height: 34

                    text: screen04Root.insightBody

                    color: "#6F746F"

                    font.pixelSize: 11

                    wrapMode: Text.WordWrap

                    maximumLineCount: 2
                }

                // ACCENT ORBIT
                Item {
                    x: 282
                    y: 21

                    width: 34
                    height: 34

                    Rectangle {
                        anchors.centerIn: parent

                        width: 34
                        height: 34

                        radius: 17

                        color: screen04Root.insightAccent

                        opacity: 0.22
                    }

                    Rectangle {
                        anchors.centerIn: parent

                        width: 20
                        height: 20

                        radius: 10

                        color: "#FFFDFC"
                    }

                    Rectangle {
                        anchors.centerIn: parent

                        width: 7
                        height: 7

                        radius: 3.5

                        color: screen04Root.insightAccent
                    }
                }
            }

            // =================================================
            // LAST 7 DAYS TITLE
            // =================================================
            Text {
                x: 28
                y: 470

                text: screen04Root.romanian ? "ULTIMELE 7 ZILE" : "LAST 7 DAYS"

                color: "#8B8F8B"

                font.pixelSize: 10
                font.bold: true
                font.letterSpacing: 1.4
            }

            // =================================================
            // 7 DAY CHART
            // =================================================
            Rectangle {
                x: 28
                y: 500

                width: 334
                height: 190

                radius: 26

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                Text {
                    x: 18
                    y: 14

                    text: screen04Root.romanian ? "Ritmul tău recent" : "Your recent rhythm"

                    color: "#18202A"

                    font.pixelSize: 13
                    font.bold: true
                }

                Text {
                    x: 18
                    y: 35

                    text: screen04Root.romanian ? "Nu trebuie să fie perfect." : "It doesn’t have to be perfect."

                    color: "#8B8F8B"

                    font.pixelSize: 10
                }

                Rectangle {
                    x: 18
                    y: 143

                    width: 298
                    height: 1

                    color: "#E5E2DC"
                }

                Row {
                    x: 14
                    y: 61

                    spacing: 7

                    Repeater {
                        model: screen04Root.last7Days

                        Item {
                            required property var modelData

                            width: 38
                            height: 112

                            Rectangle {
                                width: 22

                                height: Math.max(
                                            6,
                                            (78 * modelData.count / Math.max(
                                                 1,
                                                 screen04Root.chartMaxCount)))

                                anchors.horizontalCenter: parent.horizontalCenter

                                anchors.bottom: parent.bottom

                                anchors.bottomMargin: 24

                                radius: 11

                                color: modelData.count > 0 ? "#A9C7B0" : "#ECE9E3"

                                Behavior on height {
                                    NumberAnimation {
                                        duration: 380

                                        easing.type: Easing.OutCubic
                                    }
                                }

                                Rectangle {
                                    visible: modelData.count > 0

                                    width: 6
                                    height: 6

                                    anchors.horizontalCenter: parent.horizontalCenter

                                    y: 6

                                    radius: 3

                                    color: "#FFFDFC"

                                    opacity: 0.82
                                }
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter

                                y: 0

                                text: modelData.count > 0 ? modelData.count : ""

                                color: "#6F746F"

                                font.pixelSize: 9
                                font.bold: true
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter

                                y: 91

                                text: modelData.weekday === 0 ? (screen04Root.romanian ? "D" : "S") : modelData.weekday === 1 ? (screen04Root.romanian ? "L" : "M") : modelData.weekday === 2 ? (screen04Root.romanian ? "M" : "T") : modelData.weekday === 3 ? (screen04Root.romanian ? "Mi" : "W") : modelData.weekday === 4 ? (screen04Root.romanian ? "J" : "T") : modelData.weekday === 5 ? (screen04Root.romanian ? "V" : "F") : "S"

                                color: "#8B8F8B"

                                font.pixelSize: 9
                                font.bold: true
                            }
                        }
                    }
                }
            }

            // =================================================
            // CATEGORY TITLE
            // =================================================
            Text {
                x: 28
                y: 728

                text: screen04Root.romanian ? "PE CATEGORII" : "BY CATEGORY"

                color: "#8B8F8B"

                font.pixelSize: 10
                font.bold: true
                font.letterSpacing: 1.4
            }

            // =================================================
            // CATEGORY GRID
            // =================================================
            Grid {
                x: 28
                y: 758

                columns: 3

                columnSpacing: 12
                rowSpacing: 12

                // HOME
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#F2A889"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: screen04Root.romanian ? "Acasă" : "Home"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.homeCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }

                // BODY
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#A9C7B0"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: screen04Root.romanian ? "Corp" : "Body"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.bodyCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }

                // MIND
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#C9DDE5"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: screen04Root.romanian ? "Minte" : "Mind"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.mindCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }

                // MONEY
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#D8C8A8"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: screen04Root.romanian ? "Bani" : "Money"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.moneyCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }

                // WORK
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#C7C3D8"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: screen04Root.romanian ? "Muncă" : "Work"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.workCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }

                // SOCIAL
                Rectangle {
                    width: 103
                    height: 72

                    radius: 18

                    color: "#FFFDFC"

                    border.color: "#E3DDD5"
                    border.width: 1

                    Rectangle {
                        width: 8
                        height: 8

                        x: 13
                        y: 14

                        radius: 4

                        color: "#E5BFC1"
                    }

                    Text {
                        x: 28
                        y: 10

                        text: "Social"

                        color: "#6F746F"

                        font.pixelSize: 11
                    }

                    Text {
                        x: 13
                        y: 34

                        text: screen04Root.socialCount

                        color: "#18202A"

                        font.pixelSize: 22
                        font.bold: true
                    }
                }
            }

            // =================================================
            // RECENT TITLE
            // =================================================
            Text {
                x: 28
                y: 942

                text: screen04Root.romanian ? "RECENTE" : "RECENT"

                color: "#8B8F8B"

                font.pixelSize: 10
                font.bold: true
                font.letterSpacing: 1.4
            }

            // =================================================
            // EMPTY HISTORY
            // =================================================
            Rectangle {
                visible: screen04Root.recentItems.length === 0

                x: 28
                y: 972

                width: 334
                height: 120

                radius: 24

                color: "#FFFDFC"

                border.color: "#D8D9D6"
                border.width: 1

                Text {
                    anchors.centerIn: parent

                    width: 250

                    text: screen04Root.romanian ? "Nimic încă. Primul lucru mic va apărea aici." : "Nothing yet. Your first small thing will appear here."

                    color: "#6F746F"

                    font.pixelSize: 13

                    horizontalAlignment: Text.AlignHCenter

                    wrapMode: Text.WordWrap
                }
            }

            // =================================================
            // RECENT LIST
            // =================================================
            Column {
                x: 28
                y: 972

                width: 334

                spacing: 10

                Repeater {
                    model: screen04Root.recentItems

                    Rectangle {
                        required property var modelData

                        width: 334
                        height: 82

                        radius: 20

                        color: "#FFFDFC"

                        border.color: "#D8D9D6"
                        border.width: 1

                        Rectangle {
                            width: 34
                            height: 34

                            x: 14
                            y: 14

                            radius: 17

                            color: modelData.category === "Home" ? "#FBEDE4" : modelData.category === "Body" ? "#EAF3EC" : modelData.category === "Mind" ? "#EAF3F6" : modelData.category === "Money" ? "#F4EEDD" : modelData.category === "Work" ? "#EFEDF4" : "#F6E9EA"

                            Text {
                                anchors.centerIn: parent

                                text: "✓"

                                color: "#555D63"

                                font.pixelSize: 16
                                font.bold: true
                            }
                        }

                        Text {
                            x: 60
                            y: 12

                            width: 245
                            height: 38

                            text: modelData.text

                            color: "#18202A"

                            font.pixelSize: 13
                            font.bold: true

                            wrapMode: Text.WordWrap

                            elide: Text.ElideRight

                            maximumLineCount: 2
                        }

                        Text {
                            x: 60
                            y: 56

                            text: modelData.meta

                            color: "#8B8F8B"

                            font.pixelSize: 10
                        }

                        Rectangle {
                            visible: modelData.easy

                            x: 278
                            y: 54

                            width: 42
                            height: 18

                            radius: 9

                            color: "#EDF3EE"

                            Text {
                                anchors.centerIn: parent

                                text: screen04Root.romanian ? "ușor" : "easy"

                                color: "#6F746F"

                                font.pixelSize: 9
                                font.bold: true
                            }
                        }
                    }
                }
            }
        }
    }
}
