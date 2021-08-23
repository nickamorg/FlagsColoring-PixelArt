import 'package:flagscoloring_pixelart/World.dart';
import 'package:flagscoloring_pixelart/library.dart';
import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';

class ContinentScreen extends StatelessWidget {
    final String continentTitle;

    ContinentScreen({ Key? key, required this.continentTitle}) : super(key: key);

	@override
	Widget build(BuildContext context) {
        return ContinentStatefull(continentTitle: continentTitle);
	}
}

class ContinentState extends State<ContinentStatefull> {
    String continentTitle = '';
    String expandedCountry = '';

    @override
    void initState() {
        super.initState();

        continentTitle = widget.continentTitle;
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
                        image: AssetImage("assets/continents_background/$continentTitle.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: [
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                                children: [
                                    Text(
                                        '${World.getContinentByTitle(continentTitle).totalSolvedStars}/${World.getContinentByTitle(continentTitle).totalStars}',
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

        countries.add(SizedBox(width: 20));
        World.getContinentByTitle(continentTitle).countries.forEach((countryTitle) {
            countries.add(getCountry(countryTitle));
        });
        countries.add(SizedBox(width: 20));

        return Row(children: countries);
    }

    getCountry(Country country) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
                children: [
                    expandedCountry != country.title ? SizedBox.shrink() : Card(
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
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder: (context) => GameScreen(countryTitle: countryTitle, gameMode: GameMode.EASY)
                                                            //     )
                                                            // )
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            height: 60,
                                                            width: 90,
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
                                                                    country.isEasySolved ? Star(height: 20) : SizedBox(height: 20)
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
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder: (context) => GameScreen(countryTitle: countryTitle, gameMode: GameMode.EASY)
                                                            //     )
                                                            // )
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            height: 60,
                                                            width: 90,
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
                                                                            Star(height: 20),
                                                                            SizedBox(width: 10),
                                                                            Star(height: 20)
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
                                            height: MediaQuery.of(context).size.height - 150,
                                            width: MediaQuery.of(context).size.height - 150,
                                            child: Image(
                                                image: AssetImage('assets/shapes/$continentTitle/${country.title}.png'),
                                                height: MediaQuery.of(context).size.height - 100,
                                                color: country.isEasySolved ? null : Colors.white,
                                                fit: BoxFit.contain
                                            )
                                        )
                                    )
                                )
                            ),
                            Positioned(
                                top: 15,
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
                                            Star(),
                                            SizedBox(width: 20),
                                            Star()
                                        ]
                                    ) : country.isEasySolved ? Star() : SizedBox.shrink()
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
    final String continentTitle;

    ContinentStatefull({ Key? key, required this.continentTitle }) : super(key: key);


	@override
	State createState() => ContinentState();
}