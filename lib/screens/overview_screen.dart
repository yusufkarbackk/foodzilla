part of 'screens.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    List<Category> foods = [];

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
                                    foods.add(item);
                                  }
                                  return Image.network(
                                      getMediumImage(snapshot.data!.pictureId));
                                } else {
                                  return Text(
                                      'Something went wrong, please check your connection');
                                }
                              })))
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(restaurantProvider.restaurant.name,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: kRed,
                                size: 24,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text('${restaurantProvider.restaurant.rating}/5',
                                  style: Theme.of(context).textTheme.headline6)
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurantProvider.restaurant.city,
                                style: Theme.of(context).textTheme.subtitle1),
                            GestureDetector(
                              onTap: () {
                                RestaurantServices.getRestaurantLocation(
                                    "https://www.google.co.id/maps/place/" +
                                        restaurantProvider.restaurant.city,
                                    context);
                              },
                              child: Text('Navigate to this Restaurant',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: kLightRed,
                                          decoration:
                                              TextDecoration.underline)),
                            )
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(restaurantProvider.restaurant.description,
                            style: Theme.of(context).textTheme.caption)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Top Cuisine'),
                              Text(foods[0].name,
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Opening Hour'),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ElevatedButton(
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
                          )),
                    )
                  ],
                ),
              ))),
    );
  }
}
