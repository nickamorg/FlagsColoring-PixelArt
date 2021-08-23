import 'package:flagscoloring_pixelart/AudioPlayer.dart';
import 'package:flagscoloring_pixelart/screens/WorldScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flagscoloring_pixelart/World.dart';
// import 'package:flagscoloring_pixelart/AdManager.dart';
import 'package:flagscoloring_pixelart/screens/ContactScreen.dart';
import 'package:flagscoloring_pixelart/screens/StatisticsScreen.dart';
import 'package:launch_review/launch_review.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
        return MaterialApp(
			home: Home()
		);
	}
}

class HomeState extends State<Home> with TickerProviderStateMixin {
    late final AnimationController controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 4)
    )..repeat();


    @override
    void initState() {
        super.initState();

        World.init().then((value) => World.loadDataStorage());

        // AdManager.initGoogleMobileAds();
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
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
                        image: AssetImage("assets/world.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: [
                        Center(
                            child: RawMaterialButton(
                                shape: CircleBorder(),
                                elevation: 2,
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WorldScreen()
                                        )
                                    ).then((value) {
                                        setState(() { });
                                    });
                                },
                                child: AnimatedBuilder(
                                    animation: controller,
                                    builder: (_, child) {
                                        return Transform.rotate(
                                            angle: controller.value * 2 * pi,
                                            child: child
                                        );
                                    },
                                    child: SvgPicture.asset(
                                        'assets/svg/earth.svg',
                                        height: MediaQuery.of(context).size.height - 100
                                    )
                                )
                            )
                        ),
                        Positioned(
                            top: 15,
                            left: 10,
                            child: CircleButton(icon: Icons.pie_chart, screen: () => StatisticsScreen())
                        ),
                        Positioned(
                            top: 15,
                            right: 10,
                            child: CircleButton(icon: Icons.settings_suggest, screen: () => ContactScreen())
                        ),
                        Positioned(
                            bottom: 15,
                            right: 10,
                            child: CircleButton(icon: Icons.favorite, action: () => LaunchReview.launch(androidAppId: "com.zirconworks.flagscoloring_pixelart"))
                        ),
                        Positioned(
                            bottom: 15,
                            left: 10,
                            child: RawMaterialButton(
                                onPressed: () => {
                                    setState(() {
                                        AudioPlayer.isAudioEnabled = !AudioPlayer.isAudioEnabled;
                                    })
                                },
                                elevation: 2,
                                fillColor: AppTheme.SECONDARY_COLOR,
                                child: Icon(
                                    AudioPlayer.isAudioEnabled ? Icons.volume_up : Icons.volume_off,
                                    size: 35,
                                    color: AppTheme.THIRD_COLOR
                                ),
                                enableFeedback: !AudioPlayer.isAudioEnabled,
                                padding: EdgeInsets.all(15),
                                shape: CircleBorder()
                            )
                        )
                    ]
                )
            )
        );
    }
}

class CircleButton extends StatelessWidget {
    final Function? screen;
    final Function? action;
    final IconData icon;
    
    CircleButton({required this.icon, this.screen, this.action});

    @override
    Widget build(BuildContext context) {
        return RawMaterialButton(
            onPressed: () => {
                screen != null ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screen!()
                    )
                ) : action!()
            },
            fillColor: AppTheme.SECONDARY_COLOR,
            child: Icon(
                icon,
                size: 35,
                color: AppTheme.THIRD_COLOR
            ),
            padding: EdgeInsets.all(15),
            shape: CircleBorder()
        );
    }
}

class Home extends StatefulWidget {

	@override
	State createState() => HomeState();
}