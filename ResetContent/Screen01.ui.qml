import QtQuick
import QtQuick.Controls
import Reset

Rectangle {
    id: root

    property int energyLevel: 3
    property bool romanian: false

    // Controlled later from App.qml
    property real titleReveal: 1.0
    property real subtitleReveal: 1.0
    property real dialReveal: 1.0

    width: Constants.width
    height: Constants.height

    color: "#F7F1E8"
    clip: true

    // =========================================================
    // BACKGROUND ATMOSPHERE
    // =========================================================
    Rectangle {
        width: 320
        height: 320

        x: -145
        y: 335

        radius: 160

        color: "#A9C7B0"
        opacity: 0.24
    }

    Rectangle {
        width: 360
        height: 360

        x: 215
        y: 195

        radius: 180

        color: "#C9DDE5"
        opacity: 0.18
    }

    Rectangle {
        width: 240
        height: 240

        x: 250
        y: 310

        radius: 46
        rotation: 45

        color: "transparent"

        border.color: "#F2A889"
        border.width: 1

        opacity: 0.24
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
        opacity: 0.82

        border.color: "#D8D9D6"
        border.width: 1

        // OPEN RING LOGO
        Item {
            id: logoMark

            x: 15
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

            // Cut in the ring
            Rectangle {
                width: 10
                height: 8

                x: 15
                y: 14

                color: "#FFFDFC"
            }

            // Position dot
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
            x: 49
            y: 16

            text: "RESET"

            color: "#18202A"

            font.pixelSize: 12
            font.letterSpacing: 2
            font.bold: true
        }

        // LANGUAGE SWITCH
        Rectangle {
            id: languageSwitch

            x: 264
            y: 8

            width: 72
            height: 32

            radius: 16

            color: "#EFECE6"

            Rectangle {
                id: enControl

                x: 0
                y: 0

                width: 36
                height: 32

                radius: 16

                color: root.romanian ? "transparent" : "#FFFDFC"

                Text {
                    anchors.centerIn: parent

                    text: "EN"

                    color: root.romanian ? "#6F746F" : "#18202A"

                    font.pixelSize: 12
                    font.bold: !root.romanian
                }
            }

            Rectangle {
                id: roControl

                x: 36
                y: 0

                width: 36
                height: 32

                radius: 16

                color: root.romanian ? "#FFFDFC" : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: "RO"

                    color: root.romanian ? "#18202A" : "#6F746F"

                    font.pixelSize: 12
                    font.bold: root.romanian
                }
            }
        }
    }

    // =========================================================
    // TITLE
    // =========================================================
    Text {
        id: textMainTitle

        x: 28
        y: 112 + ((1.0 - root.titleReveal) * 14)

        width: root.width - 56

        opacity: root.titleReveal

        text: root.romanian ? "Cum este energia ta\nazi?" : "How is your\nenergy today?"

        color: "#18202A"

        font.pixelSize: 30
        font.bold: true

        lineHeight: 1.15
    }

    Text {
        id: subtitleText

        x: 28
        y: 194 + ((1.0 - root.subtitleReveal) * 8)

        opacity: root.subtitleReveal

        text: root.romanian ? "Alege ce simți că se potrivește." : "Choose what feels closest."

        color: "#6F746F"

        font.pixelSize: 15
    }

    // =========================================================
    // ENERGY DIAL
    // =========================================================
    Item {
        id: energyDialContainer

        width: 250
        height: 250

        anchors.horizontalCenter: parent.horizontalCenter

        y: 255 + ((1.0 - root.dialReveal) * 12)

        opacity: root.dialReveal
        scale: 0.96 + (root.dialReveal * 0.04)

        // SHADOW
        Rectangle {
            width: 246
            height: 246

            x: 8
            y: 11

            radius: 123

            color: "#18202A"
            opacity: 0.07
        }

        // OUTER METALLIC RIM
        Rectangle {
            width: 250
            height: 250

            anchors.centerIn: parent

            radius: 125
            gradient: Gradient {
                GradientStop {
                    position: 0.89035
                    color: "#e7c9d4d9"
                }

                GradientStop {
                    position: 0.10965
                    color: "#86b7ca"
                }

                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.41228
                    color: "#bbdfed"
                }
            }
        }

        // INNER HIGHLIGHT
        Rectangle {
            width: 228
            height: 228

            anchors.centerIn: parent

            radius: 114

            color: "#FFFDFC"
        }

        // ENERGY SURFACE
        Rectangle {
            width: 196
            height: 196

            anchors.centerIn: parent

            radius: 98

            color: root.energyLevel === 1 ? "#E6E7E2" : root.energyLevel
                                            === 2 ? "#DFE7E2" : root.energyLevel
                                                    === 3 ? "#DCE7DE" : root.energyLevel
                                                            === 4 ? "#D4E4DA" : "#CCE0D4"
        }

        // INNER SUBTLE RING
        Rectangle {
            width: 174
            height: 174

            anchors.centerIn: parent

            radius: 87

            color: "transparent"

            border.color: "#FFFFFF"
            border.width: 1

            opacity: 0.55
        }

        // MOVING PEACH MARKER
        Rectangle {
            id: dialMarker

            width: 12
            height: 12

            x: root.energyLevel === 1 ? 36 : root.energyLevel
                                        === 2 ? 72 : root.energyLevel
                                                === 3 ? 119 : root.energyLevel === 4 ? 166 : 202

            y: root.energyLevel === 1 ? 57 : root.energyLevel
                                        === 2 ? 22 : root.energyLevel
                                                === 3 ? 7 : root.energyLevel === 4 ? 22 : 57

            radius: 6

            color: "#F2A889"

            border.color: "#FFFDFC"
            border.width: 2

            Behavior on x {
                NumberAnimation {
                    duration: 240
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: 240
                }
            }
        }

        // CENTER CONTENT
        Column {
            anchors.centerIn: parent

            spacing: 2

            Text {
                id: energyNumberText

                anchors.horizontalCenter: parent.horizontalCenter

                text: root.energyLevel

                color: "#18202A"

                font.pixelSize: 64
                font.bold: true
            }

            Text {
                id: energyLabelText

                anchors.horizontalCenter: parent.horizontalCenter

                text: root.energyLevel
                      === 1 ? (root.romanian ? "Gol" : "Empty") : root.energyLevel
                              === 2 ? (root.romanian ? "Scăzut" : "Low") : root.energyLevel
                                      === 3 ? (root.romanian ? "Stabil" : "Steady") : root.energyLevel === 4 ? (root.romanian ? "Bun" : "Good") : (root.romanian ? "Plin" : "Full")

                color: "#18202A"

                font.pixelSize: 17
                font.bold: true
            }

            Text {
                id: energyDescriptionText

                anchors.horizontalCenter: parent.horizontalCenter

                text: root.energyLevel === 1 ? (root.romanian ? "aproape fără energie" : "almost no energy") : root.energyLevel === 2 ? (root.romanian ? "mergi încet azi" : "taking it gently") : root.energyLevel === 3 ? (root.romanian ? "un mijloc confortabil" : "a comfortable middle") : root.energyLevel === 4 ? (root.romanian ? "ai energie bună" : "feeling capable") : (root.romanian ? "rezervorul e plin" : "fully charged")

                color: "#6F746F"

                font.pixelSize: 12
            }
        }
    }

    // =========================================================
    // ENERGY INDICATORS
    // =========================================================
    Row {
        id: energyIndicatorsRow

        height: 16

        anchors.horizontalCenter: parent.horizontalCenter

        y: 535

        spacing: 22

        Rectangle {
            id: energyPoint1

            width: root.energyLevel === 1 ? 15 : 9
            height: width

            anchors.verticalCenter: parent.verticalCenter

            radius: width / 2

            color: root.energyLevel === 1 ? "#F2A889" : "#FFFDFC"

            border.color: root.energyLevel === 1 ? "#F2A889" : "#B9CDD4"

            border.width: 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Rectangle {
            id: energyPoint2

            width: root.energyLevel === 2 ? 15 : 9
            height: width

            anchors.verticalCenter: parent.verticalCenter

            radius: width / 2

            color: root.energyLevel === 2 ? "#F2A889" : "#FFFDFC"

            border.color: root.energyLevel === 2 ? "#F2A889" : "#B9CDD4"

            border.width: 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Rectangle {
            id: energyPoint3

            width: root.energyLevel === 3 ? 15 : 9
            height: width

            anchors.verticalCenter: parent.verticalCenter

            radius: width / 2

            color: root.energyLevel === 3 ? "#F2A889" : "#FFFDFC"

            border.color: root.energyLevel === 3 ? "#F2A889" : "#B9CDD4"

            border.width: 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Rectangle {
            id: energyPoint4

            width: root.energyLevel === 4 ? 15 : 9
            height: width

            anchors.verticalCenter: parent.verticalCenter

            radius: width / 2

            color: root.energyLevel === 4 ? "#F2A889" : "#FFFDFC"

            border.color: root.energyLevel === 4 ? "#F2A889" : "#B9CDD4"

            border.width: 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Rectangle {
            id: energyPoint5

            width: root.energyLevel === 5 ? 15 : 9
            height: width

            anchors.verticalCenter: parent.verticalCenter

            radius: width / 2

            color: root.energyLevel === 5 ? "#F2A889" : "#FFFDFC"

            border.color: root.energyLevel === 5 ? "#F2A889" : "#B9CDD4"

            border.width: 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }
        }
    }

    // =========================================================
    // SUPPORT MESSAGE
    // =========================================================
    Rectangle {
        id: supportMessage

        width: 310
        height: 48

        anchors.horizontalCenter: parent.horizontalCenter

        y: 585

        radius: 15
        border.color: "#b2972c"

        color: "#FFFDFC"

        border.width: 1

        Text {
            anchors.centerIn: parent

            text: root.romanian ? "Nu ai nevoie de energie maximă ca să începi." : "You don’t need full energy to begin."

            color: "#566159"

            font.pixelSize: 13
            font.styleName: "Regular"
            font.bold: true
            font.family: "Ubuntu Sans"
        }
    }

    // =========================================================
    // CONTINUE
    // =========================================================
    Rectangle {
        id: continueControl

        width: 330
        height: 60

        anchors.horizontalCenter: parent.horizontalCenter

        y: root.height - 100

        radius: 15
        border.color: "#c0aa53"

        color: "#18202A"

        // Metallic highlight
        Text {
            anchors.centerIn: parent

            text: root.romanian ? "Continuă" : "Continue"

            color: "#FFFDFC"

            font.pixelSize: 17
            font.bold: true
        }
    }
}
