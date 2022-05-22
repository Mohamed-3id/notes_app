import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_note.dart';
import 'home_page.dart';
import 'add_note.dart';
import 'settings.dart';
import 'show_notes.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            debugShowCheckedModeBanner: false,
            initialRoute: MyHomePage.routeName,
            routes: {
              MyHomePage.routeName: (context) => MyHomePage(),
              AddPostScreen.routeName: (context) => AddPostScreen(),
              ShowPostsScreen.routeName: (context) => ShowPostsScreen(),
              EditDataScreen.routeName: (context) => EditDataScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
