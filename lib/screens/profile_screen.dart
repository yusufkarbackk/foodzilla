part of 'screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath;
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
                  return (imagePath != null)
                      ? Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(imagePath!))),
                        )
                      : CircleAvatar(
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
                    TextButton(
                        onPressed: () async {
                          XFile? file = await getImage();
                          //imagePath = await UserServices.uploadImage(file);
                        },
                        child: Text("Change Profile picture"))
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

  Future<XFile?> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
