part of 'screens.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  DetailScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    List<String> foodList = [];
    for (var item in restaurant.menus.foods) {
      foodList.add(item.name);
    }
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                      children: [
                        Image.network(
                          restaurant.imageURL,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xCC000000),
                                const Color(0x00000000),
                                const Color(0x00000000),
                                const Color(0xCC000000),
                              ],
                            ),
                          ),
                        )
                      ],
                    )))
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant.name,
                            style: Theme.of(context).textTheme.headline5),
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
                            Text('${restaurant.rating}/5',
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
                          Text(restaurant.city,
                              style: Theme.of(context).textTheme.subtitle1),
                          GestureDetector(
                            child: Text('Navigate to this Restaurant',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: kLightRed,
                                        decoration: TextDecoration.underline)),
                          )
                        ],
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(restaurant.desc,
                          style: Theme.of(context).textTheme.caption)),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('Top Cuisine'), Text(foodList[0])],
                          )
                        ],
                      ))
                ],
              ),
            )));
  }
}
