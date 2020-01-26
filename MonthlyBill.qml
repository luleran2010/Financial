import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.3
import "Database.js" as JS

MonthlyBillForm {
    function replot() {
        categoryListModel.clear()
        pieSeries.clear()
        JS.dbReadCategorialMonth(year, month)
        for (var i = 0; i < categoryListModel.rowCount(); i++) {
            console.log(categoryListModel.get(i).category, categoryListModel.get(i).expenses)
            var pieSlice = pieSeries.append(categoryListModel.get(i).category, categoryListModel.get(i).expenses)
        }
    }

    ListModel {
        id: categoryListModel
        Component.onCompleted: {
            replot()
        }
    }

    categoryListView.model: categoryListModel

    categoryListView.delegate: Item {
        height: 50
        width: parent.width

        Label {
            text: category
            font.pixelSize: 18
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
        }

        Label {
            text: Math.round(pieSeries.at(index).percentage*100) + '%'
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            text: expenses
            font.pixelSize: 24
            font.bold: true
            anchors.right: parent.right
            anchors.rightMargin: 5
        }
    }

    pie.legend.alignment: Qt.AlignRight

    yearSpin.onValueChanged: replot()
    monthSpin.onValueChanged: replot()
}
