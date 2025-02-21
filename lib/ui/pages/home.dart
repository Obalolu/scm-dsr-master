import 'package:dsr/ui/new_pages/new_home.dart';
import 'package:dsr/ui/new_pages/today.dart';
import 'package:dsr/ui/pages/bible_page.dart';
import 'package:dsr/ui/pages/more.dart';
import 'package:dsr/ui/widgets/devotional.dart';
import 'package:flutter/material.dart';

import '../new_pages/devotionals.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  static final List<Widget> _screens = <Widget>[
    const BiblePage(),
    const Today(),
    NewHome(),
    DevotionalsPage(),
    const More(),
  ];

  double horizontalPadding = 10.0;
  double horizontalMargin = 0;
  int noOfIcons = 5;

  List<Map<String, String>> icons = [
    {
      'unselected': 'assets/icons/bible_outlined.png',
      'selected': 'assets/icons/bible.png'
    },
    {
      'unselected': 'assets/icons/today_outlined.png',
      'selected': 'assets/icons/today.png'
    },
    {
      'unselected': 'assets/icons/home_outlined.png',
      'selected': 'assets/icons/home.png'
    },
    {
      'unselected': 'assets/icons/all_outlined.png',
      'selected': 'assets/icons/all.png'
    },
    {
      'unselected': 'assets/icons/user_outlined.png',
      'selected': 'assets/icons/user.png'
    }
  ];

  List<String> titles = [
    'Bible',
    'Today',
    'Home',
    'Devotionals',
    'Profile'
  ]; // Added titles list

  late AnimationController controller;
  late Animation<double> animation;
  int selected = 2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
    animation = Tween<double>(begin: 0, end: 0).animate(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final screenWidth = MediaQuery.of(context).size.width;
        double initialPosition = _getEndPosition(
          selected,
          horizontalPadding,
          horizontalMargin,
          noOfIcons,
          screenWidth,
        );
        animation = Tween<double>(begin: initialPosition, end: initialPosition)
            .animate(controller);
        setState(() {});
      }
    });
  }

  double _getEndPosition(
    int index,
    double horizontalPadding,
    double horizontalMargin,
    int noOfIcons,
    double screenWidth,
  ) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOmit = totalMargin + totalPadding;

    return (((screenWidth - valueToOmit) / noOfIcons) * index +
            horizontalPadding) +
        (((screenWidth - valueToOmit) / noOfIcons) / 2) -
        70;
  }

  void _animateDrop(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    double endPosition = _getEndPosition(
      index,
      horizontalPadding,
      horizontalMargin,
      noOfIcons,
      screenWidth,
    );
    animation = Tween<double>(begin: animation.value, end: endPosition)
        .animate(controller);
    controller.forward(from: 0.0);
  }

  Widget _buildIcon(int index) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
          _animateDrop(index);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 375),
            curve: Curves.easeOut,
            height: 85,
            width: (MediaQuery.of(context).size.width -
                    (2 * horizontalMargin) -
                    (2 * horizontalPadding)) /
                5,
            padding: const EdgeInsets.only(top: 17.5, bottom: 17.5),
            alignment: selected == index
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            child: SizedBox(
              height: 35.0,
              width: 35.0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 575),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: Image.asset(
                  selected == index
                      ? icons[index]['selected']!
                      : icons[index]
                          ['unselected']!, // Use selected/unselected icons
                  key: ValueKey('${selected == index}_$index'),
                  width: 30.0,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 0),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 375),
            opacity: selected == index ? 0.0 : 1.0,
            child: Text(
              titles[index], // Use titles list
              style: TextStyle(
                fontSize: 14,
                height: 0.2,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: IndexedStack(
              index: selected,
              children: _screens,
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return SizedBox(
      height: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: horizontalMargin,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: AppBarPainter(
                      animation.value, Theme.of(context).colorScheme.primary),
                  size: Size(
                    MediaQuery.of(context).size.width - (2 * horizontalMargin),
                    80.0,
                  ),
                  child: SizedBox(
                    height: 120.0,
                    width: MediaQuery.of(context).size.width -
                        (2 * horizontalMargin),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          noOfIcons,
                          (index) => _buildIcon(index),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarPainter extends CustomPainter {
  final double x;
  final Color color;

  AppBarPainter(this.x, this.color);

  final double height = 80.0;
  final double start = 40.0;
  final double end = 120;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0.0, start);

    path.lineTo(x < 20.0 ? 20.0 : x, start);
    path.quadraticBezierTo(20.0 + x, start, 30.0 + x, start + 30.0);
    path.quadraticBezierTo(40.0 + x, start + 55.0, 70.0 + x, start + 55.0);
    path.quadraticBezierTo(100.0 + x, start + 55.0, 110.0 + x, start + 30.0);
    path.quadraticBezierTo(
      120.0 + x,
      start,
      (140.0 + x) > (size.width - 20.0) ? (size.width - 20.0) : 140.0 + x,
      start,
    );
    path.lineTo(size.width - 20.0, start);

    path.quadraticBezierTo(size.width, start, size.width, start + 25.0);
    path.lineTo(size.width, end);
    path.lineTo(0.0, end);
    path.lineTo(0.0, start + 25.0);
    path.quadraticBezierTo(0.0, start, 20.0, start);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(x + 70.0, 50.0), 35.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
