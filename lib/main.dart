import 'package:flutter/material.dart';
import 'package:map_intigration/home_screen.dart';

void main(){
  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
