part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    UserServices userData = Provider.of<UserServices>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //NOTE: HEADER
                FutureBuilder<FoodzillaUser>(
                    future: UserServices.getUser(user!.uid),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        userData.foodzillaUser = snapshots.data!;
                        return Text(
                          "Hello, ${snapshots.data!.name}",
                          style: Theme.of(context).textTheme.headline5,
                        );
                      } else if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return SpinKitFadingCircle(
                          color: kLightRed,
                          size: 28,
                        );
                      } else {
                        return Text("error");
                      }
                    }),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Explore Our Restaurants Now',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 28,
                ),

                Container(
                  //NOTE:SEARCH BAR
                  width: double.infinity,
                  height: 35,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            BoxConstraints(minHeight: 14, minWidth: 14),
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.search,
                          size: 18,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkWhite),
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text('Favourites',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 12,
                ),
                //NOTE: FAVOURITE RESTAURANT
                FavouriteRestaurant(),
                SizedBox(
                  height: 18,
                ),
                Text('Restaurants',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 12,
                ),
                //NOTE: RESTAURANT LIST
                RestaurantList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
