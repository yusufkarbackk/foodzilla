import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodzilla/providers/scheduling_provider.dart';
import 'package:foodzilla/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 10,
              child: Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: FaIcon(FontAwesomeIcons.arrowLeft)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('Settings',
                        style: Theme.of(context).textTheme.headline6),
                  )
                ],
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Scheduling Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        scheduled.setData(value);
                        scheduled.scheduledNews(value);
                      },
                    );
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Dark Theme'),
                trailing: Consumer<ThemeProvider>(
                  builder: (context, theme, _) {
                    return Switch.adaptive(
                      value: theme.getDarkTheme,
                      onChanged: (value) async {
                        theme.saveTheme(value);
                        theme.setDarkTheme(value);
                      },
                    );
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Change Profile Picture'),
                trailing: Consumer<ThemeProvider>(
                  builder: (context, theme, _) {
                    return FaIcon(
                      FontAwesomeIcons.arrowRight,
                      color: theme.getDarkTheme ? Colors.white : Colors.black,
                    );
                  },
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
