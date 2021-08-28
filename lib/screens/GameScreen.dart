import 'package:flagscoloring_pixelart/AudioPlayer.dart';
import 'package:flagscoloring_pixelart/ExpandableFab.dart';
import 'package:flutter/material.dart';
import 'package:flagscoloring_pixelart/AppTheme.dart';
import 'package:flagscoloring_pixelart/library.dart';
import 'package:flagscoloring_pixelart/World.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends StatelessWidget {
    final int continentIdx;
    final int countryIdx;
    final GameMode gameMode;

    GameScreen({ Key? key, required this.continentIdx, required this.countryIdx, required this.gameMode}) : super(key: key);

	@override
	Widget build(BuildContext context) {
        return Game(continentIdx: continentIdx, countryIdx: countryIdx, gameMode: gameMode);
	}
}

class GameState extends State<Game> {
    int continentIdx = 0;
    int countryIdx = 0;
    GameMode gameMode = GameMode.EASY;

    int height = 18;
    int width = 26;
    
    int blockDiameterSize = 1;
    int selectedColorIdx = 0;
    List<List<int>> board = [];
    List<List<int>> pixels = [];
    List<Color?> colors = [];
    List<Color?> actualColors = [];
    int selectedShapeIdx = 0;
    List<List<List<int>>> lastPainting = [];

    @override
    initState() {
        super.initState();

        continentIdx = widget.continentIdx;
        countryIdx = widget.countryIdx;
        gameMode = widget.gameMode;

        pixels = World.continents[continentIdx].countries[countryIdx].pixels;
        height = pixels.length;
        width = pixels[0].length;
        colors = World.continents[continentIdx].countries[countryIdx].colors.map((color) => mapColors[color]).toList();
        actualColors = World.continents[continentIdx].countries[countryIdx].colors.map((color) => mapColors[color]).toList();
        if (gameMode == GameMode.NORMAL) colors.shuffle();

        board = List.generate(height, (i) => List.filled(width, -1, growable: true), growable: true);
    }

