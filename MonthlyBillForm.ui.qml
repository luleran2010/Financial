import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.3
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 300
    height: 460
    property alias categoryListView: categoryListView
    property alias pie: pie
    property alias monthSpin: monthSpin
    property alias yearSpin: yearSpin
    property alias pieSeries: pieSeries
    property alias year: yearSpin.value
    property alias month: monthSpin.value
    anchors.fill: parent

    title: qsTr("Monthly Bill")

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        ChartView {
            id: pie
            height: 250
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            title: "Categorial Expenses"

            PieSeries {
                id: pieSeries
                name: "PieSeries"
            }
        }

        RowLayout {
            id: rowLayout
            Layout.fillWidth: true

            SpinBox {
                id: yearSpin
                width: 140
                Layout.fillWidth: true
                to: 2100
                from: 1996

                value: Qt.formatDate(new Date(), 'yyyy')
            }

            SpinBox {
                id: monthSpin
                width: 140
                Layout.fillWidth: true
                to: 12
                from: 1

                value: Qt.formatDate(new Date(), 'MM')
            }
        }

        ListView {
            id: categoryListView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }

                    Text {
                        text: name
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    spacing: 10
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:2;anchors_width:300}D{i:7;anchors_width:110}
}
##^##*/

