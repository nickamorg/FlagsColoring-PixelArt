import 'package:flagscoloring_pixelart/World.dart';
import 'package:flagscoloring_pixelart/library.dart';
import 'package:flagscoloring_pixelart/screens/ContinentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldScreen extends StatelessWidget {

    WorldScreen({ Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
        return WorldStatefull();
	}
}

class WorldState extends State<WorldStatefull> {

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
                child: Stack(
                    children: [
                        Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Text(
                                        '${World.totalSolvedStars}/${World.totalStars}',
                                        style: TextStyle(
                                            color: AppTheme.THIRD_COLOR,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    SizedBox(width: 10),
                                    Star(height: 20)
                                ]
                            )
                        ),
                        Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: getContinents()
                            )
                        )
                    ]
                )
            )
        );
    }

    Row getContinents() {
        List<Widget> continents = [];

        continents.add(SizedBox(width: 20));
        int index = 0;
        World.continents.forEach((continent) {
            continents.add(getContinent(continent, index++));
        });
        continents.add(SizedBox(width: 20));

        return Row(children: continents);
    }

    getContinent(Continent continent, int index) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
                children: [
                    Container(
                        height: MediaQuery.of(context).size.height - 70,
                        padding: EdgeInsets.only(top: 10),
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
                                            builder: (context) => ContinentScreen(continentIdx: index)
                                        )
                                    ).then((value) {
                                        setState(() { });
                                    })
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height - 100,
                                    width: MediaQuery.of(context).size.height - 100,
                                    child: SvgPicture.asset(
                                        'assets/svg/${continent.title}.svg',
                                        height: MediaQuery.of(context).size.height - 50,
                                        fit: BoxFit.contain
                                    )
                                )
                            )
                        )
                    ),
                    Positioned(
                        top: 39,
                        right: 60,
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
                                        continent.title,
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
                        top: 25,
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
                                    '${continent.totalSolvedCountries}/${continent.countries.length}',
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
                            child: continent.isNormalSolved ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Star(height: 40),
                                    SizedBox(width: 20),
                                    Star(height: 40)
                                ]
                            ) : continent.isEasySolved ? Star(height: 40) : SizedBox.shrink()
                        )
                    )
                ]
            )
        );
    }
}

class WorldStatefull extends StatefulWidget {

	@override
	State createState() => WorldState();
}