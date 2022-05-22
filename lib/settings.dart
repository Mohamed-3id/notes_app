import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class SettingsScreen extends StatelessWidget {
  static final String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(

                title: Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                secondary: Icon(Icons.brightness_6),
                contentPadding: EdgeInsets.only(top: 20),
                subtitle: Text('Used to active Application Dark Mode ...'),
                activeThumbImage: AssetImage('Assets/Images/dark.png'),
                inactiveThumbImage: AssetImage('Assets/Images/light.png'),
                activeColor: Colors.white,
                activeTrackColor: Colors.white,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,


                onChanged: (value) {
                  notifier.lightTheme();
                },

                value: notifier.darkTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
