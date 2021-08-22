import 'dart:math';

import 'package:flagscoloring_pixelart/library.dart';
import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticsScreen extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
        return Statistics();
	}
}

class StatisticsState extends State<Statistics> {
    String backgroundImage = "assets/continents_background/${CONTINENTS[Random().nextInt(CONTINENTS.length)]}.png";

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
                        image: AssetImage(backgroundImage),
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
                                        getContinent('Africa'),
                                        getContinent('Europe'),
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
                    Card(
                        color: AppTheme.CARD_EXPAND,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height - 150,
                            width: MediaQuery.of(context).size.height,
                            child: Row(
                                children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        height: MediaQuery.of(context).size.height - 150,
                                        width: MediaQuery.of(context).size.height - 150
                                    ),
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                Column(
                                                    children: [
                                                        Text(
                                                            'Easy: 2/50',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        Star(height: 20)
                                                    ]
                                                ),
                                                Column(
                                                    children: [
                                                        Text(
                                                            'Normal: 1/50',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        Star(height: 20)
                                                    ]
                                                ),
                                                Column(
                                                    children: [
                                                        Text(
                                                            'Total: 3/50',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                                Star(height: 20),
                                                                SizedBox(width: 10),
                                                                Star(height: 20)
                                                            ]
                                                        )
                                                    ]
                                                )
                                            ]
                                        )
                                    )
                                ]
                            )
                        )
                    ),
                    Stack(
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
                            ),
                            Positioned(
                                top: 20,
                                right: 40,
                                child: Card(
                                    color: AppTheme.MAIN_COLOR,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Row(
                                        children: [
                                            Tooltip(
                                                message: continentTitle,
                                                preferBelow: false,
                                                verticalOffset: 40,
                                                showDuration: Duration(milliseconds: 500),
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    height: 35,
                                                    constraints: BoxConstraints(maxWidth: 150),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                    child: Text(
                                                        continentTitle,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: AppTheme.THIRD_COLOR,
                                                            fontWeight: FontWeight.bold
                                                        )
                                                    )
                                                )
                                            )
                                        ]
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
                ]
            )
        );
    }
}

class Statistics extends StatefulWidget {

	@override
	State createState() => StatisticsState();
}