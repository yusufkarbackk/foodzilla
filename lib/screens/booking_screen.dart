part of 'screens.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    UserServices user = Provider.of<UserServices>(context);
    User? userId = Provider.of<User?>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                      child: Text('Booking',
                          style: Theme.of(context).textTheme.headline6),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
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
                              restaurantProvider.restaurant.imageURL,
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
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(restaurantProvider.restaurant.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    restaurantProvider.restaurant.city,
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                  Text(restaurantProvider.restaurant.openHour),
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
                                          '${restaurantProvider.restaurant.rating}/5')
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('Name: ${user.foodzillaUser.name}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('Name: ${user.foodzillaUser.email}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('Name: ${user.foodzillaUser.phone}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              SizedBox(
                height: 18,
              ),
              DateTimeWidget(),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                    onPressed: () async {
                      var rnd = new Random();
                      var next = rnd.nextDouble() * 1000000;
                      while (next < 100000) {
                        next *= 10;
                      }
                      int code = next.toInt();
                      FoodzillaTransaction transaction = FoodzillaTransaction(
                          userId: userId!.uid,
                          name: user.foodzillaUser.name,
                          restaurant: restaurantProvider.restaurant.name,
                          email: user.foodzillaUser.email,
                          phone: user.foodzillaUser.phone,
                          bookingCode: code,
                          timeInMilliseccondEpoch:
                              DateTime.now().millisecondsSinceEpoch,
                          date: Provider.of<DateTimeProvider>(context,
                                  listen: false)
                              .getDate,
                          time: Provider.of<DateTimeProvider>(context,
                                  listen: false)
                              .getTime);
                      await TransactionServices.storeTransaction(
                          transaction, userId.uid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentScreen()));
                    },
                    child: Center(
                      child: Text('Book Now',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: kWhite)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
