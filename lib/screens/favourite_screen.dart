part of 'screens.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 10,
            child: Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(FontAwesomeIcons.arrowLeft)),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text('Booking',
                      style: Theme.of(context).textTheme.headline6),
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FavouriteRestaurantServices.getFavourites(
                  Provider.of<User?>(context)!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> list = [];
                  final List<QueryDocumentSnapshot<Object?>> favourites =
                      snapshot.data!.docs;
                  for (var item in favourites) {
                    list.add(RestaurantCard(
                        restaurantId: (item.data() as dynamic)["restaurant_id"],
                        imageURL: (item.data() as dynamic)["imageURL"],
                        name: (item.data() as dynamic)["name"],
                        city: (item.data() as dynamic)["city"],
                        rating: (item.data() as dynamic)["rating"]));
                  }
                  if (list.length == 0) {
                    return Center(child: Text("No Favourite Restaurant"));
                  } else {
                    return Column(
                      children: list,
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: SpinKitFadingCircle(
                    color: kLightRed,
                    size: 40,
                  ));
                } else {
                  return Text("Error getting data");
                }
              })
        ],
      )),
    ));
  }
}
