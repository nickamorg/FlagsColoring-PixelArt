import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/World.dart';
import 'package:flagscoloring_pixelart/library.dart';
import 'package:flagscoloring_pixelart/screens/GameScreen.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';

class ContinentScreen extends StatelessWidget {
    final int continentIdx;

    ContinentScreen({ Key? key, required this.continentIdx}) : super(key: key);

	@override
	Widget build(BuildContext context) {
        return ContinentStatefull(continentIdx: continentIdx);
	}
}

class ContinentState extends State<ContinentStatefull> {
    int continentIdx = 0;
    String expandedCountry = '';

    @override
    void initState() {
        super.initState();

        continentIdx = widget.continentIdx;
    }

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
                        image: AssetImage("assets/continents_background/${World.continents[continentIdx].title}.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: [
                        Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                                children: [
                                    Text(
                                        '${World.continents[continentIdx].totalSolvedStars}/${World.continents[continentIdx].totalStars}',
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
                                child: getCountries()
                            )
                        )
                    ]
                )
            )
        );
    }

    Row getCountries() {
        List<Widget> countries = [];

        int index = 0;
        countries.add(SizedBox(width: 20));
            World.continents[continentIdx].countries.forEach((countryTitle) {
            countries.add(getCountry(countryTitle, index++));
        });
        countries.add(SizedBox(width: 20));

        return Row(children: countries);
    }

    getCountry(Country country, int index) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
                children: [
                    expandedCountry != country.title ? SizedBox.shrink() : Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Card(
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
                                                    Card(
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                padding: EdgeInsets.all(5)
                                                            ),
                                                            onPressed: () => {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => GameScreen(continentIdx: continentIdx, countryIdx: index, gameMode: GameMode.EASY)
                                                                    )
                                                                )
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                height: 70,
                                                                width: 100,
                                                                child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                        Text(
                                                                            'Easy',
                                                                            style: TextStyle(
                                                                                color: AppTheme.MAIN_COLOR,
                                                                                fontWeight: FontWeight.bold
                                                                            )
                                                                        ),
                                                                        Star(height: 30)
                                                                    ]
                                                                )
                                                            )
                                                        )
                                                    ),
                                                    Card(
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                padding: EdgeInsets.all(5)
                                                            ),
                                                            onPressed: () => {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => GameScreen(continentIdx: continentIdx, countryIdx: index, gameMode: GameMode.NORMAL)
                                                                    )
                                                                )
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                height: 70,
                                                                width: 100,
                                                                child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                        Text(
                                                                            'Normal',
                                                                            style: TextStyle(
                                                                                color: AppTheme.MAIN_COLOR,
                                                                                fontWeight: FontWeight.bold
                                                                            )
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                                Star(height: 30),
                                                                                SizedBox(width: 10),
                                                                                Star(height: 30)
                                                                            ]
                                                                        )
                                                                    ]
                                                                )
                                                            )
                                                        )
                                                    )
                                                ]
                                            )
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    Stack(
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
                                        onPressed: ()  { 
                                            if (expandedCountry == country.title) {
                                                expandedCountry = '';
                                            } else {
                                                expandedCountry = country.title;
                                            }
                                            setState(() { });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: MediaQuery.of(context).size.height - 100,
                                            width: MediaQuery.of(context).size.height - 100,
                                            child: Image(
                                                image: AssetImage('assets/shapes/${World.continents[continentIdx].title}/${country.title}.png'),
                                                height: MediaQuery.of(context).size.height - 50,
                                                color: country.isEasySolved ? null : Colors.white,
                                                fit: BoxFit.contain
                                            )
                                        )
                                    )
                                )
                            ),
                            Positioned(
                                top: 25,
                                right: 15,
                                child: Card(
                                    color: AppTheme.MAIN_COLOR,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Row(
                                        children: [
                                            Tooltip(
                                                message: country.title,
                                                preferBelow: false,
                                                verticalOffset: 35,
                                                showDuration: Duration(milliseconds: 500),
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                    height: 35,
                                                    constraints: BoxConstraints(maxWidth: 150),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8)
                                                    ),
                                                    child: Text(
                                                        country.title,
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
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: country.isNormalSolved ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            Star(height: 40),
                                            SizedBox(width: 20),
                                            Star(height: 40)
                                        ]
                                    ) : country.isEasySolved ? Star(height: 40) : SizedBox.shrink()
                                )
                            )
                        ]
                    )
                ]
            )
        );
    }
}

class ContinentStatefull extends StatefulWidget {
    final int continentIdx;

    ContinentStatefull({ Key? key, required this.continentIdx }) : super(key: key);


	@override
	State createState() => ContinentState();
}