part of 'screens.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);

    List<Widget> foods = [];
    List<Widget> drinkList = [];

    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                        expandedHeight: 200,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: FutureBuilder<RestaurantDetail>(
                              future: RestaurantServices.getRestaurantDetail(
                                  restaurantProvider.restaurant.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SpinKitFadingCircle(
                                    color: kLightRed,
                                    size: 40,
                                  );
                                } else if (snapshot.hasData) {
                                  for (var item in snapshot.data!.menus.foods) {
                                    foods.add(Text(item.name));
                                  }
                                  for (var item
                                      in snapshot.data!.menus.drinks) {
                                    drinkList.add(Text(item.name));
                                  }
                                  return Image.network(
                                      getMediumImage(snapshot.data!.pictureId));
                                } else {
                                  return Text(
                                      'Something went wrong, please check your connection');
                                }
                              }),
                        ))
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Foods',
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: foods,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text('Drinks',
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: drinkList,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingScreen()));
                            },
                            child: Center(
                              child: Text('Book Now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(color: kWhite)),
                            ))
                      ],
                    ),
                  ),
                ))));
  }
}
