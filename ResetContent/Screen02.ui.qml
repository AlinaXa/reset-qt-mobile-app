import QtQuick
import QtQuick.Controls
import Reset

Rectangle {
    id: screen02Root

    property bool romanian: false
    property string selectedCategory: ""
    property string hoverCategory: ""
    property string pressedCategory: ""

    property real titleReveal: 1.0
    property real cardsReveal: 1.0
    property real buttonReveal: 1.0

    width: Constants.width
    height: Constants.height

    color: "#F7F1E8"
    clip: true

    // =========================================================
    // BACKGROUND ATMOSPHERE
    // =========================================================
    Rectangle {
        width: 350
        height: 350

        x: 215
        y: -120

        radius: 175

        color: "#C9DDE5"
        opacity: 0.18
    }

    Rectangle {
        width: 330
        height: 330

        x: -185
        y: 480

        radius: 165

        color: "#A9C7B0"
        opacity: 0.18
    }

    Rectangle {
        width: 260
        height: 260

        x: 205
        y: 295

        radius: 130

        color: "#F2A889"
        opacity: 0.065
    }

    Rectangle {
        width: 280
        height: 150

        x: 165
        y: 350

        radius: 75
        rotation: -26

        color: "transparent"

        border.color: "#D8D9D6"
        border.width: 1

        opacity: 0.30
    }

    // =========================================================
    // FLOATING TOP RAIL
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
            id: backControl

            x: 7
            y: 7

            width: 34
            height: 34

            radius: 17

            color: "#F7F4EE"

            border.color: "#E3E1DC"
            border.width: 1

            Text {
                anchors.centerIn: parent

                text: "‹"

                color: "#18202A"

                font.pixelSize: 25
            }
        }

        // LOGO
        Item {
            id: logoMark

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

        // LANGUAGE SWITCH
        Rectangle {
            id: languageSwitch

            x: 264
            y: 8

            width: 80
            height: 32

            radius: 16

            color: "#EFECE6"

            Rectangle {
                id: enControl

                x: 0
                y: 0

                width: 40
                height: 32

                radius: 16

                color: screen02Root.romanian ? "transparent" : "#FFFDFC"

                Text {
                    anchors.centerIn: parent

                    text: "EN"

                    color: screen02Root.romanian ? "#6F746F" : "#18202A"

                    font.pixelSize: 12
                    font.bold: !screen02Root.romanian
                }
            }

            Rectangle {
                id: roControl

                x: 40
                y: 0

                width: 40
                height: 32

                radius: 16

                color: screen02Root.romanian ? "#FFFDFC" : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: "RO"

                    color: screen02Root.romanian ? "#18202A" : "#6F746F"

                    font.pixelSize: 12
                    font.bold: screen02Root.romanian
                }
            }
        }
    }

    // =========================================================
    // TITLE
    // =========================================================
    Text {
        id: titleLabel

        x: 28
        y: 104 + ((1.0 - screen02Root.titleReveal) * 12)

        width: 334

        opacity: screen02Root.titleReveal

        text: screen02Root.romanian ? "Ce simți că te apasă\nacum?" : "What feels heavy\nright now?"

        color: "#18202A"

        font.pixelSize: 29
        font.bold: true

        lineHeight: 1.12
    }

    Text {
        id: subtitleLabel

        x: 28
        y: 179 + ((1.0 - screen02Root.titleReveal) * 8)

        opacity: screen02Root.titleReveal

        text: screen02Root.romanian ? "Alege o zonă. O păstrăm simplă." : "Pick one area. We’ll keep it small."

        color: "#6F746F"

        font.pixelSize: 14
    }

    // =========================================================
    // HOME
    // =========================================================
    Rectangle {
        id: homeControl

        x: 28
        y: 235 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Home" ? 0.985 : screen02Root.selectedCategory
                            === "Home" ? 1.025 : screen02Root.hoverCategory === "Home" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Home" ? "#FFF7F1" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Home" ? "#F2A889" : screen02Root.hoverCategory
                                   === "Home" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Home" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 76
            height: 76

            x: 91
            y: -13

            radius: 38

            color: "#F2A889"

            opacity: screen02Root.hoverCategory === "Home"
                     || screen02Root.selectedCategory === "Home" ? 0.22 : 0.14

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 2
            height: 32

            x: 17
            y: 20

            radius: 1

            color: "#F2A889"
        }

        Rectangle {
            width: 18
            height: 15

            x: 28
            y: 24

            radius: 2

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 13
            height: 13

            x: 30
            y: 17

            rotation: 45

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Home" ? "#F2A889" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: screen02Root.romanian ? "Acasă" : "Home"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // BODY
    // =========================================================
    Rectangle {
        id: bodyControl

        x: 207
        y: 235 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Body" ? 0.985 : screen02Root.selectedCategory
                            === "Body" ? 1.025 : screen02Root.hoverCategory === "Body" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Body" ? "#F4FAF5" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Body" ? "#A9C7B0" : screen02Root.hoverCategory
                                   === "Body" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Body" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 68
            height: 68

            x: -14
            y: 45

            radius: 34

            color: "#A9C7B0"

            opacity: screen02Root.hoverCategory === "Body"
                     || screen02Root.selectedCategory === "Body" ? 0.24 : 0.16

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 26
            height: 26

            x: 24
            y: 18

            radius: 13

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 2
            height: 18

            x: 36
            y: 22

            radius: 1

            color: "#555D63"
        }

        Rectangle {
            width: 18
            height: 2

            x: 28
            y: 30

            radius: 1

            color: "#555D63"
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Body" ? "#A9C7B0" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: screen02Root.romanian ? "Corp" : "Body"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // MIND
    // =========================================================
    Rectangle {
        id: mindControl

        x: 28
        y: 358 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Mind" ? 0.985 : screen02Root.selectedCategory
                            === "Mind" ? 1.025 : screen02Root.hoverCategory === "Mind" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Mind" ? "#F3F9FB" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Mind" ? "#C9DDE5" : screen02Root.hoverCategory
                                   === "Mind" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Mind" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 95
            height: 48

            x: 72
            y: 8

            radius: 24

            color: "#C9DDE5"

            opacity: screen02Root.hoverCategory === "Mind"
                     || screen02Root.selectedCategory === "Mind" ? 0.27 : 0.18

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 28
            height: 20

            x: 23
            y: 22

            radius: 10

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 10
            height: 2

            x: 40
            y: 39

            rotation: 35

            radius: 1

            color: "#555D63"
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Mind" ? "#9CBFCD" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: screen02Root.romanian ? "Minte" : "Mind"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // MONEY
    // =========================================================
    Rectangle {
        id: moneyControl

        x: 207
        y: 358 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Money" ? 0.985 : screen02Root.selectedCategory
                             === "Money" ? 1.025 : screen02Root.hoverCategory
                                           === "Money" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Money" ? "#FAF7EF" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Money" ? "#D8C8A8" : screen02Root.hoverCategory
                                    === "Money" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Money" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 66
            height: 66

            x: 103
            y: 44

            radius: 33

            color: "#D8C8A8"

            opacity: screen02Root.hoverCategory === "Money"
                     || screen02Root.selectedCategory === "Money" ? 0.28 : 0.18

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 28
            height: 28

            x: 23
            y: 18

            radius: 14

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 2
            height: 15

            x: 36
            y: 24

            radius: 1

            color: "#555D63"
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Money" ? "#C4AA77" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: screen02Root.romanian ? "Bani" : "Money"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // WORK
    // =========================================================
    Rectangle {
        id: workControl

        x: 28
        y: 481 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Work" ? 0.985 : screen02Root.selectedCategory
                            === "Work" ? 1.025 : screen02Root.hoverCategory === "Work" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Work" ? "#F6F5F9" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Work" ? "#C7C3D8" : screen02Root.hoverCategory
                                   === "Work" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Work" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 78
            height: 45

            x: 75
            y: -3

            radius: 22

            color: "#C7C3D8"

            opacity: screen02Root.hoverCategory === "Work"
                     || screen02Root.selectedCategory === "Work" ? 0.28 : 0.18

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 30
            height: 22

            x: 22
            y: 23

            radius: 3

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 14
            height: 6

            x: 30
            y: 17

            radius: 3

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Work" ? "#9D96BA" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: screen02Root.romanian ? "Muncă" : "Work"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // SOCIAL
    // =========================================================
    Rectangle {
        id: socialControl

        x: 207
        y: 481 + ((1.0 - screen02Root.cardsReveal) * 12)

        width: 155
        height: 98

        opacity: screen02Root.cardsReveal

        radius: 20

        scale: screen02Root.pressedCategory
               === "Social" ? 0.985 : screen02Root.selectedCategory
                              === "Social" ? 1.025 : screen02Root.hoverCategory
                                             === "Social" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "Social" ? "#FAF5F6" : "#FFFDFC"

        border.color: screen02Root.selectedCategory
                      === "Social" ? "#E5BFC1" : screen02Root.hoverCategory
                                     === "Social" ? "#C7C9C6" : "#D8D9D6"

        border.width: screen02Root.selectedCategory === "Social" ? 2 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 145
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            width: 72
            height: 72

            x: -20
            y: 48

            radius: 36

            color: "#E5BFC1"

            opacity: screen02Root.hoverCategory === "Social"
                     || screen02Root.selectedCategory === "Social" ? 0.28 : 0.18

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        Rectangle {
            width: 18
            height: 18

            x: 22
            y: 20

            radius: 9

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 18
            height: 18

            x: 37
            y: 26

            radius: 9

            color: "transparent"

            border.color: "#555D63"
            border.width: 1
        }

        Rectangle {
            width: 7
            height: 7

            x: 132
            y: 14

            radius: 3.5

            color: screen02Root.selectedCategory === "Social" ? "#C99498" : "#A9ADAE"
        }

        Text {
            x: 18
            y: 63

            text: "Social"

            color: "#18202A"

            font.pixelSize: 17
            font.bold: true
        }
    }

    // =========================================================
    // BOTTOM TEXT
    // =========================================================
    Text {
        anchors.horizontalCenter: parent.horizontalCenter

        y: 690

        opacity: screen02Root.buttonReveal

        text: screen02Root.romanian ? "Câte un lucru pe rând." : "One thing at a time."

        color: "#6F746F"

        font.pixelSize: 13
    }

    // =========================================================
    // CONTINUE
    // =========================================================
    Rectangle {
        id: continueControl

        width: 330
        height: 58

        anchors.horizontalCenter: parent.horizontalCenter

        y: 756 + ((1.0 - screen02Root.buttonReveal) * 10)

        opacity: screen02Root.buttonReveal * (screen02Root.selectedCategory === "" ? 0.55 : 1.0)

        radius: 29

        scale: screen02Root.pressedCategory
               === "Continue" ? 0.985 : screen02Root.hoverCategory === "Continue" ? 1.012 : 1.0

        color: screen02Root.selectedCategory === "" ? "#A9ADAE" : "#18202A"

        Behavior on scale {
            NumberAnimation {
                duration: 140
                easing.type: Easing.OutCubic
            }
        }

        Text {
            anchors.centerIn: parent

            text: screen02Root.romanian ? "Arată-mi un lucru mic" : "Show me one small thing"

            color: "#FFFDFC"

            font.pixelSize: 16
            font.bold: true
        }
    }
}
