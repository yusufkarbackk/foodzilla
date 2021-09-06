import 'package:flutter/material.dart';
import 'package:foodzilla/providers/scheduling_provider.dart';
import 'package:foodzilla/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
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
                        theme.setDarkTheme = value;
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
