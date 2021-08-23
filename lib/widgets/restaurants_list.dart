part of 'widgets.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    return FutureBuilder<List<Restaurant>>(
        future: RestaurantServices.getRestaurants(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Text('Error: ${snapshots.error}');
          } else if (snapshots.hasData) {
            var items = snapshots.data!;
            var list = items
                .map((e) => GestureDetector(
                      onTap: () async {
                        await Provider.of<RestaurantDetailProvider>(context,
                                listen: false)
                            .fetchRestaurantDetail(e.id);
                        await Provider.of<FavouriteRestaurantServices>(context,
                                listen: false)
                            .checkIsFavourited(
                                Provider.of<RestaurantDetailProvider>(context,
                                            listen: false)
                                        .getRestaurantDetail
                                        ?.id ??
                                    '-',
                                Provider.of<User?>(context, listen: false)!
                                    .uid);
                        Provider.of<RestaurantDetailProvider>(context,
                                listen: false)
                            .setHeroTag = e.pictureId;
                        restaurantProvider.restaurant = e;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen()));
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      getSmallImage(e.pictureId),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          e.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: kRed,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text('${e.rating}/5')
                                          ],
                                        )
                                      ]),
                                ),
                              )
                            ],
                          )),
                    ))
                .toList();
            return Column(
              children: list,
            );
          } else {
            return SpinKitFadingCircle(
              color: kLightRed,
              size: 40,
            );
          }
        });
  }
}
