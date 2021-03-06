part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserServices userData = Provider.of<UserServices>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 22, horizontal: 24),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<ThemeProvider>(builder: (context, theme, _) {
                  return CircleAvatar(
                    minRadius: 50,
                    backgroundColor:
                        theme.getDarkTheme ? Colors.white : Colors.black,
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 50,
                      color: kLightRed,
                    ),
                  );
                }),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama: ${userData.foodzillaUser.name}',
                        style: Theme.of(context).textTheme.subtitle1),
                    Text('Email: ${userData.foodzillaUser.email}',
                        style: Theme.of(context).textTheme.subtitle1),
                    Text('Phone: ${userData.foodzillaUser.phone}',
                        style: Theme.of(context).textTheme.subtitle1),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        child: Text("Settings")),
                  ],
                )),
                ElevatedButton(
                    onPressed: () {
                      AuthServices.signOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: kLightRed, fixedSize: Size(200, 40)),
                    child: Center(
                      child: Text('Sign Out'),
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
