part of 'screens.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: FaIcon(FontAwesomeIcons.arrowLeft))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.checkCircle,
                      color: kLightRed,
                      size: 180,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Congratulations! Your booking was successful",
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                            "Your booking detail is available in Booking Detail Screen")
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: kRed),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen()));
                            },
                            child: Center(
                              child: Text(
                                'Booking Detail',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: kWhite),
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CurrentScreen()));
                            },
                            child: Center(
                              child: Text("Home screen"),
                            ))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
