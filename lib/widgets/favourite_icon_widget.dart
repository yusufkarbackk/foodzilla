part of 'widgets.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({Key? key}) : super(key: key);

  @override
  _FavouriteIconWidgetState createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Provider.of<FavouriteRestaurantServices>(context, listen: false)
                .isFavourite ==
            true) {
          FavouriteRestaurantServices.deleteFavourite(
              Provider.of<RestaurantDetailProvider>(context, listen: false)
                  .getRestaurantDetail
                  ?.id,
              Provider.of<User?>(context, listen: false)?.uid);
        } else {
          FavouriteRestaurantServices.addFavourite(
              Provider.of<RestaurantDetailProvider>(context, listen: false)
                  .getRestaurantDetail,
              Provider.of<User?>(context, listen: false)?.uid);
        }

        setState(() {
          Provider.of<FavouriteRestaurantServices>(context, listen: false)
                  .setIsfavourite =
              Provider.of<FavouriteRestaurantServices>(context, listen: false)
                  .reversedIsFavourite;
        });
      },
      child: CircleAvatar(
          backgroundColor: kWhite,
          child: Consumer<FavouriteRestaurantServices>(
            builder: (context, state, child) {
              if (state.isFavourite == true) {
                return Icon(Icons.favorite);
              } else {
                return Icon(Icons.favorite_border_outlined);
              }
            },
          )),
    );
  }
}
