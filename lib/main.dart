import 'package:flutter/material.dart';
import 'package:ledgr/expense_screen.dart';
void main(){
  runApp(
    MaterialApp(
      home: Homepage(),
    ),
  );
}
class Homepage extends StatefulWidget{
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage>{
  bool _visible=false;
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      setState(() {
        _visible=true;
      });
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: Color(0xFF1A1A2E),
        elevation: 0,
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ledgr",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: "BlackOpsOne",
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Spacer(flex: 1),
              Icon(
                Icons.account_balance_wallet,
                size: 100,
                color: Color(0xFFFFD700),
              ),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(seconds: 2),
                child: Text(
                  "Every expense tells a story",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "BlackOpsOne",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Homepage1())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C63FF),
                foregroundColor:Colors.white,
              ),
              child: Text("Get Started"),
              ),
              Spacer(flex: 3,),
            ],
          ),
      ),
    );
  }
}