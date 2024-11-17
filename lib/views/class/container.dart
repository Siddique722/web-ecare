import 'package:flutter/material.dart';

class ContainerClassProperty extends StatefulWidget {
  const ContainerClassProperty({super.key});

  @override
  State<ContainerClassProperty> createState() => _ContainerClassPropertyState();
}

class _ContainerClassPropertyState extends State<ContainerClassProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container( 

        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black,
        ),



      ),),
    );
  }
}