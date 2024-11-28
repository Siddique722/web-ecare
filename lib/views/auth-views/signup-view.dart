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
  final _confirmPasswordController = TextEditingController();
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
                Text('H',
                    style: TextStyle(
                      fontFamily: "GilroyBold",
                      color: AppColors.blueColor,
                      fontSize: 24.sp,
                    )),
                Text(
                  ' Pulse',
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
                        CustomPasswordFormField(
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomPasswordFormField(
                          hintText: 'Confirm Password',
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          controller: _confirmPasswordController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        _isLoading
                            ? const AppLoading()
                            : InkWell(
                          onTap:(){
                            if(_passwordController.text!=_confirmPasswordController.text)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passwords do not match'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            else
                          _signUp();

                          },
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
class CustomPasswordFormField extends StatefulWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomPasswordFormField({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomPasswordFormField> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.isPassword == true ? _isObscured : false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword == true
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null,
        hintText: widget.hintText ?? " ",
        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${widget.hintText}';
        }
        if (widget.hintText == 'Username' &&
            !RegExp(r'^[a-zA-Z]').hasMatch(value)) {
          return 'Username must start with a letter';
        }
        if (widget.hintText == 'Email' &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (widget.hintText == 'Password' && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (widget.hintText == 'Password' &&
            !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&()])[A-Za-z\d@$!%*?&]{8,}$')
                .hasMatch(value)) {
          return 'Password must contain letters, numbers, and special characters';
        }
        return null;
      },
    );
  }
}
