import QtQuick
import QtQuick.Controls
import Reset

Rectangle {
    id: screen05Root

    property bool romanian: false
    property string selectedContext: "Any"
    property int totalCount: 0

    property bool confirmReset: false

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
        width: 330
        height: 330

        x: 210
        y: 90

        radius: 165

        color: "#C9DDE5"
        opacity: 0.13
    }


    Rectangle {
        width: 290
        height: 290

        x: -175
        y: 560

        radius: 145

        color: "#A9C7B0"
        opacity: 0.14
    }


    Rectangle {
        width: 245
        height: 145

        x: 185
        y: 500

        radius: 72
        rotation: -20

        color: "transparent"

        border.color: "#F2A889"
        border.width: 1

        opacity: 0.17
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
            x: 7
            y: 7

            width: 34
            height: 34

            radius: 17

            scale: screen05Root.pressedControl === "Back"
                   ? 0.94
                   : screen05Root.hoverControl === "Back"
                     ? 1.04
                     : 1.0

            color: screen05Root.hoverControl === "Back"
                   ? "#F1EEE8"
                   : "#F7F4EE"


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

                color: screen05Root.romanian
                       ? "transparent"
                       : "#FFFDFC"


                Text {
                    anchors.centerIn: parent

                    text: "EN"

                    color: screen05Root.romanian
                           ? "#6F746F"
                           : "#18202A"

                    font.pixelSize: 12
                    font.bold: !screen05Root.romanian
                }
            }


            Rectangle {
                x: 36

                width: 36
                height: 32

                radius: 16

                color: screen05Root.romanian
                       ? "#FFFDFC"
                       : "transparent"


                Text {
                    anchors.centerIn: parent

                    text: "RO"

                    color: screen05Root.romanian
                           ? "#18202A"
                           : "#6F746F"

                    font.pixelSize: 12
                    font.bold: screen05Root.romanian
                }
            }
        }
    }


    // =========================================================
    // TITLE
    // =========================================================

    Text {
        x: 28
        y: 100

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "Setări"
              : "Settings"

        color: "#18202A"

        font.pixelSize: 30
        font.bold: true
    }


    Text {
        x: 28
        y: 143

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "Câteva preferințe. Nimic complicat."
              : "A few preferences. Nothing complicated."

        color: "#6F746F"

        font.pixelSize: 14
    }


    // =========================================================
    // LANGUAGE
    // =========================================================

    Text {
        x: 28
        y: 190

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "LIMBĂ"
              : "LANGUAGE"

        color: "#8B8F8B"

        font.pixelSize: 10
        font.bold: true
        font.letterSpacing: 1.4
    }


    Rectangle {
        x: 28
        y: 214

        width: 334
        height: 92

        radius: 24

        opacity: screen05Root.contentReveal

        color: "#FFFDFC"

        border.color: "#D8D9D6"
        border.width: 1


        Rectangle {
            x: 17
            y: 24

            width: 300
            height: 44

            radius: 22

            color: "#EFECE6"


            Rectangle {
                width: 150
                height: 44

                radius: 22

                color: !screen05Root.romanian
                       ? "#FFFDFC"
                       : "transparent"

                border.color: !screen05Root.romanian
                              ? "#D8D9D6"
                              : "transparent"

                border.width: 1


                Text {
                    anchors.centerIn: parent

                    text: "English"

                    color: !screen05Root.romanian
                           ? "#18202A"
                           : "#6F746F"

                    font.pixelSize: 13
                    font.bold: !screen05Root.romanian
                }
            }


            Rectangle {
                x: 150

                width: 150
                height: 44

                radius: 22

                color: screen05Root.romanian
                       ? "#FFFDFC"
                       : "transparent"

                border.color: screen05Root.romanian
                              ? "#D8D9D6"
                              : "transparent"

                border.width: 1


                Text {
                    anchors.centerIn: parent

                    text: "Română"

                    color: screen05Root.romanian
                           ? "#18202A"
                           : "#6F746F"

                    font.pixelSize: 13
                    font.bold: screen05Root.romanian
                }
            }
        }
    }


    // =========================================================
    // DEFAULT PLACE
    // =========================================================

    Text {
        x: 28
        y: 335

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "LOC IMPLICIT"
              : "DEFAULT PLACE"

        color: "#8B8F8B"

        font.pixelSize: 10
        font.bold: true
        font.letterSpacing: 1.4
    }


    Rectangle {
        x: 28
        y: 359

        width: 334
        height: 110

        radius: 24

        opacity: screen05Root.contentReveal

        color: "#FFFDFC"

        border.color: "#D8D9D6"
        border.width: 1


        Text {
            x: 17
            y: 14

            text: screen05Root.romanian
                  ? "Task-urile vor porni de aici."
                  : "Tasks will start from here."

            color: "#6F746F"

            font.pixelSize: 11
        }


        Rectangle {
            x: 17
            y: 48

            width: 300
            height: 44

            radius: 22

            color: "#EFECE6"


            Repeater {
                model: ["Any", "Home", "Desk", "Outside"]


                Rectangle {
                    required property string modelData
                    required property int index

                    x: index * 75

                    width: 75
                    height: 44

                    radius: 22

                    color: screen05Root.selectedContext === modelData
                           ? "#FFFDFC"
                           : "transparent"

                    border.color: screen05Root.selectedContext === modelData
                                  ? "#D8D9D6"
                                  : "transparent"

                    border.width: 1


                    Text {
                        anchors.centerIn: parent

                        text: modelData === "Any"
                              ? (
                                    screen05Root.romanian
                                    ? "Oriunde"
                                    : "Any"
                                )
                              : modelData === "Home"
                                ? (
                                      screen05Root.romanian
                                      ? "Acasă"
                                      : "Home"
                                  )
                                : modelData === "Desk"
                                  ? (
                                        screen05Root.romanian
                                        ? "Birou"
                                        : "Desk"
                                    )
                                  : (
                                        screen05Root.romanian
                                        ? "Afară"
                                        : "Outside"
                                    )

                        color: screen05Root.selectedContext === modelData
                               ? "#18202A"
                               : "#6F746F"

                        font.pixelSize: 10
                        font.bold: screen05Root.selectedContext === modelData
                    }
                }
            }
        }
    }


    // =========================================================
    // SMART BEHAVIOR
    // =========================================================

    Text {
        x: 28
        y: 505

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "COMPORTAMENT SMART"
              : "SMART BEHAVIOR"

        color: "#8B8F8B"

        font.pixelSize: 10
        font.bold: true
        font.letterSpacing: 1.4
    }


    Rectangle {
        x: 28
        y: 529

        width: 334
        height: 95

        radius: 24

        opacity: screen05Root.contentReveal

        color: "#FFFDFC"

        border.color: "#D8D9D6"
        border.width: 1


        Rectangle {
            x: 16
            y: 16

            width: 30
            height: 30

            radius: 15

            color: "#EAF3F6"


            Text {
                anchors.centerIn: parent

                text: "↗"

                color: "#555D63"

                font.pixelSize: 16
                font.bold: true
            }
        }


        Text {
            x: 58
            y: 14

            text: screen05Root.romanian
                  ? "Timpul se adaptează la energie"
                  : "Time adapts to your energy"

            color: "#18202A"

            font.pixelSize: 12
            font.bold: true
        }


        Text {
            x: 58
            y: 35

            text: screen05Root.romanian
                  ? "1–2: ≤5 min · 3: ≤10 min · 4–5: oricât"
                  : "1–2: ≤5 min · 3: ≤10 min · 4–5: any time"

            color: "#6F746F"

            font.pixelSize: 10
        }


        Rectangle {
            x: 16
            y: 58

            width: 30
            height: 22

            radius: 11

            color: "#EDF3EE"


            Text {
                anchors.centerIn: parent

                text: "4"

                color: "#555D63"

                font.pixelSize: 11
                font.bold: true
            }
        }


        Text {
            x: 58
            y: 61

            text: screen05Root.romanian
                  ? "Evită ultimele 4 task-uri terminate"
                  : "Avoids your last 4 completed tasks"

            color: "#6F746F"

            font.pixelSize: 10
        }
    }


    // =========================================================
    // DATA
    // =========================================================

    Text {
        x: 28
        y: 660

        opacity: screen05Root.contentReveal

        text: screen05Root.romanian
              ? "DATE"
              : "DATA"

        color: "#8B8F8B"

        font.pixelSize: 10
        font.bold: true
        font.letterSpacing: 1.4
    }


    Rectangle {
        x: 28
        y: 684

        width: 334
        height: 130

        radius: 24

        opacity: screen05Root.contentReveal

        color: "#FFFDFC"

        border.color: screen05Root.confirmReset
                      ? "#E5BFC1"
                      : "#D8D9D6"

        border.width: screen05Root.confirmReset
                      ? 2
                      : 1


        Text {
            x: 18
            y: 15

            text: screen05Root.romanian
                  ? "ISTORIC SALVAT"
                  : "SAVED HISTORY"

            color: "#8B8F8B"

            font.pixelSize: 9
            font.bold: true
            font.letterSpacing: 1.1
        }


        Text {
            x: 18
            y: 34

            text: screen05Root.totalCount
                  + (
                        screen05Root.romanian
                        ? " lucruri terminate"
                        : " completed things"
                    )

            color: "#18202A"

            font.pixelSize: 15
            font.bold: true
        }


        Rectangle {
            x: 18
            y: 72

            width: 298
            height: 44

            radius: 22

            scale: screen05Root.pressedControl === "Reset"
                   ? 0.985
                   : screen05Root.hoverControl === "Reset"
                     ? 1.01
                     : 1.0

            color: screen05Root.confirmReset
                   ? "#F7E8E8"
                   : screen05Root.hoverControl === "Reset"
                     ? "#F7F4EE"
                     : "#FFFDFC"

            border.color: screen05Root.confirmReset
                          ? "#D79C9F"
                          : "#D8D9D6"

            border.width: 1


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

                text: screen05Root.confirmReset
                      ? (
                            screen05Root.romanian
                            ? "Apasă din nou pentru ștergere"
                            : "Tap again to erase"
                        )
                      : (
                            screen05Root.romanian
                            ? "Șterge istoricul"
                            : "Reset history"
                        )

                color: screen05Root.confirmReset
                       ? "#8A474B"
                       : "#555D63"

                font.pixelSize: 12
                font.bold: screen05Root.confirmReset
            }
        }
    }
}
