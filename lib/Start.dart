import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/screens/Home.dart';
import 'package:youtube/screens/Library.dart';
import 'package:youtube/screens/Subscriptions.dart';
import 'package:youtube/screens/WhatsHot.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  int _actualIndex = 0;
  String _search = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      Home(_search),
      WhatsHot(),
      Subscriptions(),
      Library()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "images/youtube.png",
          scale: 8.5
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: (){
                print("acção: videocam");
              }
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch( context: context, delegate: CustomSearchDelegate() );
                setState(() {
                  _search = res;
                });
                print ("resultado : digitado " + res);
              }
          ),
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){
                print("acção: account");
              }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_actualIndex],
      ),





      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _actualIndex,
        onTap: (index){
          setState(() {
            _actualIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("What's Hot"),
              icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              title: Text("Subscriptions"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              title: Text("Library"),
              icon: Icon(Icons.folder)
          )

        ],
      )
    );
  }
}
