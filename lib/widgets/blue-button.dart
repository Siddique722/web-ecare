

import 'package:ecare/constants/colors.dart';
import 'package:ecare/constants/linker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlueButton extends StatelessWidget {
  String text;
  double width;
  Color shadow;
  BlueButton({super.key, required this.text, this.width = 320,  this.shadow=Colors.white});

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
            fontSize: 17,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
