import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleTextWidget extends StatelessWidget {
  String text;
  double baseTextSize;
  Color textColor;
  SimpleTextWidget(
      {super.key,
      this.baseTextSize = 14,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'Gilroy',
        color:
            textColor, //Theme.of(context).colorScheme.primary.withOpacity(0.5),
        fontSize: baseTextSize,
      ),
    );
  }
}

class SimpleTextWidgetTheme extends StatelessWidget {
  String text;
  double baseTextSize;

  SimpleTextWidgetTheme({
    super.key,
    this.baseTextSize = 14,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'Gilroy',
        color: Theme.of(context).colorScheme.primary,
        fontSize: baseTextSize,
      ),
    );
  }
}

class BoldTextWidgetTheme extends StatelessWidget {
  String text;
  double baseTextSize;

  BoldTextWidgetTheme({
    super.key,
    this.baseTextSize = 24,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'GilroyBold',
        color: Theme.of(context).colorScheme.primary,
        fontSize: baseTextSize.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
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

class BoldTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double baseTextSize;
  final TextOverflow? overflow;

  const BoldTextWidget({
    Key? key,
    required this.text,
    required this.textColor,
    required this.baseTextSize,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: baseTextSize,
      ),
      overflow: overflow ?? TextOverflow.ellipsis, // Default behavior
    );
  }
}

// class BoldTextWidget extends StatelessWidget {
//   String text;
//   double textsize;
//   Color textColor;
//   BoldTextWidget({super.key,
//    this.textsize=24,
//      required this.text,
//      required this.textColor
//    });

//   @override
//   Widget build(BuildContext context) {
//     return  Text(
//       text,
//       textAlign: TextAlign.start,
//       style: TextStyle(
//         fontFamily: 'GilroyBold',
//         color: Theme.of(context).colorScheme.primary,
//         fontSize: textsize.sp,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }
