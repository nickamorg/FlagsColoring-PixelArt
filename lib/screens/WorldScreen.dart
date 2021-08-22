import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';

class WorldScreen extends StatelessWidget {

    WorldScreen({ Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
        return World();
	}
}

class WorldState extends State<World> {

	@override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    color: AppTheme.MAIN_COLOR,
                    image: DecorationImage(
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                        image: AssetImage("assets/world.png"),
                        fit: BoxFit.cover
                    )
                )
            )
        );
    }
}

class World extends StatefulWidget {

	@override
	State createState() => WorldState();
}