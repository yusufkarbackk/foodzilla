part of 'screens.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    List<String> foodList = [];
    for (var item in restaurantProvider.restaurant.menus.foods) {
      foodList.add(item.name);
    }
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                        restaurantProvider.restaurant.imageURL,
                        fit: BoxFit.fitWidth,
                      )))
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
                                    restaurantProvider
                                        .restaurant.restaurantLocation,
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
                        child: Text(restaurantProvider.restaurant.desc,
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
                              Text(foodList[0],
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Opening Hour'),
                              Text(restaurantProvider.restaurant.openHour,
                                  style: Theme.of(context).textTheme.subtitle1)
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
