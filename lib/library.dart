import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum GameMode { EASY, NORMAL }

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