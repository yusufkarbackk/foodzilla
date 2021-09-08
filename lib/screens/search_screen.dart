part of 'screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<RestaurantDetail> restaurantList = [];
  List<RestaurantDetail> tempRestaurantList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            margin: EdgeInsets.only(top: 50),
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
                  child: Text('Search Restaurant',
                      style: Theme.of(context).textTheme.headline6),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Consumer<ThemeProvider>(
                builder: (context, theme, _) {
                  return TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search Restaurants here",
                      hintStyle: TextStyle(
                          color: theme.getDarkTheme ? Colors.white : kDarkRed),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (text) {
                      _filterRestaurant(text);
                    },
                  );
                },
              )),
          Expanded(
            child: Center(
                child: isLoading
                    ? SpinKitFadingCircle(
                        size: 40,
                        color: kLightRed,
                      )
                    : ListView.builder(
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Provider.of<RestaurantDetailProvider>(context,
                                      listen: false)
                                  .fetchRestaurantDetail(
                                      restaurantList[index].id);

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
                                          getSmallImage(
                                              restaurantList[index].pictureId ??
                                                  "-"),
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(restaurantList[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                restaurantList[index].city,
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
                                                  Text(
                                                      '${restaurantList[index].rating}/5')
                                                ],
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        })),
          )
        ],
      )),
    );
  }

  _filterRestaurant(String text) {
    List<RestaurantDetail> result = [];
    if (text.isEmpty) {
      setState(() {
        restaurantList = tempRestaurantList;
      });
    } else {
      result = restaurantList
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()) ||
              element.menus.foods.any((element) =>
                  element.name.toLowerCase().contains(text.toLowerCase())))
          .toList();
      setState(() {
        restaurantList = result;
      });
    }
  }

  _fetchAllRestaurant() async {
    setState(() {
      isLoading = true;
    });
    List<Restaurant> tempList = await RestaurantServices.getRestaurants();

    for (var item in tempList) {
      RestaurantDetail data =
          await Provider.of<RestaurantDetailProvider>(context, listen: false)
              .fetchRestaurantDetail(item.id);
      tempRestaurantList.add(data);
    }
    print("success fetch");

    setState(() {
      restaurantList = tempRestaurantList;
      isLoading = false;
    });
  }
}
