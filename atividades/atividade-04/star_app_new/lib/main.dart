import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const StarApp());
}

class StarApp extends StatelessWidget {
  const StarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star App',
      debugShowCheckedModeBanner: false,
      home: const StarScreen(),
    );
  }
}

class StarScreen extends StatefulWidget {
  const StarScreen({super.key});

  @override
  State<StarScreen> createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> {
  Color backgroundColor = Colors.blue;
  Color starColor = Colors.yellowAccent;

  final Random random = Random();

  void changeColors() {
    setState(() {
      backgroundColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
      starColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Center(
          child: GestureDetector(
            onTap: changeColors, // Só muda cor quando a estrela é tocada
            child: CustomPaint(
              size: const Size(200, 200),
              painter: StarPainter(color: starColor),
            ),
          ),
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final n = 5; // número de pontas
    final R = size.width / 2;
    final r = R / 2.5; // raio interno
    final cx = size.width / 2;
    final cy = size.height / 2;

    for (int i = 0; i <= n; i++) {
      double theta = (pi / n) * i;
      double x = cx + R * cos(theta * 2);
      double y = cy + R * sin(theta * 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      if (i < n) {
        double x2 = cx + r * cos(theta * 2 + pi / n);
        double y2 = cy + r * sin(theta * 2 + pi / n);
        path.lineTo(x2, y2);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => oldDelegate.color != color;
}
