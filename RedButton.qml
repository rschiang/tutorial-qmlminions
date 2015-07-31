import QtQuick 2.0

Rectangle {
    id: buttonRect
    width: 120
    height: 60
    radius: 16
    color: "red"

    property string text
    signal clicked

    Text {
        anchors.centerIn: parent
        color: "white"
        font.pointSize: 20
        font.bold: Font.Bold
        text: parent.text
    }

    MouseArea {
        anchors.fill: buttonRect // parent
        onClicked: {
            buttonRect.scale *= 1.1
            if (resetTimer.running)
                resetTimer.stop()
            resetTimer.start()
            buttonRect.clicked()
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutBack
        }
    }

    Timer {
        id: resetTimer
        interval: 500
        repeat: false
        running: false
        onTriggered: {
            buttonRect.scale = 1
        }
    }
}

