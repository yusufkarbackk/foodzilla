part of 'widgets.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({Key? key}) : super(key: key);

  @override
  _FavouriteIconWidgetState createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  late bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Provider.of<FavouriteRestaurantServices>(context, listen: false)
                  .setIsfavourite =
              Provider.of<FavouriteRestaurantServices>(context, listen: false)
                  .reversedIsFavourite;
        });
        if (Provider.of<FavouriteRestaurantServices>(context, listen: false)
                .isFavourite ==
            true) {
          FavouriteRestaurantServices.addFavourite(
              Provider.of<RestaurantDetailProvider>(context, listen: false)
                  .getRestaurantDetail!,
              Provider.of<User?>(context, listen: false)!.uid);
        } else {
          FavouriteRestaurantServices.deleteFavourite(
              Provider.of<RestaurantDetailProvider>(context, listen: false)
                  .getRestaurantDetail!
                  .id,
              Provider.of<User?>(context, listen: false)!.uid);
        }
      },
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: Provider.of<FavouriteRestaurantServices>(context, listen: false)
                .isFavourite
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
