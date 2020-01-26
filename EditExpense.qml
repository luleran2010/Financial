import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "Database.js" as JS

EditExpenseForm {
    dateText.text: Qt.formatDate(new Date(), "yyyy-MM-dd")

//    dateText.onReleased: {
//        popup.open()
//    }

    dateTextMouseArea.onClicked: popup.open()

    expenseSpin.validator: DoubleValidator {
        bottom: -100000
        top: 100000
    }

    expenseSpin.textFromValue: function(value, locale) {
        return Number(value / 100).toLocaleString(locale, 'f', 2)
    }

    expenseSpin.valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text) * 100
    }

    flagsCombo.model: ListModel {
        id: categoryListModel
        Component.onCompleted: JS.dbReadCategories()
    }

    Popup {
        id: popup
        anchors.centerIn: parent

        ColumnLayout {
            Row {
                SpinBox {
                    id: yearSpin
                    width: 140

                    from: 1996
                    to: 2100
                    value: Qt.formatDate(new Date(), "yyyy")
                }

                SpinBox {
                    id: monthSpin
                    width: 120

                    from: 1
                    to: 12
                    value: Qt.formatDate(new Date(), "MM")
                }

            }

            DayOfWeekRow {
                Layout.fillWidth: true
            }

            MonthGrid {
                id: grid
                month: monthSpin.value - 1
                year: yearSpin.value
                locale: Qt.locale("en_US")
                Layout.fillWidth: true

                onClicked: {
                    dateText.text = Qt.formatDate(date, "yyyy-MM-dd")
                    popup.close()
                }
            }
        }
    }
}
