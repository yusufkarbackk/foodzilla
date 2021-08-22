part of 'screens.dart';

class CurrentScreen extends StatefulWidget {
  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  late int pageIndex;
  @override
  // ignore: must_call_super
  void initState() {
    pageIndex = 0;
  }

  List<Widget> screenList = [
    HomeScreen(),
    OrderScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kDarkRed,
        selectedItemColor: kLightWhite,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.receipt), label: 'my Order'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
