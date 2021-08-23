import 'dart:math';

import 'package:flagscoloring_pixelart/World.dart';
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
                child: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: getContinents()
                    )
                )
            )
        );
    }

    Row getContinents() {
        List<Widget> continents = [];

        continents.add(SizedBox(width: 20));
        continents.add(getContinent(Continent(title: 'World')));
        World.continents.forEach((continent) {
            continents.add(getContinent(continent));
        });
        continents.add(SizedBox(width: 20));

        return Row(children: continents);
    }

    getContinent(Continent continent) {
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
                                                            getEasyText(continent),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        getEasyStar(continent)
                                                    ]
                                                ),
                                                Column(
                                                    children: [
                                                        Text(
                                                            getNormalText(continent),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        getNormalStar(continent)
                                                    ]
                                                ),
                                                Column(
                                                    children: [
                                                        Text(
                                                            getTotalText(continent),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        SizedBox(height: 10),
                                                        getTotalStars(continent)
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
                                        child: getPicture(continent)
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
                                                message: continent.title,
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
                                                        continent.title,
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
                                            getTotalSolvedCountriesText(continent),
                                            style: TextStyle(
                                                color: AppTheme.THIRD_COLOR,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10
                                            )
                                        )
                                    )
                                )
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: getStars(continent)
                                )
                            )
                        ]
                    )
                ]
            )
        );
    }

    String getEasyText(Continent continent) {
        if (continent.title == 'World') {
            return 'Easy: ${World.totalEasySolvedCountries}/${World.totalCountries}';
        } else {
            return 'Easy: ${continent.totalEasySolvedStars}/${continent.countries.length}';
        }
    }

    String getNormalText(Continent continent) {
        if (continent.title == 'World') {
            return 'Normal: ${World.totalNormalSolvedCountries}/${World.totalCountries}';
        } else {
            return 'Normal: ${continent.totalNormalSolvedStars}/${continent.countries.length}';
        }
    }

    String getTotalText(Continent continent) {
        if (continent.title == 'World') {
            return 'Total: ${World.totalSolvedStars }/${World.totalStars}';
        } else {
            return 'Total: ${continent.totalSolvedStars}/${continent.totalStars}';
        }
    }

    String getTotalSolvedCountriesText(Continent continent) {
        if (continent.title == 'World') {
            return '${World.totalSolvedCountries}/${World.totalCountries}';
        } else {
            return '${continent.totalSolvedCountries}/${continent.countries.length}';
        }
    }

    SvgPicture getPicture(Continent continent) {
        return SvgPicture.asset(
            'assets/svg/${continent.title == 'World' ? 'World' : continent.title}.svg',
            height: MediaQuery.of(context).size.height - 100,
            fit: BoxFit.contain
        );
    }

    getEasyStar(Continent continent) {
        if (continent.title == 'World') {
            return World.isEasySolved ? Star(height: 20) : SizedBox(height: 20);
        } else {
            return continent.isEasySolved ? Star(height: 20) : SizedBox(height: 20);
        }
    }

    getNormalStar(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Star(height: 20) : SizedBox(height: 20);
        } else {
            return continent.isNormalSolved ? Star(height: 20) : SizedBox(height: 20);
        }
    }

    getTotalStars(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 20),
                    SizedBox(width: 10),
                    Star(height: 20)
                ]
            ) : World.isEasySolved ? Star(height: 20) : SizedBox();
        } else {
            return continent.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 20),
                    SizedBox(width: 10),
                    Star(height: 20)
                ]
            ) : continent.isEasySolved ? Star(height: 20) : SizedBox(height: 20);
        }
    }

    getStars(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(),
                    SizedBox(width: 20),
                    Star()
                ]
            ) : World.isEasySolved ? Star() : SizedBox.shrink();
        } else {
            return continent.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(),
                    SizedBox(width: 20),
                    Star()
                ]
            ) : continent.isEasySolved ? Star() : SizedBox.shrink();
        }
    }
}

class Statistics extends StatefulWidget {

	@override
	State createState() => StatisticsState();
}