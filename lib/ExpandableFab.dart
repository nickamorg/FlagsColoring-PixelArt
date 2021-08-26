import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

@immutable
class ExpandableFab extends StatefulWidget {
    final bool? initialOpen;
    final double distance;
    final List<Widget> children;

    ExpandableFab({ Key? key, this.initialOpen, required this.distance, required this.children }) : super(key: key);

    @override
    ExpandableFabState createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
    late final AnimationController controller;
    late final Animation<double> expandAnimation;
    bool open = false;

    @override
    void initState() {
        super.initState();
        
        open = widget.initialOpen ?? false;
        controller = AnimationController(
            value: open ? 1.0 : 0.0,
            duration: Duration(milliseconds: 250),
            vsync: this
        );
        expandAnimation = CurvedAnimation(
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.easeOutQuad,
            parent: controller
        );
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    void toggle() {
        setState(() {
            open = !open;
            if (open) {
                controller.forward();
            } else {
                controller.reverse();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return SizedBox.expand(
            child: Stack(
                alignment: Alignment.bottomRight,
                clipBehavior: Clip.none,
                children: [
                    buildTapToCloseFab(),
                    ...buildExpandingActionButtons(),
                    buildTapToOpenFab()
                ]
            )
        );
    }

    Widget buildTapToCloseFab() {
        return SizedBox(
            width: 56,
            height: 56,
            child: Center(
                child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    child: InkWell(
                        onTap: toggle,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColor
                            )
                        )
                    )
                )
            )
        );
    }

    List<Widget> buildExpandingActionButtons() {
        final children = <Widget>[];
        final count = widget.children.length;
        final step = 90.0 / (count - 1);

        for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
            children.add(
                ExpandingActionButton(
                    directionInDegrees: angleInDegrees,
                    maxDistance: widget.distance,
                    progress: expandAnimation,
                    child: widget.children[i]
                )
            );
        }
        return children;
    }

    Widget buildTapToOpenFab() {
        return IgnorePointer(
            ignoring: open,
            child: AnimatedContainer(
                transformAlignment: Alignment.center,
                transform: Matrix4.diagonal3Values(
                    open ? 0.7 : 1.0,
                    open ? 0.7 : 1.0,
                    1.0
                ),
                duration: Duration(milliseconds: 250),
                curve: Interval(0.0, 0.5, curve: Curves.easeOut),
                child: AnimatedOpacity(
                    opacity: open ? 0.0 : 1.0,
                    curve: Interval(0.25, 1.0, curve: Curves.easeInOut),
                    duration: Duration(milliseconds: 250),
                    child: FloatingActionButton(
                        heroTag: null,
                        onPressed: toggle,
                        child: SvgPicture.asset(
                            'assets/actions/actions.svg',
                            height: 25
                        )
                    )
                )
            )
        );
    }
}

@immutable
class ExpandingActionButton extends StatelessWidget {
    final double directionInDegrees;
    final double maxDistance;
    final Animation<double> progress;
    final Widget child;

    ExpandingActionButton({ Key? key, required this.directionInDegrees, required this.maxDistance, required this.progress, required this.child }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
                final offset = Offset.fromDirection(
                    directionInDegrees * (math.pi / 180.0),
                    progress.value * maxDistance,
                );
                return Positioned(
                    right: 4.0 + offset.dx,
                    bottom: 4.0 + offset.dy,
                    child: Transform.rotate(
                        angle: (1.0 - progress.value) * math.pi / 2,
                        child: child!
                    )
                );
            },
            child: FadeTransition(
                opacity: progress,
                child: child
            )
        );
    }
}

@immutable
class ActionButton extends StatelessWidget {
    final VoidCallback? onPressed;
    final Widget icon;

    ActionButton({ Key? key, this.onPressed, required this.icon }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return Material(
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: theme.accentColor,
            elevation: 4.0,
            child: IconTheme.merge(
                data: theme.accentIconTheme,
                child: IconButton(
                    onPressed: onPressed,
                    icon: icon
                )
            )
        );
    }
}