part of 'screens.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(headerSliverBuilder: (context, isScrolled) {
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
                        getLargeImage(state.getRestaurantDetail?.pictureId),
                        fit: BoxFit.fitWidth,
                      );
                    } else {
                      return Text(state.getMessage);
                    }
                  },
                )))
          ];
        }, body:
            SingleChildScrollView(child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, child) {
            if (state.getState == ResultState.Loading) {
              return SpinKitFadingCircle(
                size: 40,
                color: kLightWhite,
              );
            } else if (state.getState == ResultState.HasData) {
              List<Widget> reviewList = [];
              for (var item in state.getRestaurantDetail?.customerReviews ?? []) {
                reviewList.add(Card(
                  child: ListTile(
                    leading: Text(item.name),
                    subtitle: Text(item.review),
                  ),
                ));
              }
              return Column(children: reviewList);
            } else {
              return Text(state.getMessage);
            }
          },
        ))),
      ),
    );
  }
}
