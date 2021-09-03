part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        DetailScreen.routeName, context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

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
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hello, ${snapshots.data!.name}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FavouriteScreen()));
                              },
                              child: CircleAvatar(
                                  child: Icon(Icons.favorite_border_rounded)),
                            )
                          ],
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SearchScreen());
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: kDarkWhite,
                          shape: BoxShape.rectangle),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.search,
                            size: 20,
                          ),
                          Text("Search for a restaurant here")
                        ],
                      )),
                ),
                Text(
                  'Explore Our Restaurants Now',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 28,
                ),

                Text('Favourites',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 12,
                ),
                //NOTE: FAVOURITE RESTAURANT
                StreamBuilder(
                    stream: Connectivity().onConnectivityChanged,
                    builder: (context, snapshot) {
                      if (snapshot.data == ConnectivityResult.none) {
                        return Text("please check your internet");
                      } else {
                        return FavouriteRestaurant();
                      }
                    }),

                SizedBox(
                  height: 18,
                ),
                Text('Restaurants',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 12,
                ),
                //NOTE: RESTAURANT LIST
                StreamBuilder(
                    stream: Connectivity().onConnectivityChanged,
                    builder: (context, snapshot) {
                      if (snapshot.data == ConnectivityResult.none) {
                        return Text("please check your internet");
                      } else {
                        return RestaurantList();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
