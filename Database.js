function dbInit()
{
    var db = LocalStorage.openDatabaseSync("FinancialDB", "1.0", "Record for expenses", 1000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS expenses (' +
                          'date DATE,' +
                          'expense REAL,' +
                          'flags VARCHAR,' +
                          'comment VARCHAR)');
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    }
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("FinancialDB", "1.0", "Record for expenses", 1000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(date, expense, flags, comment)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO expenses (date, expense, flags, comment) VALUES(?, ?, ?, ?)',
                      [date, expense, flags, comment])
        var result = tx.executeSql('Select last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid
}

function dbReadAll()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT rowid, date, expense, flags, comment FROM expenses ORDER BY date desc')
        for (var i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 rowid: results.rows.item(i).rowid,
                                 date: results.rows.item(i).date.toString(),
                                 expense: results.rows.item(i).expense,
                                 flags: results.rows.item(i).flags,
                                 comment: results.rows.item(i).comment
                             })
        }
    })
}

function dbUpdate(date, expense, flags, comment, rowid)
{
    var db = dbGetHandle()
    db.transaction(function (tx){
        tx.executeSql(
                    'UPDATE expenses set date=?, expense=?, flags=?, comment=? WHERE rowid=?',
                    [date, expense, flags, comment, rowid])
    })
}

function dbDelete(rowid)
{
    var db = dbGetHandle()
    db.transaction(function (tx){
        tx.executeSql(
                    'DELETE FROM expenses WHERE rowid=?',
                    [rowid])
    })
}

function dbReadCategorialMonth(year, month)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var time = Qt.formatDate(new Date(year, month - 1, 1), 'yyyy-MM-dd')
        console.log('the time is' + time)
        var results = tx.executeSql(
                    'SELECT flags, SUM(expense) FROM expenses ' +
                    'WHERE [date] between date(\'' + time + '\') and date(\'' + time + '\', \'+1 month\', \'-1 day\') ' +
                    'GROUP BY flags ' +
                    'ORDER BY date')
        for (var i = 0; i < results.rows.length; i++) {
            categoryListModel.append({
                                         category: results.rows.item(i).flags,
                                         expenses: results.rows.item(i)["SUM(expense)"]
                                     })
        }
    })
}

function dbReadCategories()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT flags FROM expenses ' +
                    'GROUP BY flags ')
        for (var i = 0; i < results.rows.length; i++) {
            categoryListModel.append({
                                         category: results.rows.item(i).flags
                                     })
        }
    })
}

