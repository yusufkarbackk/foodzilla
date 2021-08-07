part of 'screens.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int pageIndex;
  @override
  // ignore: must_call_super
  void initState() {
    pageIndex = 0;
  }

  List<Widget> screenList = [
    OverviewScreen(),
    MenuScreen(),
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
            icon: Icon(Icons.info_outline_rounded),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: 'Menu'),
        ],
      ),
    );
  }
}
