part of 'screens.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantDetailProvider>(context);

    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Consumer<RestaurantDetailProvider>(
                        builder: (context, state, child) {
                          if (state.getState == ResultState.Loading) {
                            return SpinKitFadingCircle(
                              size: 40,
                              color: kLightWhite,
                            );
                          } else if (state.getState == ResultState.HasData) {
                            return Image.network(
                              getLargeImage(
                                  state.getRestaurantDetail?.pictureId),
                              fit: BoxFit.fitWidth,
                            );
                          } else {
                            return Text(state.getMessage);
                          }
                        },
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
                              child: Text(restaurantProvider.restaurant!.name,
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
                              Text(
                                  '${Provider.of<RestaurantDetailProvider>(context, listen: false).getRestaurantDetail?.rating}/5',
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
                            Text(restaurantProvider.restaurant!.city,
                                style: Theme.of(context).textTheme.subtitle1),
                            GestureDetector(
                              onTap: () {
                                RestaurantServices.getRestaurantLocation(
                                    "https://www.google.co.id/maps/place/${Provider.of<RestaurantDetailProvider>(context, listen: false).getRestaurantDetail?.city}",
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
                        child: Text(restaurantProvider.restaurant!.description,
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
                              Consumer<RestaurantDetailProvider>(
                                builder: (context, state, child) {
                                  if (state.getState == ResultState.Loading) {
                                    return SpinKitFadingCircle(
                                      size: 20,
                                      color: kLightRed,
                                    );
                                  } else if (state.getState ==
                                      ResultState.HasData) {
                                    return Text(state.getRestaurantDetail?.menus
                                            .foods[0].name ??
                                        "-");
                                  } else {
                                    return Text(state.getMessage);
                                  }
                                },
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Opening Hour'),
                              Consumer<RestaurantDetailProvider>(
                                builder: (context, state, child) {
                                  if (state.getState == ResultState.Loading) {
                                    return SpinKitFadingCircle(
                                      size: 20,
                                      color: kLightRed,
                                    );
                                  } else if (state.getState ==
                                      ResultState.HasData) {
                                    List<Widget> categorylist = [];
                                    for (var item in state
                                            .getRestaurantDetail?.categories ??
                                        []) {
                                      categorylist.add(Text(item.name + ', '));
                                    }
                                    return Row(children: categorylist);
                                  } else {
                                    return Text(state.getMessage);
                                  }
                                },
                              )
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
