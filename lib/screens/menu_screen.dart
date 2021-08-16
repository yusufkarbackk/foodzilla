part of 'screens.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> foodList = [];

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
                        Consumer<RestaurantDetailProvider>(
                          builder: (context, state, child) {
                            if (state.getState == ResultState.Loading) {
                              return SpinKitFadingCircle(
                                size: 40,
                                color: kLightWhite,
                              );
                            } else if (state.getState == ResultState.HasData) {
                              for (var item
                                  in state.getRestaurantDetail?.menus.foods ??
                                      []) {
                                foodList.add(Text(item.name));
                              }
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: foodList);
                            } else {
                              return Text(state.getMessage);
                            }
                          },
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text('Drinks',
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 12,
                        ),
                        Consumer<RestaurantDetailProvider>(
                          builder: (context, state, child) {
                            if (state.getState == ResultState.Loading) {
                              return SpinKitFadingCircle(
                                size: 40,
                                color: kLightWhite,
                              );
                            } else if (state.getState == ResultState.HasData) {
                              for (var item
                                  in state.getRestaurantDetail?.menus.drinks ??
                                      []) {
                                drinkList.add(Text(item.name));
                              }
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: drinkList);
                            } else {
                              return Text(state.getMessage);
                            }
                          },
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
