part of 'screens.dart';

class OrderDetailScreen extends StatelessWidget {
  final FoodzillaTransaction transaction;

  OrderDetailScreen(this.transaction);

  @override
  Widget build(BuildContext context) {
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
                      child: Text('My Order Detail',
                          style: Theme.of(context).textTheme.headline6),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(transaction.restaurant),
                  Text(transaction.name),
                  Text(transaction.email),
                  Text(transaction.date),
                  Text(transaction.time),
                ],
              ),
              Text(
                "Booking Code: ${transaction.restaurant}",
                textAlign: TextAlign.center,
              ),
              Text("Please show the booking code to the restaurant's waiter")
            ],
          ),
        ),
      ),
    );
  }
}
