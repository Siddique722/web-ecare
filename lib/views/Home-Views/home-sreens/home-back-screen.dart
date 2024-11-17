
import 'package:ecare/constants/linker.dart';

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      //width: double.infinity,
      child: const Image(
        image: AssetImage('lib/assets/images/Frame1.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}
