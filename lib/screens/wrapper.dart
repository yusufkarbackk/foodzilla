part of 'screens.dart';

class Wrapper extends StatefulWidget {
  static const routeName = "/";

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        DetailScreen.routeName, context);
    Future.delayed(Duration.zero, () {
      this.initIsScheduled();
    });
  }

  void initIsScheduled() async {
    Provider.of<SchedulingProvider>(context, listen: false).getData();
    Provider.of<SchedulingProvider>(context, listen: false).scheduledNews(
        Provider.of<SchedulingProvider>(context, listen: false).isScheduled);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate = DateTime.now();
    TimeOfDay time = TimeOfDay.now();
    User? catishUser = Provider.of<User?>(context);
    DateTimeProvider dateTimeProvider = Provider.of<DateTimeProvider>(context);

    dateTimeProvider
        .addDate("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
    dateTimeProvider.addTime("${time.hour}:${time.minute}");

    return catishUser == null ? WelcomeScreen() : CurrentScreen();
  }
}
