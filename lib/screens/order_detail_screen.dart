part of 'screens.dart';

class OrderDetailScreen extends StatelessWidget {
  final FoodzillaTransaction transaction;

  OrderDetailScreen(this.transaction);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                        child: Text('My Order Detail',
                            style: Theme.of(context).textTheme.headline6),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 180,
                  width: 180,
                  child: Image.asset('assets/foodzilla_red.png')
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama restoran: ${transaction.restaurant}',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text(
                        'Atas nama: ${transaction.name}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Email: ${transaction.email}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Booking untuk tanggal: ${transaction.date}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Pada waktu: ${transaction.time}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "Booking Code: ${transaction.bookingCode}",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                Text("Please show the booking code to the restaurant's waiter",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 16,),
                Text("Booking code: ${transaction.bookingCode}",
                    style: Theme.of(context).textTheme.headline5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
