import 'package:ecare/constants/linker.dart';
import 'package:ecare/views/auth-views/login-view.dart';
import 'package:flutter/cupertino.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('UsersData')
            .doc(user.email)
            .set({
          'userEmail': user.email,
          'userId': user.uid,
          'userName': _usernameController.text,
        });
      }

      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const WraperScreen()));
    } catch (e) {
      print('Error:$e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1581159186721-b68b78da4ec9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxtZWRpY2luZXxlbnwwfHx8fDE3MTYwMDg3OTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 100.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('E',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: 24.sp,
                    )),
                Text(
                  ' Care',
                  style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.blueColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 90.h,
            ),
            child: Container(
              height: 700.h, //double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Register',
                            style: TextStyle(
                              fontFamily: "GilroyBold",
                              color: AppColors.blueColor,
                              fontSize: 24.sp,
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text('Let\'s get started by filling out the form below',
                            style: TextStyle(
                              fontFamily: "GilroyBold",
                              color: AppColors.blueColor,
                              fontSize: 14.sp,
                            )),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          hintText: 'Username',
                          keyboardType: TextInputType.text,
                          controller: _usernameController,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        _isLoading
                            ? const AppLoading()
                            : InkWell(
                          onTap: _signUp,
                          child: BlueButton(text: 'Signup'),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: TextStyle(
                                  fontFamily: "GilroyBold",
                                  color: AppColors.blueColor,
                                  fontSize: 14.sp,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const LoginView()));
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                    fontFamily: "GilroyBold",
                                    color: AppColors.blueColor,
                                    fontSize: 17.sp,
                                  )),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
