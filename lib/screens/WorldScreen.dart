import 'package:flagscoloring_pixelart/library.dart';
import 'package:flagscoloring_pixelart/screens/ContinentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            AppTheme.MAIN_COLOR,
                            Color(0xFF085F5F)
                        ]
                    ),
                    image: DecorationImage(
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                        image: AssetImage("assets/world.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: [
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Text(
                                '3/44',
                                style: TextStyle(
                                    color: AppTheme.THIRD_COLOR,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                )
                            )
                        ),
                        Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: [
                                        SizedBox(width: 20),
                                        getContinent('Europe'),
                                        getContinent('Africa'),
                                        getContinent('North America'),
                                        SizedBox(width: 20),
                                    ]
                                )
                            )
                        )
                    ]
                )
            )
        );
    }

    getContinent(String continentTitle) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
                children: [
                    Container(
                        height: MediaQuery.of(context).size.height - 135,
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        child: Card(
                            color: AppTheme.SECONDARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0)
                                ),
                                onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ContinentScreen(continentTitle: continentTitle)
                                        )
                                    )
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height - 150,
                                    width: MediaQuery.of(context).size.height - 150,
                                    child: SvgPicture.asset(
                                        'assets/svg/$continentTitle.svg',
                                        height: MediaQuery.of(context).size.height - 100,
                                        fit: BoxFit.contain
                                    )
                                )
                            )
                        )
                    ),
                    Positioned(
                        top: 20,
                        right: 40,
                        child: Card(
                            color: AppTheme.MAIN_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Container(
                                padding: EdgeInsets.only(left: 20, right: 30),
                                height: 35,
                                child: Center(
                                    child: Text(
                                        continentTitle,
                                        style: TextStyle(
                                            color: AppTheme.THIRD_COLOR,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                )
                            )
                        )
                    ),
                    Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: AppTheme.MAIN_COLOR,
                                shape: BoxShape.circle
                            ),
                            child: Center(
                                child: Text(
                                    '3/44',
                                    style: TextStyle(
                                        color: AppTheme.THIRD_COLOR,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                            )
                        )
                    ),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Star(),
                                    SizedBox(width: 20),
                                    Star()
                                ]
                            )
                        )
                    )
                ]
            )
        );
    }
}

class World extends StatefulWidget {

	@override
	State createState() => WorldState();
}