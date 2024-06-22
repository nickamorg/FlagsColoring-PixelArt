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
                        image: AssetImage('assets/world.png'),
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
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.height + 75,
                            child: Row(
                                children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        height: MediaQuery.of(context).size.height - 100,
                                        width: MediaQuery.of(context).size.height - 100
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
                                height: MediaQuery.of(context).size.height - 80,
                                color: Colors.transparent,
                                alignment: Alignment.topCenter,
                                child: Card(
                                    color: AppTheme.SECONDARY_COLOR,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: MediaQuery.of(context).size.height - 100,
                                        width: MediaQuery.of(context).size.height - 100,
                                        child: getPicture(continent)
                                    )
                                )
                            ),
                            Positioned(
                                top: 26,
                                right: 60,
                                child: Card(
                                    color: AppTheme.MAIN_COLOR,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomLeft: Radius.circular(25)
                                        )
                                    ),
                                    child: Row(
                                        children: [
                                            Tooltip(
                                                message: continent.title,
                                                preferBelow: false,
                                                verticalOffset: 47,
                                                showDuration: Duration(milliseconds: 500),
                                                child: Container(
                                                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                                    height: 39,
                                                    constraints: BoxConstraints(maxWidth: 150),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                    child: Text(
                                                        continent.title,
                                                        style: TextStyle(
                                                            color: AppTheme.THIRD_COLOR,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12.5
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
                                    height: 70,
                                    width: 70,
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
                                                fontSize: 15
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
            return 'Total: ${World.totalSolvedStars}/${World.totalStars}';
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
            return World.isEasySolved ? Star(height: 30) : SizedBox(height: 20);
        } else {
            return continent.isEasySolved ? Star(height: 30) : SizedBox(height: 20);
        }
    }

    getNormalStar(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Star(height: 30) : SizedBox(height: 20);
        } else {
            return continent.isNormalSolved ? Star(height: 30) : SizedBox(height: 20);
        }
    }

    getTotalStars(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 30),
                    SizedBox(width: 20),
                    Star(height: 30)
                ]
            ) : World.isEasySolved ? Star(height: 30) : SizedBox();
        } else {
            return continent.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 30),
                    SizedBox(width: 20),
                    Star(height: 30)
                ]
            ) : continent.isEasySolved ? Star(height: 30) : SizedBox(height: 20);
        }
    }

    getStars(Continent continent) {
        if (continent.title == 'World') {
            return World.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 40),
                    SizedBox(width: 30),
                    Star(height: 40)
                ]
            ) : World.isEasySolved ? Star(height: 40) : SizedBox.shrink();
        } else {
            return continent.isNormalSolved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Star(height: 40),
                    SizedBox(width: 30),
                    Star(height: 40)
                ]
            ) : continent.isEasySolved ? Star(height: 40) : SizedBox.shrink();
        }
    }
}

class Statistics extends StatefulWidget {

	@override
	State createState() => StatisticsState();
}