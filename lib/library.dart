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
    'Grey': Colors.grey,
    'Orange': Colors.orange,
    'Light Blue': Colors.lightBlue,
    'Light Brown': Colors.brown,
    'Dark Brown': Colors.brown,
    'Dark Grey': Colors.grey
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