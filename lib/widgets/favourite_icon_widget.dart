part of 'widgets.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({Key? key}) : super(key: key);

  @override
  _FavouriteIconWidgetState createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isFavourite == false) {
            isFavourite = !isFavourite;
            FavouriteRestaurantServices.addFavourite(
                Provider.of<RestaurantDetailProvider>(context, listen: false)
                    .getRestaurantDetail!,
                Provider.of<User?>(context, listen: false)!.uid);
          } else {
            setState(() {
              isFavourite = !isFavourite;
              FavouriteRestaurantServices.deleteFavourite(
                  Provider.of<RestaurantDetailProvider>(context, listen: false)
                      .getRestaurantDetail!
                      .id);
            });
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
