import 'package:flutter/material.dart';
import 'add_note.dart';
import 'settings.dart';
import 'show_notes.dart';

class MyHomePage extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Home Page'),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: MaterialButton(
                child: Text(
                  'Add Note',
                  style: TextStyle(fontSize: 22,
                  color: Colors.white,),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, AddPostScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: MaterialButton(
                child: Text(
                  'Show Notes',
                  style: TextStyle(fontSize: 22,
                  color: Colors.white,),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, ShowPostsScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: MaterialButton(
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 22,
                  color: Colors.white,),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
