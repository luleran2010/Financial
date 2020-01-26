import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12
import Qt.labs.platform 1.0
import "Database.js" as JS

HomeForm {
    id: homeForm
    delegate: SwipeDelegate {
        id: swipeDelegate
        width: parent.width
        height: 60

        contentItem: Item {
            Text {
                id: dateText
                text: date
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
            }

            Text {
                id: flagsText
                text: flags
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                font.pixelSize: 12
            }

            Text {
                id: commentText
                text: comment
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                font.pixelSize: 12
            }

            Text {
                id: expenseText
                text: expense
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                font.pixelSize: 24
            }

        }

        swipe.right: Label {
            text: qsTr("Remove")
            height: parent.height
            width: parent.height
            verticalAlignment: Label.AlignVCenter
            anchors.right: parent.right
            padding: 2
            background: Rectangle {
                color: "red"
            }
            font.family: "Noto Sans [GOOG]"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    JS.dbDelete(rowid)
                    listModel.clear()
                    JS.dbReadAll()
                }
            }

//            SwipeDelegate.onClicked: {
//                JS.dbDelete(rowid)
//                listModel.clear()
//                JS.dbReadAll()
//            }
        }

        swipe.left: Label {
            text: qsTr("Edit")
            height: parent.height
            width: parent.height
            verticalAlignment: Label.AlignVCenter
            anchors.left: parent.left
            padding: 15
            background: Rectangle {
                color: "gray"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    homeForm.parent.push("EditExpense.qml", {
                                             "date": date,
                                             "expense": expense * 100,
                                             "flags": flags,
                                             "comment": comment,
                                             "rowid": rowid
                                         })
                }
            }

//            SwipeDelegate.onClicked: {
//                homeForm.parent.push("EditExpense.qml", {
//                                         "date": date,
//                                         "expense": expense * 100,
//                                         "flags": flags,
//                                         "comment": comment,
//                                         "rowid": rowid
//                                     })
//            }
        }
    }

    model: ListModel {
        id: listModel
    }

    StackView.onActivated: {
        listModel.clear()
        JS.dbReadAll()
    }
}
