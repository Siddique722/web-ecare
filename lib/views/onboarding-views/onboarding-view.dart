// import 'package:flutter/cupertino.dart';
// import '../../constants/linker.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   void _onPageChanged(int page) {
//     setState(() {
//       _currentPage = page;
//     });
//   }

//   void _nextPage() {
//     if (_currentPage < 2) {
//       _pageController.animateToPage(
//         _currentPage + 1,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   Widget _buildPageIndicator() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(3, (index) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 height: 5.0.h,
//                 width: 100.0.w,
//                 decoration: BoxDecoration(
//                   color: _currentPage == index
//                       ? AppColors.blueColor
//                       : Colors.blue.shade400.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             );
//           }),
//         ),
//         SizedBox(
//           height: 20.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('E',
//                 style: TextStyle(
//                   fontFamily: "GilroyBold",
//                   color: AppColors.blueColor,
//                   fontSize: 24.sp,
//                 )),
//             Text(
//               ' Care',
//               style: TextStyle(
//                   fontFamily: "Gilroy",
//                   color: AppColors.blueColor,
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w900),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.error,
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             onPageChanged: _onPageChanged,
//             children: [
//               _buildPage(
//                 context,
//                 title: 'Unique health ID !',
//                 description:
//                     'App lets you create a unique physcical and virtual health Id which can be carried around with all the information required in an emergency even in the absence of your relatives, including your emergency contacts',
//                 imagePath: 'lib/assets/images/pexels-rdne-6520130.jpg',

//                 //''// AppImages.onboardimage1,
//               ),
//               _buildPage(context,
//                   title: 'Making treatment safer and faster',
//                   description:
//                       'With your authentication your doctor can easily assess yours and your family members medical history including allergic medications, comorbidities, previous surgeries, etc. \n\nIt will eventually help in making decisions faster and reduce possible complications.',
//                   imagePath:
//                       'lib/assets/images/doctor.jpg' //AppImages.onboardimage2,
//                   ),
//               _buildPage(
//                 context,
//                 title: 'Single app for all your family members ',

//                 description:
//                     'You can create health ID for all your family members from a single app and can be shared remotely with their treating doctors even if you are out of station',
//                 imagePath: 'lib/assets/images/family.jpg',
//                 //''//AppImages.onboardimage3,
//               ),
//             ],
//           ),
//           Positioned(
//             top: 40.0,
//             left: 0,
//             right: 0,
//             child: _buildPageIndicator(),
//           ),
//           Positioned(
//             bottom: 20.0,
//             left: 20.0,
//             child: _currentPage != 2
//                 ? TextButton(
//                     onPressed: () {
//                       _pageController.jumpToPage(2);
//                     },
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColors.blueColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           _currentPage != 2
//               ? const SizedBox()
//               : Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 23.0, left: 26, right: 26),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Center(
//                           child: InkWell(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             CupertinoPageRoute(
//                                 builder: (context) => const LoginView()),
//                           );
//                         },
//                         child: Container(
//                           height: 50.h,
//                           width: width.w,
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: AppColors.whiteColor,
//                                     offset: const Offset(1, 1),
//                                     blurRadius: 2)
//                               ],
//                               color: AppColors.blueColor,
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Center(
//                             child: Text(
//                               'GET STARTED',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: AppColors.whiteColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//                     ],
//                   ),
//                 ),
//           Positioned(
//               bottom: 20.0,
//               right: 20.0,
//               child: _currentPage != 2
//                   ? InkWell(
//                       onTap: _nextPage,
//                       child: Container(
//                         height: 60.h,
//                         width: 60.w,
//                         child: Icon(
//                           Icons.arrow_forward,
//                           color: AppColors.whiteColor,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.blueColor,
//                           borderRadius: BorderRadius.circular(500),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blue
//                                   .withOpacity(0.5), // Blue shadow color
//                               spreadRadius: 3,
//                               blurRadius: 7,
//                               offset: const Offset(
//                                   1, 2), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Container()
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Navigator.pushReplacement(
//               //       context,
//               //       MaterialPageRoute(builder: (context) => MyHomePage()),
//               //     );
//               //   },
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: AppColors.blueColor,
//               //   ),
//               //   child: Text('Register'),
//               // ),
//               ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(BuildContext context,
//       {required String title,
//       required String description,
//       required String imagePath}) {
//     return Stack(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height, //double.infinity,
//           width: double.infinity,
//           child: Image.asset(
//             fit: BoxFit.cover,
//             imagePath,
//             height: MediaQuery.of(context).size.height,
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.only(left: 26.0, right: 26, bottom: 90),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 30.h),
//                 BoldTextWidget(
//                   textsize: 27,
//                   text: title,
//                   textColor: Colors.white,
//                 ),
//                 SizedBox(height: 10.h),
//                 SimpleTextWidget(
//                     textsize: 16, text: description, textColor: Colors.white)
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

///--------------
///
///
import 'package:flutter/cupertino.dart';
import '../../constants/linker.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildPageIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 5.0,
                width: 20.0,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.blueColor
                      : Colors.blue.shade400.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('H',
                style: TextStyle(
                  fontFamily: "GilroyBold",
                  color: AppColors.blueColor,
                  fontSize: 24.0,
                )),
            Text(
              'Pulse',
              style: TextStyle(
                  fontFamily: "Gilroy",
                  color: AppColors.blueColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.error,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildPage(
                context,
                title: 'Unique health ID !',
                description:
                    'App lets you create a unique physical and virtual health ID which can be carried around with all the information required in an emergency even in the absence of your relatives, including your emergency contacts',
                imagePath: 'lib/assets/images/pexels-rdne-6520130.jpg',
              ),
              _buildPage(context,
                  title: 'Making treatment safer and faster',
                  description:
                      'With your authentication, your doctor can easily assess yours and your family members medical history including allergic medications, comorbidities, previous surgeries, etc.\nIt will eventually help in making decisions faster and reduce possible complications.',
                  imagePath: 'lib/assets/images/doctor.jpg'),
              _buildPage(
                context,
                title: 'Single app for all your family members ',
                description:
                    'You can create health ID for all your family members from a single app and can be shared remotely with their treating doctors even if you are out of station',
                imagePath: 'lib/assets/images/family.jpg',
              ),
            ],
          ),
          Positioned(
            top: 40.0,
            left: 0,
            right: 0,
            child: _buildPageIndicator(),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: _currentPage != 2
                ? TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(2);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          _currentPage != 2
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.only(bottom: 23.0, left: 26, right: 26),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        },
                        child: Container(
                          height: 50.0,
                          width: width * 0.8, // Responsive width
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.whiteColor,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2)
                              ],
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: _currentPage != 2
                ? InkWell(
                    onTap: _nextPage,
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(500),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context,
      {required String title,
      required String description,
      required String imagePath}) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: height, // Use screen height for responsiveness
          width: width, // Use screen width for responsiveness
          child: Image.asset(
            fit: BoxFit.cover,
            imagePath,
            height: height,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: width * 0.05, right: width * 0.05, bottom: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              BoldTextWidget(
                textsize: 27.0,
                text: title,
                textColor: Colors.white,
              ),
              SizedBox(height: 10.0),
              SimpleTextWidget(
                  textsize: 16.0, text: description, textColor: Colors.white)
            ],
          ),
        ),
      ],
    );
  }
}
