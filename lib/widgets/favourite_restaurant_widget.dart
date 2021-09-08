part of 'widgets.dart';

class FavouriteRestaurant extends StatelessWidget {
  const FavouriteRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    return Container(
      width: double.infinity,
      height: 180,
      child: FutureBuilder<List<Restaurant>>(
          future: RestaurantServices.getRestaurants(),
          builder: (context, snapshots) {
            if (snapshots.hasError) {
              return Text('Error: ${snapshots.error}');
            } else if (snapshots.hasData) {
              var items = snapshots.data!;
              List<Restaurant> favouriteList = [];
              for (var item in items) {
                if (item.rating >= 4.3) {
                  favouriteList.add(item);
                }
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: favouriteList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Provider.of<RestaurantDetailProvider>(context,
                                listen: false)
                            .fetchRestaurantDetail(favouriteList[index].id);
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

                        restaurantProvider.restaurant = favouriteList[index];

                        Provider.of<RestaurantDetailProvider>(context,
                                listen: false)
                            .setHeroTag = favouriteList[index].pictureId;

                        Navigator.pushNamed(context, DetailScreen.routeName);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                              )
                            ],
                            color:
                                Provider.of<ThemeProvider>(context).getDarkTheme
                                    ? Color(0xFF151515)
                                    : Colors.white,
                          ),
                          margin: EdgeInsets.only(right: 20),
                          height: 150,
                          width: 120,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Hero(
                                    tag: "newImageTag" +
                                        favouriteList[index].pictureId,
                                    child: Image.network(
                                      getSmallImage(
                                          favouriteList[index].pictureId),
                                      width: 120,
                                      height: 102,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 50,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: kRed,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(30))),
                                      child: Center(
                                          child: Icon(
                                        Icons.star,
                                        color: kWhite,
                                        size: 20,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Text(favouriteList[index].name,
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return SpinKitFadingCircle(
                color: kLightRed,
                size: 40,
              );
            }
          }),
    );
  }
}
