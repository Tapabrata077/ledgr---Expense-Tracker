import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'expenseModel.dart';

//Create Databse
Future<Database> createDatabase() async{
  String path=join(await getDatabasesPath(),"Expense.db");
  print(path);
  return openDatabase(
    path,
    version:1,
    onCreate:(db,version){
      return db.execute("create table Expenses(ID integer primary key autoincrement,Category text,Amount real)");
    }
  );
}
//Insert data
Future<void> insertExpense(Database db,ExpenseModel ex) async{
  await db.rawInsert("insert into Expenses(Category,Amount) values(?,?)",[ex.category,ex.amount],);
}
//display data
Future<List<ExpenseModel>> getDatabase(Database db) async{
  final List<Map<String,dynamic>> maps=await db.rawQuery("select * from Expenses");
  return maps.map((map)=> ExpenseModel(map['Category'],map['Amount'])).toList();
}