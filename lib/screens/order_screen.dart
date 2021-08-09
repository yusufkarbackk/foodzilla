part of 'screens.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? userId = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                      child: Text('my orders',
                          style: Theme.of(context).textTheme.headline6),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<QuerySnapshot>(
                  future: TransactionServices.getTransaction(userId!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      List<Widget> list = [];
                      final List<QueryDocumentSnapshot<Object?>> transactions =
                          snapshot.data!.docs;
                      for (var item in transactions) {
                        list.add(
                          GestureDetector(
                            onTap: () {
                              FoodzillaTransaction foodzillaTransaction =
                                  FoodzillaTransaction(
                                      userId: userId.uid,
                                      name: (item.data() as dynamic)["name"],
                                      restaurant: (item.data()
                                          as dynamic)["restaurant"],
                                      email: (item.data() as dynamic)["email"],
                                      phone: (item.data() as dynamic)["phone"],
                                      bookingCode: (item.data()
                                          as dynamic)["booking_code"],
                                      timeInMilliseccondEpoch:
                                          (item.data() as dynamic)[
                                              "time_in_milliseccondEpoch"],
                                      date: (item.data() as dynamic)["date"],
                                      time: (item.data() as dynamic)["time"]);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                          foodzillaTransaction)));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 24),
                                height: 80,
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (item.data()
                                                as dynamic)["restaurant"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  (item.data()
                                                      as dynamic)["date"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              Text(
                                                  (item.data()
                                                      as dynamic)["time"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          )
                                        ]),
                                  ),
                                )),
                          ),
                        );
                      }
                      return Column(
                        children: list,
                      );
                    } else {
                      return SpinKitFadingCircle(
                        color: kLightRed,
                        size: 40,
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
