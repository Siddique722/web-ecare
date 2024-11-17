import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5063AF) // Light blue color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(
          0, size.height * 0.4) // Start the wave at 40% of the screen height
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.2,
          size.width * 0.5, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.5, size.width, size.height * 0.35)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class SpotPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Color(0xFF2D3C80) // Dark blue color
//       ..style = PaintingStyle.fill;

//     // First dark blue spot
//     final path1 = Path()
//       ..moveTo(size.width * 0.2, size.height * 0.3)
//       ..quadraticBezierTo(size.width * 0.4, size.height * 0.1, size.width * 0.6,
//           size.height * 0.3)
//       ..quadraticBezierTo(
//           size.width * 0.8, size.height * 0.5, size.width, size.height * 0.3)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width * 0.2, 0)
//       ..close();

//     canvas.drawPath(path1, paint);

//     // Second dark blue spot
//     final path2 = Path()
//       ..moveTo(size.width * 0.2, size.height * 0.5)
//       ..quadraticBezierTo(size.width * 0.4, size.height * 0.3, size.width * 0.6,
//           size.height * 0.5)
//       ..quadraticBezierTo(
//           size.width * 0.8, size.height * 0.7, size.width, size.height * 0.5)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width * 0.2, 0)
//       ..close();

//     canvas.drawPath(path2, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class HomeScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // White background at the bottom
          Container(
            color: Color(0xFFF5F7FB), // Light background color
          ),
          // Light blue wave at the top
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),
          // Dark blue spots
          // Positioned.fill(
          //   child: CustomPaint(
          //     painter: SpotPainter(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
