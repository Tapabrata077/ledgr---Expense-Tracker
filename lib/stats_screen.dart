import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'expenseModel.dart';
class Charts extends StatefulWidget{
  final List<ExpenseModel> expense;
  const Charts({required this.expense,super.key});
  @override
  State<Charts> createState()=> _chartpages();
}
class _chartpages extends State<Charts>{

  final Map<String,double> totals={};
  final List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.amber,
  Colors.indigo,
  Colors.cyan,
  Colors.lime,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.brown,
  Colors.blueGrey,
  Colors.yellow,
  Colors.greenAccent,
  Colors.orangeAccent,
  ];
  void _groupByCategory(){
    totals.clear();
    for(var ex in widget.expense){
      if(totals.containsKey(ex.category)){
        totals[ex.category]=totals[ex.category]! + ex.amount;
      }else{
        totals[ex.category]=ex.amount;
      }
    }
  }
  @override
  void initState(){
    super.initState();
    _groupByCategory();
  }
  double totalExpense(){
    double sum=0;
    for (var e in totals.entries){
      sum=sum+e.value;
    }
    return sum;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar:AppBar(
        title: Text("Ledgr",style:TextStyle(fontFamily: "BlackOpsOne",fontSize: 22,fontWeight: FontWeight.bold,color: Color(0xFFFFD700))),
        centerTitle:true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1A1A2E),
      ),
      body: Column(
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 20,
                  centerSpaceColor: Color(0xFF1A1A2E),
                  sectionsSpace: 2,
                  sections: List.generate(
                    totals.length,
                    (index){
                      final entry=totals.entries.elementAt(index);
                      final int percentage=((entry.value/totalExpense())*100).round();
                      return PieChartSectionData(
                        value: entry.value,
                        title: "$percentage%",
                        color: colors[index % colors.length],
                        radius: 130,
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: totals.length,
                itemBuilder: (context,index){
                  final entry=totals.entries.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 8,
                      backgroundColor: colors[index % colors.length],
                    ),
                    title: Text(entry.key,style: TextStyle(color: Colors.white),),
                    trailing: Text(
                      "₹${entry.value.toStringAsFixed(0)}",
                      style:const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}