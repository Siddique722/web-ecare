// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SimpleTextWidget extends StatelessWidget {
//   String text;
//   double textsize;
//   Color textColor;
//   SimpleTextWidget(
//       {super.key,
//       this.textsize = 14,
//       required this.text,
//       required this.textColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: TextAlign.start,
//       style: TextStyle(
//         fontFamily: 'Gilroy',
//         color:
//             textColor, //Theme.of(context).colorScheme.primary.withOpacity(0.5),
//         fontSize: textsize.sp,
//       ),
//     );
//   }
// }
//
// class SimpleTextWidgetTheme extends StatelessWidget {
//   String text;
//   double textsize;
//
//   SimpleTextWidgetTheme({
//     super.key,
//     this.textsize = 14,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: TextAlign.start,
//       style: TextStyle(
//         fontFamily: 'Gilroy',
//         color: Theme.of(context).colorScheme.primary,
//         fontSize: textsize.sp,
//       ),
//     );
//   }
// }
//
// // class BoldTextWidgetTheme extends StatelessWidget {
// //   String text;
// //   double textsize;
//
// //   BoldTextWidgetTheme({
// //     super.key,
// //     this.textsize = 24,
// //     required this.text,
// //   });
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       text,
// //       textAlign: TextAlign.start,
// //       style: TextStyle(
// //         fontFamily: 'GilroyBold',
// //         color: Theme.of(context).colorScheme.primary,
// //         fontSize: textsize.sp,
// //         fontWeight: FontWeight.w600,
// //       ),
// //     );
// //   }
// // }
// class BoldTextWidgetTheme extends StatelessWidget {
//   final String text;
//   final double textsize;
//
//   BoldTextWidgetTheme({
//     super.key,
//     this.textsize = 24, // Default size for mobile
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Get screen width to adjust the text size
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // Adjust the text size based on the screen width
//     double responsiveTextSize = textsize;
//
//     if (screenWidth > 1200) {
//       // For large screens (desktop/web), increase the text size
//       responsiveTextSize = textsize * 1.5;
//     } else if (screenWidth > 800) {
//       // For medium screens (tablets/large phones)
//       responsiveTextSize = textsize * 1.2;
//     }
//
//     return Text(
//       text,
//       textAlign: TextAlign.start,
//       style: TextStyle(
//         fontFamily: 'GilroyBold',
//         color: Theme.of(context).colorScheme.primary,
//         fontSize: responsiveTextSize, // Use the responsive text size
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }
//
// class BoldTextWidget extends StatelessWidget {
//   final String text;
//   final Color textColor;
//   final double textsize;
//   final TextOverflow? overflow;
//
//   const BoldTextWidget({
//     Key? key,
//     required this.text,
//     required this.textColor,
//     required this.textsize,
//     this.overflow,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         color: textColor,
//         fontWeight: FontWeight.bold,
//         fontSize: textsize,
//       ),
//       overflow: overflow ?? TextOverflow.ellipsis, // Default behavior
//     );
//   }
// }
//
// // class BoldTextWidget extends StatelessWidget {
// //   String text;
// //   double textsize;
// //   Color textColor;
// //   BoldTextWidget({super.key,
// //    this.textsize=24,
// //      required this.text,
// //      required this.textColor
// //    });
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return  Text(
// //       text,
// //       textAlign: TextAlign.start,
// //       style: TextStyle(
// //         fontFamily: 'GilroyBold',
// //         color: Theme.of(context).colorScheme.primary,
// //         fontSize: textsize.sp,
// //         fontWeight: FontWeight.w600,
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleTextWidget extends StatelessWidget {
  final String text;
  final double baseTextSize; // Base size for mobile
  final Color textColor;

  const SimpleTextWidget({
    super.key,
    this.baseTextSize = 14,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double responsiveTextSize = baseTextSize;
    if (screenWidth > 1200) {
      // Desktop/Web: Increase size by 50%
      responsiveTextSize = baseTextSize * 1.5;
    } else if (screenWidth > 600) {
      // Tablet: Increase size by 20%
      responsiveTextSize = baseTextSize * 1.2;
    }

    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'Gilroy',
        color: textColor,
        fontSize: responsiveTextSize.sp, // Use ScreenUtil for scaling
      ),
    );
  }
}

class SimpleTextWidgetTheme extends StatelessWidget {
  final String text;
  final double baseTextSize; // Base size for mobile

  const SimpleTextWidgetTheme({
    super.key,
    this.baseTextSize = 14,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double responsiveTextSize = baseTextSize;
    if (screenWidth > 1200) {
      // Desktop/Web: Increase size by 50%
      responsiveTextSize = baseTextSize * 1.5;
    } else if (screenWidth > 600) {
      // Tablet: Increase size by 20%
      responsiveTextSize = baseTextSize * 1.2;
    }

    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'Gilroy',
        color: Theme.of(context).colorScheme.primary,
        fontSize: responsiveTextSize.sp, // Use ScreenUtil for scaling
      ),
    );
  }
}

class BoldTextWidgetTheme extends StatelessWidget {
  final String text;
  final double baseTextSize; // Base size for mobile

  const BoldTextWidgetTheme({
    super.key,
    this.baseTextSize = 24, // Default size for mobile
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double responsiveTextSize = baseTextSize;
    if (screenWidth > 1200) {
      // Desktop/Web: Increase size by 50%
      responsiveTextSize = baseTextSize * 1.5;
    } else if (screenWidth > 600) {
      // Tablet: Increase size by 20%
      responsiveTextSize = baseTextSize * 1.2;
    }

    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'GilroyBold',
        color: Theme.of(context).colorScheme.primary,
        fontSize: responsiveTextSize.sp, // Use ScreenUtil for scaling
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class BoldTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double baseTextSize; // Base size for mobile
  final TextOverflow? overflow;

  const BoldTextWidget({
    Key? key,
    required this.text,
    required this.textColor,
    this.baseTextSize = 24,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double responsiveTextSize = baseTextSize;
    if (screenWidth > 1200) {
      // Desktop/Web: Increase size by 50%
      responsiveTextSize = baseTextSize * 1.5;
    } else if (screenWidth > 600) {
      // Tablet: Increase size by 20%
      responsiveTextSize = baseTextSize * 1.2;
    }

    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: responsiveTextSize.sp, // Use ScreenUtil for scaling
      ),
      overflow: overflow ?? TextOverflow.ellipsis, // Default behavior
    );
  }
}