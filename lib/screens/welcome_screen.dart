part of 'screens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ignore: deprecated_member_use
              TypewriterAnimatedTextKit(
                  text: ['FOODZILLA'],
                  textStyle: TextStyle(color: kLightRed, fontSize: 46)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kRed),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: kWhite),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text('Sign Up',
                          style: Theme.of(context).textTheme.button),
                    )
                  ],
                ),
              ) //NOTE: ADD IMAGE
            ],
          ),
        ),
      ),
    );
  }
}
