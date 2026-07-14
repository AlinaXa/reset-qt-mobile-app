import QtQuick
import QtQuick.Controls
import Reset

Rectangle {
    id: screen03Root

    property bool romanian: false
    property string selectedCategory: "Home"
    property int energyLevel: 3

    property string actionText: romanian ? "Pune la loc 3 obiecte." : "Put away 3 objects."

    property string actionDetail: romanian ? "Atât este suficient pentru acum." : "That’s enough for now."

    property int actionMinutes: 5
    property string actionContext: "Anywhere"

    property int maxMinutes: 10
    property string selectedContext: "Any"

    property bool timerMode: false
    property bool timerPaused: false
    property bool completed: false

    property int secondsLeft: 300
    property string timerText: "05:00"

    property string hoverControl: ""
    property string pressedControl: ""

    property real actionReveal: 1.0
    property real timerReveal: 1.0
    property real completeReveal: 1.0

    property string categoryLabel: selectedCategory === "Home" ? (romanian ? "Acasă" : "Home") : selectedCategory === "Body" ? (romanian ? "Corp" : "Body") : selectedCategory === "Mind" ? (romanian ? "Minte" : "Mind") : selectedCategory === "Money" ? (romanian ? "Bani" : "Money") : selectedCategory === "Work" ? (romanian ? "Muncă" : "Work") : "Social"

    property string timeFilterLabel: maxMinutes <= 0 ? (romanian ? "Oricât" : "Any time") : "≤ "
                                                       + maxMinutes + " min"

    property string contextFilterLabel: selectedContext === "Any" ? (romanian ? "Oriunde" : "Anywhere") : selectedContext === "Home" ? (romanian ? "Acasă" : "Home") : selectedContext === "Desk" ? (romanian ? "La birou" : "Desk") : selectedContext === "Outside" ? (romanian ? "Afară" : "Outside") : selectedContext

    property string actionContextLabel: actionContext === "Anywhere" ? (romanian ? "oriunde" : "anywhere") : actionContext === "Home" ? (romanian ? "acasă" : "home") : actionContext === "Desk" ? (romanian ? "la birou" : "desk") : actionContext === "Outside" ? (romanian ? "afară" : "outside") : actionContext

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

        x: 220
        y: 130

        radius: 175

        color: "#C9DDE5"
        opacity: 0.16
    }

    Rectangle {
        width: 320
        height: 320

        x: -190
        y: 420

        radius: 160

        color: "#A9C7B0"
        opacity: 0.17
    }

    Rectangle {
        width: 260
        height: 150

        x: 170
        y: 380

        radius: 75
        rotation: -24

        color: "transparent"

        border.color: "#F2A889"
        border.width: 1

        opacity: 0.22
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

        Rectangle {
            id: backControl

            x: 7
            y: 7

            width: 34
            height: 34

            radius: 17

            scale: screen03Root.pressedControl
                   === "Back" ? 0.94 : screen03Root.hoverControl === "Back" ? 1.04 : 1.0

            color: screen03Root.hoverControl === "Back" ? "#F1EEE8" : "#F7F4EE"

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

                color: screen03Root.romanian ? "transparent" : "#FFFDFC"

                Text {
                    anchors.centerIn: parent

                    text: "EN"

                    color: screen03Root.romanian ? "#6F746F" : "#18202A"

                    font.pixelSize: 12
                    font.bold: !screen03Root.romanian
                }
            }

            Rectangle {
                x: 36

                width: 36
                height: 32

                radius: 16

                color: screen03Root.romanian ? "#FFFDFC" : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: "RO"

                    color: screen03Root.romanian ? "#18202A" : "#6F746F"

                    font.pixelSize: 12
                    font.bold: screen03Root.romanian
                }
            }
        }
    }

    // =========================================================
    // TITLE
    // =========================================================
    Text {
        x: 28
        y: 104

        text: screen03Root.romanian ? "Un singur lucru." : "One small thing."

        color: "#18202A"

        font.pixelSize: 29
        font.bold: true
    }

    Text {
        x: 28
        y: 147

        text: screen03Root.romanian ? "Nu trebuie să rezolvi tot." : "You don’t have to fix everything."

        color: "#6F746F"

        font.pixelSize: 14
    }

    // =========================================================
    // CATEGORY + ENERGY
    // =========================================================
    Rectangle {
        x: 28
        y: 184

        width: 334
        height: 44

        radius: 22

        color: "#FFFDFC"

        border.color: "#D8D9D6"
        border.width: 1

        Rectangle {
            width: 8
            height: 8

            x: 16
            y: 18

            radius: 4

            color: screen03Root.selectedCategory
                   === "Home" ? "#F2A889" : screen03Root.selectedCategory
                                === "Body" ? "#A9C7B0" : screen03Root.selectedCategory
                                             === "Mind" ? "#C9DDE5" : screen03Root.selectedCategory === "Money" ? "#D8C8A8" : screen03Root.selectedCategory === "Work" ? "#C7C3D8" : "#E5BFC1"
        }

        Text {
            x: 34
            y: 13

            text: screen03Root.categoryLabel

            color: "#18202A"

            font.pixelSize: 14
            font.bold: true
        }

        Rectangle {
            x: 230
            y: 11

            width: 88
            height: 22

            radius: 11

            color: "#F4F1EB"

            Text {
                anchors.centerIn: parent

                text: screen03Root.romanian ? "energie " + screen03Root.energyLevel
                                              + "/5" : "energy " + screen03Root.energyLevel + "/5"

                color: "#6F746F"

                font.pixelSize: 11
            }
        }
    }

    // =========================================================
    // ACTION STATE
    // =========================================================
    Item {
        visible: !screen03Root.timerMode && !screen03Root.completed

        width: parent.width
        height: parent.height

        // =====================================================
        // TIME FILTER
        // =====================================================
        Rectangle {
            id: timeFilterControl

            x: 30
            y: 242

            width: 155
            height: 42

            radius: 21

            opacity: screen03Root.actionReveal

            color: screen03Root.hoverControl === "TimePrev"
                   || screen03Root.hoverControl === "TimeNext" ? "#F9F6F0" : "#FFFDFC"

            border.color: "#D8D9D6"
            border.width: 1

            Rectangle {
                width: 30
                height: 30

                x: 6
                y: 6

                radius: 15

                scale: screen03Root.pressedControl === "TimePrev" ? 0.90 : 1.0

                color: screen03Root.hoverControl === "TimePrev" ? "#EEEAE3" : "transparent"

                Behavior on scale {
                    NumberAnimation {
                        duration: 120
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: "‹"

                    color: "#555D63"

                    font.pixelSize: 20
                }
            }

            Item {
                x: 36
                y: 4

                width: 83
                height: 34

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    y: 2

                    text: "TIME"

                    color: "#8B8F8B"

                    font.pixelSize: 8
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    y: 15

                    text: screen03Root.timeFilterLabel

                    color: "#18202A"

                    font.pixelSize: 12
                    font.bold: true
                }
            }

            Rectangle {
                width: 30
                height: 30

                x: 119
                y: 6

                radius: 15

                scale: screen03Root.pressedControl === "TimeNext" ? 0.90 : 1.0

                color: screen03Root.hoverControl === "TimeNext" ? "#EEEAE3" : "transparent"

                Behavior on scale {
                    NumberAnimation {
                        duration: 120
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: "›"

                    color: "#555D63"

                    font.pixelSize: 20
                }
            }
        }

        // =====================================================
        // PLACE FILTER
        // =====================================================
        Rectangle {
            id: placeFilterControl

            x: 205
            y: 242

            width: 155
            height: 42

            radius: 21

            opacity: screen03Root.actionReveal

            color: screen03Root.hoverControl === "PlacePrev"
                   || screen03Root.hoverControl === "PlaceNext" ? "#F9F6F0" : "#FFFDFC"

            border.color: "#D8D9D6"
            border.width: 1

            Rectangle {
                width: 30
                height: 30

                x: 6
                y: 6

                radius: 15

                scale: screen03Root.pressedControl === "PlacePrev" ? 0.90 : 1.0

                color: screen03Root.hoverControl === "PlacePrev" ? "#EEEAE3" : "transparent"

                Behavior on scale {
                    NumberAnimation {
                        duration: 120
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: "‹"

                    color: "#555D63"

                    font.pixelSize: 20
                }
            }

            Item {
                x: 36
                y: 4

                width: 83
                height: 34

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    y: 2

                    text: screen03Root.romanian ? "LOC" : "PLACE"

                    color: "#8B8F8B"

                    font.pixelSize: 8
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                Text {
                    width: parent.width

                    y: 15

                    text: screen03Root.contextFilterLabel

                    color: "#18202A"

                    font.pixelSize: 12
                    font.bold: true

                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                }
            }

            Rectangle {
                width: 30
                height: 30

                x: 119
                y: 6

                radius: 15

                scale: screen03Root.pressedControl === "PlaceNext" ? 0.90 : 1.0

                color: screen03Root.hoverControl === "PlaceNext" ? "#EEEAE3" : "transparent"

                Behavior on scale {
                    NumberAnimation {
                        duration: 120
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: "›"

                    color: "#555D63"

                    font.pixelSize: 20
                }
            }
        }

        // =====================================================
        // ACTION CIRCLE
        // =====================================================
        Rectangle {
            id: actionPlate

            width: 260
            height: 260

            anchors.horizontalCenter: parent.horizontalCenter

            y: 296 + ((1.0 - screen03Root.actionReveal) * 14)

            opacity: screen03Root.actionReveal
            scale: 0.97 + (screen03Root.actionReveal * 0.03)

            radius: 130

            color: "#FFFDFC"

            border.color: "#D8D9D6"
            border.width: 1

            Rectangle {
                width: 232
                height: 232

                anchors.centerIn: parent

                radius: 116

                color: screen03Root.selectedCategory
                       === "Home" ? "#FBEDE4" : screen03Root.selectedCategory
                                    === "Body" ? "#EAF3EC" : screen03Root.selectedCategory === "Mind" ? "#EAF3F6" : screen03Root.selectedCategory === "Money" ? "#F4EEDD" : screen03Root.selectedCategory === "Work" ? "#EFEDF4" : "#F6E9EA"
            }

            Rectangle {
                width: 202
                height: 202

                anchors.centerIn: parent

                radius: 101

                color: "transparent"

                border.color: "#FFFFFF"
                border.width: 1

                opacity: 0.75
            }

            Rectangle {
                width: 9
                height: 9

                anchors.horizontalCenter: parent.horizontalCenter

                y: 13

                radius: 4.5

                color: "#F2A889"
            }

            Rectangle {
                width: 118
                height: 24

                anchors.horizontalCenter: parent.horizontalCenter

                y: 34

                radius: 12

                color: "#FFFDFC"
                opacity: 0.78

                Text {
                    anchors.centerIn: parent

                    text: screen03Root.actionMinutes + " min  ·  " + screen03Root.actionContextLabel

                    color: "#6F746F"

                    font.pixelSize: 10
                }
            }

            Text {
                width: 204
                height: 100

                anchors.horizontalCenter: parent.horizontalCenter

                y: 70 + ((1.0 - screen03Root.actionReveal) * 8)

                opacity: screen03Root.actionReveal

                text: screen03Root.actionText

                color: "#18202A"

                font.pixelSize: 23
                minimumPixelSize: 17
                fontSizeMode: Text.Fit
                font.bold: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.WordWrap
            }

            Text {
                width: 200
                height: 48

                anchors.horizontalCenter: parent.horizontalCenter

                y: 177 + ((1.0 - screen03Root.actionReveal) * 5)

                opacity: screen03Root.actionReveal

                text: screen03Root.actionDetail

                color: "#6F746F"

                font.pixelSize: 12
                minimumPixelSize: 10
                fontSizeMode: Text.Fit

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop

                wrapMode: Text.WordWrap
            }
        }

        // =====================================================
        // START
        // =====================================================
        Rectangle {
            id: startControl

            width: 330
            height: 58

            x: 30
            y: 575

            radius: 29

            scale: screen03Root.pressedControl
                   === "Start" ? 0.985 : screen03Root.hoverControl === "Start" ? 1.012 : 1.0

            color: screen03Root.hoverControl === "Start" ? "#202A36" : "#18202A"

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

                text: screen03Root.romanian ? "Începe" : "Start"

                color: "#FFFDFC"

                font.pixelSize: 16
                font.bold: true
            }
        }

        // =====================================================
        // TOO MUCH
        // =====================================================
        Rectangle {
            id: easierControl

            x: 30
            y: 650

            width: 155
            height: 50

            radius: 25

            scale: screen03Root.pressedControl
                   === "Easier" ? 0.98 : screen03Root.hoverControl === "Easier" ? 1.015 : 1.0

            color: screen03Root.hoverControl === "Easier" ? "#F7F4EE" : "#FFFDFC"

            border.color: screen03Root.hoverControl === "Easier" ? "#BFC2C0" : "#D8D9D6"

            border.width: 1

            Behavior on scale {
                NumberAnimation {
                    duration: 140
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                anchors.centerIn: parent

                text: screen03Root.romanian ? "E prea mult" : "Too much"

                color: "#18202A"

                font.pixelSize: 14
            }
        }

        // =====================================================
        // ANOTHER
        // =====================================================
        Rectangle {
            id: anotherControl

            x: 205
            y: 650

            width: 155
            height: 50

            radius: 25

            scale: screen03Root.pressedControl
                   === "Another" ? 0.98 : screen03Root.hoverControl === "Another" ? 1.015 : 1.0

            color: screen03Root.hoverControl === "Another" ? "#F7F4EE" : "#FFFDFC"

            border.color: screen03Root.hoverControl === "Another" ? "#BFC2C0" : "#D8D9D6"

            border.width: 1

            Behavior on scale {
                NumberAnimation {
                    duration: 140
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                anchors.centerIn: parent

                text: screen03Root.romanian ? "Dă-mi altceva" : "Another one"

                color: "#18202A"

                font.pixelSize: 14
            }
        }
    }

    // =========================================================
    // TIMER STATE
    // =========================================================
    Item {
        visible: screen03Root.timerMode && !screen03Root.completed

        width: parent.width
        height: parent.height

        opacity: screen03Root.timerReveal

        Rectangle {
            width: 292
            height: 292

            anchors.horizontalCenter: parent.horizontalCenter

            y: 270 + ((1.0 - screen03Root.timerReveal) * 14)

            scale: 0.96 + (screen03Root.timerReveal * 0.04)

            radius: 146

            color: "#FFFDFC"

            border.color: "#D8D9D6"
            border.width: 1

            Rectangle {
                width: 252
                height: 252

                anchors.centerIn: parent

                radius: 126

                color: screen03Root.timerPaused ? "#EDF3EE" : "#EAF3F6"

                Behavior on color {
                    ColorAnimation {
                        duration: 220
                    }
                }
            }

            Rectangle {
                width: 220
                height: 220

                anchors.centerIn: parent

                radius: 110

                color: "transparent"

                border.color: "#FFFFFF"
                border.width: 1

                opacity: 0.70
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                y: 87

                text: screen03Root.timerText

                color: "#18202A"

                font.pixelSize: 56
                font.bold: true
            }

            Text {
                width: 220

                anchors.horizontalCenter: parent.horizontalCenter

                y: 164

                text: screen03Root.timerPaused ? (screen03Root.romanian ? "Timer în pauză" : "Timer paused") : screen03Root.actionText

                color: "#6F746F"

                font.pixelSize: 13

                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }

        Rectangle {
            id: pauseControl

            x: 30
            y: 650

            width: 155
            height: 56

            radius: 28

            scale: screen03Root.pressedControl
                   === "Pause" ? 0.98 : screen03Root.hoverControl === "Pause" ? 1.015 : 1.0

            color: screen03Root.timerPaused ? "#EDF3EE" : screen03Root.hoverControl
                                              === "Pause" ? "#F7F4EE" : "#FFFDFC"

            border.color: screen03Root.timerPaused ? "#A9C7B0" : "#D8D9D6"

            border.width: screen03Root.timerPaused ? 2 : 1

            Behavior on scale {
                NumberAnimation {
                    duration: 140
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 180
                }
            }

            Text {
                anchors.centerIn: parent

                text: screen03Root.timerPaused ? (screen03Root.romanian ? "Continuă" : "Resume") : (screen03Root.romanian ? "Pauză" : "Pause")

                color: "#18202A"

                font.pixelSize: 15
                font.bold: screen03Root.timerPaused
            }
        }

        Rectangle {
            id: doneControl

            x: 205
            y: 650

            width: 155
            height: 56

            radius: 28

            scale: screen03Root.pressedControl
                   === "Done" ? 0.98 : screen03Root.hoverControl === "Done" ? 1.015 : 1.0

            color: screen03Root.hoverControl === "Done" ? "#202A36" : "#18202A"

            Behavior on scale {
                NumberAnimation {
                    duration: 140
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Text {
                anchors.centerIn: parent

                text: screen03Root.romanian ? "Gata" : "Done"

                color: "#FFFDFC"

                font.pixelSize: 15
                font.bold: true
            }
        }
    }

    // =========================================================
    // COMPLETE STATE
    // =========================================================
    Item {
        visible: screen03Root.completed

        width: parent.width
        height: parent.height

        opacity: screen03Root.completeReveal

        Rectangle {
            width: 270
            height: 270

            anchors.horizontalCenter: parent.horizontalCenter

            y: 280 + ((1.0 - screen03Root.completeReveal) * 18)

            scale: 0.90 + (screen03Root.completeReveal * 0.10)

            radius: 135

            color: "#DCE7DE"

            Rectangle {
                width: 230
                height: 230

                anchors.centerIn: parent

                radius: 115

                color: "transparent"

                border.color: "#FFFDFC"
                border.width: 1

                opacity: 0.70
            }

            Rectangle {
                width: 202
                height: 202

                anchors.centerIn: parent

                radius: 101

                color: "#FFFDFC"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                y: 68

                text: "✓"

                color: "#8FB39A"

                font.pixelSize: 48
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                y: 130

                text: screen03Root.romanian ? "Bine." : "Nice."

                color: "#18202A"

                font.pixelSize: 27
                font.bold: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                y: 169

                text: screen03Root.romanian ? "Și asta contează." : "That counts."

                color: "#6F746F"

                font.pixelSize: 14
            }
        }
    }
}
