import 'package:flutter/material.dart';


class AddInfo extends StatelessWidget {
  const AddInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.water_drop, size: 32,),
        SizedBox(height: 8,),
        Text('Humidity'),
        SizedBox(height: 8,),
        Text('91', style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
      ],
    );
  }
}
