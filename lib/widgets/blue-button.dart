

import 'package:ecare/constants/colors.dart';
import 'package:ecare/constants/linker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlueButton extends StatelessWidget {
  String text;
  double width;
  Color shadow;
  double fontSize;
  BlueButton({super.key, required this.text, this.width = 320,  this.shadow=Colors.white,
  this.fontSize=17,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: width.w,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: shadow, offset: Offset(1, 1), blurRadius: 2)
      ], color: AppColors.blueColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
