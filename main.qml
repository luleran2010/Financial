import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

ApplicationWindow {
    id: window
    visible: true
    width: 300
    height: 540
    title: qsTr("Stack")

    Component.onCompleted: {
        JS.dbInit()
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? qsTr("Back") : qsTr("Menu")
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }


        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }

        ToolButton {
            id: addExpenseToolButton
            text: qsTr("+")
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            anchors.right: parent.right
            visible: stackView.depth === 1
            onClicked: {
                stackView.push("EditExpense.qml", {"rowid": -1})
            }
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Add Expense")
                width: parent.width
                onClicked: {
                    stackView.push("EditExpense.qml", {"rowid": -1})
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Monthly Bill")
                width: parent.width
                onClicked: {
                    stackView.push("MonthlyBill.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }

    onClosing: {
        if (stackView.depth > 1) {
            close.accepted = false
            stackView.pop()
        } else {
            return
        }
    }
}
