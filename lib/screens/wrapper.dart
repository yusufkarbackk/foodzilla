part of 'screens.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? catishUser = Provider.of<User?>(context);

    return catishUser == null ? WelcomeScreen() : CurrentScreen();
  }
}
