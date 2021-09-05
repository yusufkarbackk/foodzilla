part of 'screens.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

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
          ],
        ),
      ),
    ));
  }
}
