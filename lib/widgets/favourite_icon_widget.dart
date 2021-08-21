part of 'widgets.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({Key? key}) : super(key: key);

  @override
  _FavouriteIconWidgetState createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isFavourite == false) {
            Provider.of<DbProvider>(context, listen: false).addNote(
                Provider.of<RestaurantDetailProvider>(context, listen: false)
                    .getRestaurantDetail!);
          } else {
            Provider.of<DbProvider>(context, listen: false).deleteRestaurant(
                Provider.of<RestaurantDetailProvider>(context, listen: false)
                    .getRestaurantDetail!
                    .id);
          }
        });
      },
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: isFavourite
            ? CircleAvatar(
                backgroundColor: kWhite,
                child: Icon(
                  Icons.favorite,
                ),
              )
            : CircleAvatar(
                backgroundColor: kWhite,
                child: Icon(
                  Icons.favorite_border_outlined,
                ),
              ),
      ),
    );
  }
}
