part of 'widgets.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
        future: RestaurantServices.getRestaurants(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return Text('Error: ${snapshots.error}');
          } else if (snapshots.hasData) {
            var items = snapshots.data!;
            var list = items
                .map((e) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Card(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              e.imageURL,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(e.city, style: Theme.of(context).textTheme.overline,),
                                  SizedBox(height: 5,),
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