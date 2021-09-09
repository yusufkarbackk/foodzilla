part of 'screens.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLogin = false;
  late bool isEmailValid = true;
  late bool isPasswordValid = true;
  late bool isNameValid = true;
  late bool isPhoneValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                    height: 200,
                    width: 200,
                    //NOTE: ADD LOGO
                    child: Image.asset('assets/foodzilla_red.png')),
                Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            errorText:
                                isNameValid ? null : 'Please enter your name',
                            errorStyle: TextStyle(color: Colors.redAccent),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            hintText: 'Enter your name',
                            labelText: 'Name',
                            labelStyle: TextStyle(color: kDarkWhite),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkWhite))),
                        onChanged: (text) {
                          setState(() {
                            isNameValid = nameController.text.length > 0;
                          });
                        },
                      ),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            filled: true,
                            errorText: isPhoneValid
                                ? null
                                : 'Please enter your phone number',
                            errorStyle: TextStyle(color: Colors.redAccent),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            hintText: 'Enter your phone number',
                            labelText: 'Phone number',
                            labelStyle: TextStyle(color: kDarkWhite),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkWhite))),
                        onChanged: (text) {
                          setState(() {
                            isPhoneValid = phoneController.text.length == 12;
                          });
                        },
                      ),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            errorText:
                                isEmailValid ? null : 'Please enter your emain',
                            errorStyle: TextStyle(color: Colors.redAccent),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            labelStyle: TextStyle(color: kDarkWhite),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        onChanged: (text) {
                          setState(() {
                            isEmailValid = EmailValidator.validate(text);
                          });
                        },
                      ),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            errorText: isPasswordValid
                                ? null
                                : 'Please enter your password(minimum 6 characters)',
                            errorStyle: TextStyle(color: Colors.redAccent),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            labelStyle: TextStyle(color: kDarkWhite),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkWhite))),
                        onChanged: (text) {
                          setState(() {
                            isPasswordValid =
                                passwordController.text.length >= 6;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: isLogin
                      ? SpinKitFadingCircle(
                          color: kLightRed,
                          size: 50,
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          child: FloatingActionButton(
                            backgroundColor: kDarkRed,
                            onPressed: () async {
                              setState(() {
                                isLogin = true;
                              });

                              if (emailController.text.length == 0 &&
                                  passwordController.text.length == 0 &&
                                  nameController.text.length == 0 &&
                                  phoneController.text.length == 0) {
                                setState(() {
                                  isLogin = false;
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Please fill all the fields",
                                )..show(context);
                              } else if (nameController.text.length == 0) {
                                //NOTE: EMAIL ERROR
                                setState(() {
                                  isLogin = false;
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Please enter your name",
                                )..show(context);
                              } else if (phoneController.text.length == 0) {
                                //NOTE: PASSWORD ERROR
                                setState(() {
                                  isLogin = false;
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Please enter your phone number",
                                )..show(context);
                              } else if (emailController.text.length == 0) {
                                //NOTE: NAME ERROR
                                setState(() {
                                  isLogin = false;
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Please enter your email",
                                )..show(context);
                              } else if (passwordController.text.length == 0) {
                                //NOTE: PHONE ERROR
                                setState(() {
                                  isLogin = false;
                                });
                                Flushbar(
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: "Please enter your password",
                                )..show(context);
                              } else {
                                int? phoneNumber =
                                    int.tryParse(phoneController.text);
                                AuthResult result = await AuthServices.signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneNumber);
                                if (result.message != null) {
                                  Flushbar(
                                    duration: Duration(seconds: 2),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message: result.message,
                                  )..show(context);
                                  setState(() {
                                    isLogin = false;
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CurrentScreen()));
                                }
                              }
                            },
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.white,
                              ),
                            ),
                          )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
