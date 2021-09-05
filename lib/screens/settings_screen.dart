import 'package:flutter/material.dart';
import 'package:foodzilla/providers/scheduling_provider.dart';
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
          ],
        ),
      ),
    );
  }
}
