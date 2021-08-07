part of 'screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserServices userData = Provider.of<UserServices>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [Text(userData.foodzillaUser.name)],
        ),
      )),
    );
  }
}
