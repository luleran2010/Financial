import QtQuick 2.12
import QtQuick.Controls 2.5
import "Database.js" as JS
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 300
    height: 460
    property alias flagsCombo: flagsCombo
    property alias dateTextMouseArea: dateTextMouseArea
    property alias dateText: dateText
    anchors.fill: parent
    property alias confirmButton: confirmButton

    title: qsTr("Add Expense")

    property alias date: dateText.text
    property alias expense: expenseSpin.value
    property alias flags: flagsCombo.editText
    property alias comment: commentText.text
    property int rowid

    property alias expenseSpin: expenseSpin

    ColumnLayout {
        id: columnLayout
        x: 200
        y: 66
        width: 200
        height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Label {
            id: label
            text: qsTr("Date:")
        }

        TextField {
            id: dateText
            text: qsTr("")
            enabled: true
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            placeholderText: "Date"

            MouseArea {
                id: dateTextMouseArea
                anchors.fill: parent
            }
        }

        Label {
            id: label1
            text: qsTr("Expense:")
        }

        SpinBox {
            id: expenseSpin
            width: 160
            from: -100000
            stepSize: 100
            editable: true
            to: 100000
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Label {
            id: label2
            text: qsTr("Flags:")
        }

        ComboBox {
            id: flagsCombo
            Layout.fillWidth: true
            editable: true
        }

        Label {
            id: label3
            text: qsTr("Comment")
        }

        TextField {
            id: commentText
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            placeholderText: "Comment"
        }

        Button {
            id: confirmButton
            text: qsTr("Confirm")
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Connections {
        target: confirmButton
        onClicked: {
            if (rowid >= 0) {
                JS.dbUpdate(date, expense / 100, flags, comment, rowid)
                parent.pop()
            } else {
                JS.dbInsert(date, expense / 100, flags, comment)
                parent.pop()
            }
        }
    }
}

/*##^##
Designer {
    D{i:1;anchors_height:400;anchors_width:200;anchors_x:200;anchors_y:66}
}
##^##*/

