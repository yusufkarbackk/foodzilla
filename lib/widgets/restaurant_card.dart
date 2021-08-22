part of 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantId;
  final String imageURL;
  final String name;
  final String city;
  final double rating;

  RestaurantCard(
      {required this.restaurantId,
      required this.imageURL,
      required this.name,
      required this.city,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<RestaurantDetailProvider>(context, listen: false)
            .fetchRestaurantDetail(restaurantId);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailScreen()));
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      getSmallImage(imageURL),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Theme.of(context).textTheme.subtitle1),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          city,
                          style: Theme.of(context).textTheme.overline,
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
                            Text('$rating/5')
                          ],
                        )
                      ]),
                ),
              )
            ],
          )),
    );
  }
}
