part of 'screens.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

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
