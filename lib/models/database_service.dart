import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DatabaseService {
  static Database? _db;

  //Create only one Instance of this class
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  //Create the DB Tables
  final String _chicksTable = "chicks_entry_stock";
  final String _flockTable = "chicken_flock";
  final String _salesTable = "chicken_sales";
  final String _appInfo = "app_info";
  final String _userInfo = "user_info";
  final String _flockInfo = "flock_info";
  final String _salesHistoryTable = "sales_history_table";

  //Check if the database exists or not
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  //Function to create and get the database
  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "farm_app_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        final String createChicksTable = '''
          CREATE TABLE IF NOT EXISTS $_chicksTable(id INTEGER PRIMARY KEY AUTOINCREMENT, company TEXT NOT NULL,
          qty INTEGER NOT NULL, deaths INTEGER NOT NULL DEFAULT 0, available INTEGER NOT NULL, brooder INTEGER NOT NULL DEFAULT 1,
           date TEXT NOT NULL, uploaded INTEGER NOT NULL DEFAULT 0)
        ''';

        final String createFlockTable = '''
          CREATE TABLE IF NOT EXISTS $_flockTable(id INTEGER PRIMARY KEY AUTOINCREMENT, flock TEXT NOT NULL,
          qty INTEGER NOT NULL, deaths INTEGER NOT NULL DEFAULT 0, available INTEGER NOT NULL,date TEXT NOT NULL,
           uploaded INTEGER NOT NULL DEFAULT 0)
        ''';

        final String createSalesTable = '''
          CREATE TABLE IF NOT EXISTS $_salesTable(id INTEGER PRIMARY KEY AUTOINCREMENT, flock TEXT NOT NULL,
          qty INTEGER NOT NULL, weight REAL NOT NULL, decimal_value REAL NOT NULL, price INTEGER NOT NULL, 
          date TEXT NOT NULL,on_credit INTEGER NOT NULL DEFAULT 0, paid INTEGER NOT NULL DEFAULT 0, customer_name TEXT,
          uploaded INTEGER NOT NULL DEFAULT 0)
        ''';

        final String createSalesHistoryTable = '''
          CREATE TABLE IF NOT EXISTS $_salesHistoryTable(id INTEGER PRIMARY KEY AUTOINCREMENT, flock TEXT NOT NULL,
          qty INTEGER NOT NULL, weight REAL NOT NULL, decimal_value REAL NOT NULL, price INTEGER NOT NULL, 
          date TEXT NOT NULL,on_credit INTEGER NOT NULL DEFAULT 0, paid INTEGER NOT NULL DEFAULT 0, customer_name TEXT,
          uploaded INTEGER NOT NULL DEFAULT 0)
        ''';

        final String createAppInfoTable = '''
          CREATE TABLE IF NOT EXISTS $_appInfo(id INTEGER PRIMARY KEY AUTOINCREMENT,app_version INTEGER NOT NULL DEFAULT 0,
          app_name TEXT NOT NULL)
        ''';

        final String createUserInfoTable = '''
          CREATE TABLE IF NOT EXISTS $_userInfo(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT NOT NULL,
          pin INTEGER NOT NULL, active INTEGER NOT NULL DEFAULT 1)
        ''';

        final String createFlockInfoTable = '''
          CREATE TABLE IF NOT EXISTS $_flockInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, flock TEXT NOT NULL,
          active INTEGER NOT NULL DEFAULT 0)
        ''';

        //Create the tables here
        db.execute(createChicksTable);
        db.execute(createFlockTable);
        db.execute(createUserInfoTable);
        db.execute(createAppInfoTable);
        db.execute(createSalesTable);
        db.execute(createFlockInfoTable);
        db.execute(createSalesHistoryTable);
      },
    );
    return database;
  }

  //DB table functions
  void addChicksData(String company, int deaths, int qty) async {
    final db = await database;
    final date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
    final available = (qty - deaths);
    await db.insert(_chicksTable, {
      "deaths": deaths,
      "company": company,
      "qty": qty,
      "available": available,
      "date": date
    });
  }

  //Add Sales Data
  Future<String> addSalesData(
      String flock,
      int? qty,
      double? weight,
      double? decimalValue,
      int? price,
      int? on_credit,
      int? paid,
      String customerName,
      String date) async {
    final db = await database;
    final currentFlockValue = await db.query(_flockTable,whereArgs: [flock],where: "flock=?");
    print("Current Flock Qty: ${currentFlockValue}");
    /*
    await db.insert(_salesTable, {
      "flock": flock,
      "weight": weight,
      "decimal_value": decimalValue,
      "price": price,
      "on_credit": on_credit,
      "paid": paid,
      "customer_name": customerName,
      "qty": qty,
      "date": date
    });
    */
    return "";
  }

  //Flock Data
  void addFlockLabels(
    String flock,
  ) async {
    final db = await database;
    await db.insert(_flockInfo, {"flock": flock});
  }

  Future<List> getFlockLabels() async{
    final db = await database;
    var data = await db.rawQuery("SELECT * FROM flock_info ORDER BY id DESC;");
    return data;
  }

  void deleteFlockLabel(int id) async{
    final db = await database;
    await db.delete("flock_info",where: "id=?",whereArgs: [id]);
  }

  void updateFlockLabel(int id) async{
    final db = await database;
    await db.update("flock_info", {
      "active":0
    },
      where: "id!=?",
      whereArgs: [id]
    );
    await db.update("flock_info", {
      "active":1
    },
      where: "id=?",
      whereArgs: [id]
    );
  }

  Future<List> getFlockData() async{
    final db = await database;
    var data = await db.query(_flockTable,orderBy: "id DESC",);
    return data;
  }

  //Add to chicken flock
  void addChickenFlock(
      String flock, int qty, int deaths,) async {
    final db = await database;
    final available = (qty - deaths);
    String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
    await db.insert(_flockTable, {
      "flock": flock,
      "qty": qty,
      "deaths": deaths,
      "available": available,
      "date": date
    });
  }

  //Delete flock
  void deleteFlock(int? id) async{
    final db = await database;
    await db.delete(_flockTable,where: "id=?",whereArgs: [id]);
  }

  void updateFlock(int id, int flock, int qty, int deaths,) async{
    final db = await database;
    await db.update(_flockTable, {
      "flock":flock,
      "qty":qty,
      "deaths":deaths
    },
      where: "id=?",
      whereArgs: [id]
    );
  }

  //User Profile
  Future<List> getUserProfile() async {
    final db = await database;
    var userData = await db.rawQuery('''
      SELECT * FROM user_info;
    ''');
    return userData;
  }

  void saveNewUserProfile(String userName, String pin) async {
    final db = await database;
    await db.insert(_userInfo, {"username":userName,"pin":pin});
  }

  void updateUserProfile(String userName, String pin, String id) async {
    final db = await database;
    await db.update("user_info", {"username":userName,"pin":pin},where: "id = ?", whereArgs: [id]);
  }

  //Home summary
  Future<List> getHomeSummaryData() async {
    final db = await database;
    final today =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    var salesData = await db.rawQuery('''
      SELECT SUM(paid) as today_sales FROM chicken_sales WHERE date = "$today";
    ''');
    var totalChicken = await db.rawQuery('''
      SELECT SUM(available) as available FROM chicken_flock;
    ''');
    var brooderChicks = await db.rawQuery('''
      SELECT  SUM(available) as brooder_counter FROM chicks_entry_stock WHERE brooder = 1;
    ''');
    var activeFlock = await db.rawQuery('''
      SELECT flock FROM flock_info WHERE active = 1;
    ''');
    return [salesData[0], totalChicken[0], brooderChicks[0], activeFlock[0]];
  }

  Future<List> recentTransactions() async {
    var db = await database;
    var recentTransactions = await db.rawQuery('''
      SELECT * FROM chicken_sales ORDER BY id DESC LIMIT 10;
    ''');
    return recentTransactions;
  }

  //Chick data
  Future<List> getChicksData() async{
    final db = await database;
    var data = await db.rawQuery("SELECT * FROM chicks_entry_stock ORDER BY id DESC;");
    return data;
  }

  Future<String> transferFromBrooder(int id, int qty,int flock) async{
    final db = await database;
    //Check if flock exists in table
    final flockExists = await db.query(_flockTable,where: "flock=?",whereArgs: [flock]);
    if(flockExists.isNotEmpty){
      //Update the flock table
      String oldQty = "${flockExists[0]["qty"]}";
      int newQty = (int.parse(oldQty) + qty);
      await db.update(_flockTable,
        {
          "qty":newQty,
        },
        where: "flock=?",
        whereArgs: [flock]
      );
    }else{
      //Insert new flock
      final String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      await db.insert(_flockTable,
        {
          "qty":qty,
         "flock":flock,
         "available":qty,
          "date":date
        }
      );
    }

    //Update the brooder table
    await db.update(_chicksTable,
    {
      "brooder":0
    },
      whereArgs: [id],
      where: "id=?"
    );
    return "";
  }

  Future<List> getActiveBrooderData() async{
    final db = await database;
    var data = await db.rawQuery("SELECT * FROM chicks_entry_stock WHERE brooder=1 ORDER BY id DESC;");
    return data;
  }

  void updateChicksData(String company, int qty, int deaths, int available,int id) async{
    final db = await database;
    await db.update("chicks_entry_stock",
    {
      "company":company,
      "qty":qty,
      "deaths":deaths,
      "available":available
    },where: "id=?",
      whereArgs: [id]
    );
  }

  void deleteChicksData(int id) async{
    final db = await database;
    await db.delete("chicks_entry_stock",where: "id=?",whereArgs: [id]);
  }

  //Number Format
  String formatAmount(String price) {
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }
}
