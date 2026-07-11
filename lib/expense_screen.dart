import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'expenseModel.dart';
import 'stats_screen.dart';


class Homepage1 extends StatefulWidget{
  const Homepage1({super.key});
  @override
  State<Homepage1> createState()=>_HomePageState();
}

class _HomePageState extends State<Homepage1>{

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Database? db;
  @override
  void dispose(){
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }
  double totalExpense(){
    double sum=0;
    for (var e in _expense){
      sum=sum+e.amount;
    }
    return sum;
  }

  Future<void> initializeDatabase() async{
    db=await createDatabase();
    List<ExpenseModel> fetched=await getDatabase(db!);
    setState(() {
      _expense=fetched;
    });
  }
  List<ExpenseModel> _expense=[];
  @override
  Widget build(BuildContext context)=>Scaffold(
    backgroundColor: Color(0xFF1A1A2E),
    appBar:AppBar(
      title: Text("Ledgr",style: TextStyle(color: const Color(0xFFFFD700),fontWeight: FontWeight.bold,fontFamily: "BlackOpsOne"),),
      centerTitle:true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color(0xFF1A1A2E),
      elevation: 0,      
    ),
    body: Center(
      child:Column(
        children:[
          SizedBox(height: 10,),
          Text("Total Spending : ₹${totalExpense().toStringAsFixed(0)}",style: TextStyle(color:Colors.white,fontSize: 16,fontFamily: "Inter",fontWeight: FontWeight.bold),),
          Padding(
            padding:EdgeInsets.all(16),
            child: TextField(
              controller: _controller1,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.all(16),
            child:TextField(
              controller: _controller2,          //AMOUNT
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration:const InputDecoration(
                labelText:"Amount",
                border:OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              double? amount=double.tryParse(_controller2.text);
              if(amount==null){
                return;
              }
              await insertExpense(db!,ExpenseModel(_controller1.text, amount) );
              List<ExpenseModel> fetched=await getDatabase(db!);
              setState(() {
                _expense=fetched;
              });
              _controller1.clear();
              _controller2.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xFF6C63FF),
              foregroundColor: Colors.white 
            ),
            child: Text("Add Expense"),
          ),
          SizedBox(height: 13,),
          Expanded(
          child: ListView.builder(
                itemCount: _expense.length,
                itemBuilder:(context,index){
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                    color: Color(0xFF16213E),
                    child: ListTile(
                      title: Text(_expense[index].category,style: TextStyle(color: Colors.white),),
                      trailing: Text(
                        "₹${_expense[index].amount.toStringAsFixed(0)}",
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          ElevatedButton(
            onPressed: ()=>{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>Charts(expense: _expense,))
              ),
            },
            style:ElevatedButton.styleFrom(
              backgroundColor:Color(0xFF6C63FF),
              foregroundColor:Colors.white,
            ),
            child: Text("View Chart"),
          ),
          SizedBox(height: 30,)
        ],
      ),
    ),
  );
}