	@override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: ExpandableFab(
                distance: 112,
                children: [
                    getClearBoardActionButton(),
                    getUndoPaintingActionButton(),
                    getHintActionButton(),
                    getValidateBoardActionButton()
                ]
            ),
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
                        image: AssetImage("assets/countries/${World.continents[continentIdx].title}/${World.continents[continentIdx].countries[countryIdx].title}.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                        children: [
                            Container(
                                height: MediaQuery.of(context).size.height - 40,
                                width: (MediaQuery.of(context).size.height - 40) / height * width,
                                child: InteractiveViewer(
                                    minScale: 1,
                                    maxScale: 3,
                                    child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisCount: width,
                                        children: getBoard()
                                    )
                                )
                            ),
                            Expanded(
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                getColorsCard(),
                                                SizedBox(height: 10),
                                                getShapeCard(),
                                                SizedBox(height: 10),
                                                getBlockSizeCard()
                                            ]
                                        )
                                    )
                                )
                            )
                        ]
                    )
                )
            )
        );
    }

    Tooltip getClearBoardActionButton() {
        return Tooltip(
            message: 'Clear Board',
            verticalOffset: 30,
            preferBelow: false,
            child: ActionButton(
                onPressed: clearBoard,
                icon: SvgPicture.asset(
                    'assets/actions/clear.svg',
                    height: 25
                )
            )
        );
    }

    Tooltip getUndoPaintingActionButton() {
        return Tooltip(
            message: 'Undo Painting',
            verticalOffset: 30,
            preferBelow: false,
            child: AnimatedOpacity(
                opacity: lastPainting.isNotEmpty ? 1 : 0.5,
                duration: Duration(milliseconds: 500),
                child: ActionButton(
                    onPressed: lastPainting.isEmpty ? null : undoPainting,
                    icon: SvgPicture.asset(
                        'assets/actions/undo.svg',
                        height: 25
                    )
                )
            )
        );
    }

    Tooltip getHintActionButton() {
        return Tooltip(
            message: 'Get Hint',
            verticalOffset: 30,
            preferBelow: false,
            child: ActionButton(
                onPressed: () => { },
                icon: SvgPicture.asset(
                    'assets/actions/hint.svg',
                    height: 25
                )
            )
        );
    }

    Tooltip getValidateBoardActionButton() {
        return Tooltip(
            message: 'Validate Board',
            verticalOffset: 30,
            preferBelow: false,
            child: ActionButton(
                onPressed: validateBoard,
                icon: SvgPicture.asset(
                    'assets/actions/validate.svg',
                    height: 25
                )
            )
        );
    }

    Card getColorsCard() {
        return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            color: Colors.white,
            child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                    height: 130,
                    width: 80,
                    child: ListWheelScrollView.useDelegate(
                        physics: FixedExtentScrollPhysics(),
                        perspective: 0.01,
                        itemExtent: 80,
                        childDelegate: ListWheelChildLoopingListDelegate(
                            children: getColors()
                        ),
                        onSelectedItemChanged: (index) {
                            setState(() {
                                selectedColorIdx = index;
                            });
                        }
                    )
                )
            )
        );
    }

    Card getShapeCard() {
        return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            color: Colors.white,
            child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                    height: 130,
                    width: 80,
                    child: ListWheelScrollView.useDelegate(
                        physics: FixedExtentScrollPhysics(),
                        perspective: 0.01,
                        itemExtent: 80,
                        childDelegate: ListWheelChildLoopingListDelegate(
                            children: [
                                getBlockShape(),
                                getColumnShape(),
                                getRowShape(),
                            ]
                        ),
                        onSelectedItemChanged: (index) {
                            setState(() {
                                selectedShapeIdx = index;
                            });
                        }
                    )
                )
            )
        );
    }

    RotatedBox getBlockShape() {
        return RotatedBox(
            quarterTurns: 1,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Block(
                        size: 30,
                        shape: shapes[selectedShapeIdx],
                        shapeMatch: Shape.BLOCK,
                        color: colors[selectedColorIdx],
                        radius: 6
                    )
                ]
            )
        );
    }

    RotatedBox getColumnShape() {
        return RotatedBox(
            quarterTurns: 1,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Block(
                        size: 8,
                        shape: shapes[selectedShapeIdx],
                        shapeMatch: Shape.COLUMN,
                        color: colors[selectedColorIdx],
                        radius: 2
                    ),
                    SizedBox(height: 2),
                    Block(
                        size: 8,
                        shape: shapes[selectedShapeIdx],
                        shapeMatch: Shape.COLUMN,
                        color: colors[selectedColorIdx],
                        radius: 2
                    ),
                    SizedBox(height: 2),
                    Block(
                        size: 8,
                        shape: shapes[selectedShapeIdx],
                        shapeMatch: Shape.COLUMN,
                        color: colors[selectedColorIdx],
                        radius: 2
                    )
                ]
            )
        );
    }

    RotatedBox getRowShape() {
        return RotatedBox(
            quarterTurns: 1,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    SizedBox(height: 11),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Block(
                                size: 8,
                                shape: shapes[selectedShapeIdx],
                                shapeMatch: Shape.ROW,
                                color: colors[selectedColorIdx],
                                radius: 2
                            ),
                            SizedBox(width: 2),
                            Block(
                                size: 8,
                                shape: shapes[selectedShapeIdx],
                                shapeMatch: Shape.ROW,
                                color: colors[selectedColorIdx],
                                radius: 2
                            ),
                            SizedBox(width: 2),
                            Block(
                                size: 8,
                                shape: shapes[selectedShapeIdx],
                                shapeMatch: Shape.ROW,
                                color: colors[selectedColorIdx],
                                radius: 2
                            )
                        ]
                    ),
                    SizedBox(height: 11)
                ]
            )
        );
    }

    AnimatedOpacity getBlockSizeCard() {
        return AnimatedOpacity(
            opacity: shapes[selectedShapeIdx] == Shape.BLOCK ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                color: Colors.white,
                child: Column(
                    children: [
                        RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                                height: 130,
                                width: 55,
                                child: ListWheelScrollView.useDelegate(
                                    physics: shapes[selectedShapeIdx] == Shape.BLOCK ? FixedExtentScrollPhysics() : NeverScrollableScrollPhysics() ,
                                    perspective: 0.01,
                                    itemExtent: 40,
                                    childDelegate: ListWheelChildLoopingListDelegate(
                                        children: getBlockDiagonalSizes()
                                    ),
                                    onSelectedItemChanged: (index) {
                                        setState(() {
                                            blockDiameterSize = index * 2 + 1;
                                        });
                                    }
                                )
                            )
                        )
                    ]
                )
            )
        );
    }

    List<Widget> getBoard() {
        List<Widget> cells = [];

        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                cells.add(
                    pixels[i][j] == 0 ? SizedBox.shrink() :
                    Center(
                        child: TextButton(
                            onPressed: () => { paintBoard(i, j) },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: board[i][j] == -1 ? Colors.grey : colors[board[i][j] - 1],
                                    shape: BoxShape.rectangle,
                                    border: board[i][j] == 0 ? Border.all(color: Colors.blueGrey) : null,
                                    borderRadius: isCorner(i, j) ? BorderRadius.only(
                                        topLeft: Radius.circular(i == 0 && j == 0 ? 10 : 0),
                                        topRight: Radius.circular(i == 0 && j == width - 1 ? 10 : 0),
                                        bottomLeft: Radius.circular(i == height - 1 && j == 0 ? 10 : 0),
                                        bottomRight: Radius.circular(i == height - 1 && j == width - 1 ? 10 : 0)
                                    ) : BorderRadius.zero
                                ),
                                child: Center(
                                    child: Text(
                                        '${pixels[i][j]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: board[i][j] > -1 && isColorNeededBlackFont(board[i][j] - 1) ? Colors.black : Colors.white
                                        )
                                    )
                                )
                            )
                        )
                    )
                );
            }
        }
        
        return cells;
    }

    List<Widget> getColors() {
        List<Widget> colorItems = [];

        for ( int i = 0; i < colors.length; i++) {
            colorItems.add(
                RotatedBox(
                    quarterTurns: 1,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: colors[i],
                                    shape: BoxShape.circle,
                                    border: colors[i] == Colors.white ? Border.all(color: Colors.black) : null
                                ),
                                child: gameMode == GameMode.NORMAL ? SizedBox.shrink() : Center(
                                    child: Text(
                                        '${i + 1}',
                                        style: TextStyle(
                                            color: isColorNeededBlackFont(i) ? Colors.black : Colors.white
                                        )
                                    )
                                )
                            )
                        ]
                    )
                )
            );
        }

        return colorItems;
    }

    List<Widget> getBlockDiagonalSizes() {
        List<Widget> sizes = [];

        for (int i = 1; i <= height + 1; i += 2) {
            sizes.add(
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        RotatedBox(
                            quarterTurns: 1,
                            child: Stack(
                                children: <Widget>[
                                    !isWhiteColor(selectedColorIdx) || blockDiameterSize != i ? SizedBox.shrink() : Text(
                                        '$i',
                                        style: TextStyle(
                                            foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 1
                                            ..color = Colors.black,
                                            fontSize: 30
                                        )
                                    ),
                                    Text(
                                        '$i',
                                        style: TextStyle(
                                            color: blockDiameterSize == i ? colors[selectedColorIdx] : Colors.black38,
                                            fontSize: 30
                                        )
                                    )
                                ]
                            )
                        )
                    ]
                )
            );
        }

        return sizes;
    }

    bool isWhiteColor(int index) {
        return colors[index] == Colors.white;
    }

    bool isColorNeededBlackFont(int index) {
        return colors[index] == Colors.white || colors[index] == Colors.yellow;
    }

    bool isCorner(int row, int col) {
        return (row == 0 && col == 0) || (row == 0 && col == width - 1) ||
            (row == height - 1 && col == 0) || (row == height - 1 && col == width - 1);
    }

    void paintBoard(int row, int col) {
        stackBoardStatus();

        if (shapes[selectedShapeIdx] == Shape.ROW) {
            for (int i = 0; i < board[row].length; i++) {
                board[row][i] = selectedColorIdx + 1;
            }
        } else if (shapes[selectedShapeIdx] == Shape.COLUMN) {
            for (int i = 0; i < board.length; i++) {
                board[i][col] = selectedColorIdx + 1;
            }
        } else {
            if (blockDiameterSize == 1) {
                board[row][col] = selectedColorIdx + 1;
            }

            for (int i = row - blockDiameterSize ~/ 2; i <= row + blockDiameterSize ~/ 2; i++) {
                for (int j = col - blockDiameterSize ~/ 2; j <= col + blockDiameterSize ~/ 2; j++) {
                    if (i >= 0 && i < height && j >= 0 && j < width) {
                        board[i][j] = selectedColorIdx + 1;
                    }
                }
            }
        }

        setState(() { });
    }

    void stackBoardStatus() {
        lastPainting.add([]);
        board.forEach((rowCell) { 
            lastPainting.last.add(List.from(rowCell));
        });
    }

    void clearBoard() {
        stackBoardStatus();
        board = List.generate(height, (i) => List.filled(width, -1, growable: true), growable: true);

        setState(() { });
    }

    void undoPainting() {
        board = [];
        lastPainting.last.forEach((rowCell) { 
            board.add(List.from(rowCell));
        });
        lastPainting.removeLast();

        setState(() { });
    }

    void validateBoard() {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board.length; j++) {
                if (pixels[i][j] == 0) {
                    continue;
                } else if (board[i][j] == -1) {
                    AudioPlayer.play(AudioList.WRONG_ANSWER);
                    return;
                } else {
                    if (actualColors.indexWhere((color) => color == colors[board[i][j] - 1]) + 1 != pixels[i][j]) {
                        AudioPlayer.play(AudioList.WRONG_ANSWER);
                        return;
                    }
                }
            }
        }

        AudioPlayer.play(AudioList.WIN);

        int rewardHints = 0;
        if (gameMode == GameMode.EASY) {
            if (!World.continents[continentIdx].countries[countryIdx].isEasySolved) {
                rewardHints = 1;
            }
        } else if (gameMode == GameMode.NORMAL) {
            if (!World.continents[continentIdx].countries[countryIdx].isEasySolved && !World.continents[continentIdx].countries[countryIdx].isNormalSolved) {
                rewardHints = 3;
            } else if (!World.continents[continentIdx].countries[countryIdx].isNormalSolved) {
                rewardHints = 1;
            }
            World.continents[continentIdx].countries[countryIdx].isNormalSolved = true;
        }
        World.continents[continentIdx].countries[countryIdx].isEasySolved = true;
        hints += rewardHints;

        if (rewardHints > 0) {
            final snackBar = SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text("+$rewardHints hint${rewardHints > 1 ? 's' : ''}")
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        World.storeData();

        Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.of(context).pop(true);
        });
    }

    void printBoard() {
        String str = '\n';
        board.forEach((element) { str += element.toString() + ',\n'; });
        print(str.substring(0, str.length ~/ 2));
        print(str.substring(str.length ~/ 2));
    }
}

class Block extends StatelessWidget {
    final double size;
    final Shape shape;
    final Shape shapeMatch;
    final Color? color;
    final double radius;
    
    Block({required this.size, required this.shape, required this.shapeMatch, required this.color, required this.radius});

    @override
    Widget build(BuildContext context) {
        return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: shape == shapeMatch ? color : Colors.black38,
                shape: BoxShape.rectangle,
                border: shape == shapeMatch && color == Colors.white ? Border.all(color: Colors.black) : null,
                borderRadius: BorderRadius.circular(radius)
            )
        );
    }
}

class Game extends StatefulWidget {
    final int continentIdx;
    final int countryIdx;
    final GameMode gameMode;

    Game({ Key? key, required this.continentIdx, required this.countryIdx, required this.gameMode}) : super(key: key);

	@override
	State createState() => GameState();
}