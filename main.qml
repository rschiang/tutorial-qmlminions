import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    visible: true
    width: 720
    height: 560

    Rectangle {
        id: scene
        anchors.fill: parent
        color: "#fefefe"
        focus: true

        property int velocity: 480
        property int gravity: 490
        property int degrees: 60

        RedButton {
            id: button1
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 16
            text: "開始"
        }

        RedButton {
            id: button2
            anchors.left: button1.right
            anchors.verticalCenter: button1.verticalCenter
            anchors.leftMargin: 16
            text: "暫停"
        }

        RedButton {
            id: button3
            anchors.left: button2.right
            anchors.verticalCenter: button1.verticalCenter
            anchors.leftMargin: 16
            text: "結束"
        }

        Image {
            id: character
            width: 100
            height: 135
            x: 100
            y: 300
            source: "minions.jpg"

            Behavior on x {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutBack
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutBack
                }
            }
        }

        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Left:
            case Qt.Key_A:
                if (character.x > 0)
                    character.x -= 30
                break;
            case Qt.Key_Right:
            case Qt.Key_D:
                if (character.x < (parent.width - character.width))
                    character.x += 30
                break;
            case Qt.Key_Up:
            case Qt.Key_W:
                if (character.y > 0)
                    character.y -= 30
                break;
            case Qt.Key_Down:
            case Qt.Key_S:
                if (character.y < (parent.height - character.height))
                    character.y += 30
                break;
            case Qt.Key_Space:
                if (jumpTimer.running)
                    jumpTimer.stop()
                jumpTimer.jumpStart()
                break;
            }

            if (event.text) {
                console.log(event.text + "鍵按下去了！")
            }
            else {
                console.log(event.key + "是這個按鍵的編號！")
            }
        }

        Timer {
            id: jumpTimer
            interval: 20
            repeat: true
            running: false

            property int startX
            property int startY
            property int elapsed

            onTriggered: {
                elapsed += interval

                var vX = scene.velocity * Math.cos(scene.degrees * (180 / Math.PI))
                var vY = scene.velocity * Math.sin(scene.degrees * (180 / Math.PI))
                var t = (elapsed / 1000)
                character.x = startX + vX * t
                character.y = startY - vY * t + (scene.gravity * t * t) / 2

                if (character.y > startY) {
                    character.y = startY
                    stop()
                }

                if (character.x >= (parent.width - character.width)) {
                    character.x = (parent.width - character.width)
                }
            }

            function jumpStart() {
                startX = character.x
                startY = (parent.height - character.height) // character.y
                elapsed = 0
                start()
            }
        }
    }
}
