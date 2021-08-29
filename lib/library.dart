import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum GameMode { EASY, NORMAL }

enum Shape { BLOCK, COLUMN, ROW }
const List<Shape> shapes = [Shape.BLOCK, Shape.COLUMN, Shape.ROW];

const Map<String, Color> mapColors = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Black': Colors.black,
    'White': Colors.white,
    'Yellow': Colors.yellow,
    'Brown': Colors.brown,
    'Grey': Color(0xFFE1E3E3),
    'Orange': Colors.orange,
    'Light Blue': Color(0Xff87C0EA),
    'Light Brown': Color(0xFFD9BB7B),
    'Dark Grey': Color(0xFF626361),
    'Purple': Colors.purple
};

const List<String> COLORS = [];

class Star extends StatelessWidget {
    final double height;
    
    Star({this.height = 30});

    @override
    Widget build(BuildContext context) {
        return SvgPicture.asset(
            'assets/star.svg',
            height: height
        );
    }
}