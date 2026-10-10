import 'package:flutter/material.dart';

const _canvas = Color(0xFFF8F6F0);
const _pine = Color(0xFF244B54);
const _muted = Color(0xFF80918D);
const _accent = Color(0xFFB58D6D);

void main() {
  runApp(const ShareDailyApp());
}

class ShareDailyApp extends StatelessWidget {
  const ShareDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '餘數日常 SHARE DAILY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _pine,
          brightness: Brightness.light,
          surface: _canvas,
        ),
      ),
      home: const BrandOpeningScreen(),
    );
  }
}

class BrandOpeningScreen extends StatefulWidget {
  const BrandOpeningScreen({super.key});

  @override
  State<BrandOpeningScreen> createState() => _BrandOpeningScreenState();
}

class _BrandOpeningScreenState extends State<BrandOpeningScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _flowController;
  late final AnimationController _pulseController;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoOffset;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    _flowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _logoOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.12, 0.75, curve: Curves.easeOut),
    );
    _logoOffset = Tween<Offset>(begin: const Offset(0, 0.09), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.12, 0.82, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _flowController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _PaperGrain(),
          AnimatedBuilder(
            animation: Listenable.merge([_flowController, _pulseController]),
            builder: (context, child) {
              return CustomPaint(
                painter: _BrandLinesPainter(
                  flow: _flowController.value,
                  pulse: _pulseController.value,
                ),
              );
            },
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 650;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: SlideTransition(
                      position: _logoOffset,
                      child: FadeTransition(
                        opacity: _logoOpacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _BrandMark(size: compact ? 74 : 92),
                            SizedBox(height: compact ? 25 : 32),
                            Text(
                              '餘數日常',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _pine,
                                fontFamily: 'serif',
                                fontSize: compact ? 34 : 40,
                                fontWeight: FontWeight.w700,
                                letterSpacing: compact ? 7 : 9,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'SHARE DAILY',
                              style: TextStyle(
                                color: _muted,
                                fontFamily: 'monospace',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 4.2,
                              ),
                            ),
                            SizedBox(height: compact ? 30 : 38),
                            Container(
                              width: 34,
                              height: 1,
                              color: _accent.withValues(alpha: 0.65),
                            ),
                            SizedBox(height: compact ? 18 : 22),
                            const Text(
                              '讓一點餘裕，沿著信任抵達日常。',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF536B65),
                                fontSize: 13,
                                letterSpacing: 1.1,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 22,
            child: SafeArea(
              top: false,
              child: Text(
                '一點分享，匯成日常的支持',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _muted.withValues(alpha: 0.76),
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _BrandMarkPainter()),
    );
  }
}

class _BrandMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 100;
    canvas.save();
    canvas.scale(scale);

    final paint = Paint()
      ..color = _pine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final bowl = Path()
      ..moveTo(17, 64)
      ..cubicTo(20, 76, 30, 84, 50, 84)
      ..cubicTo(70, 84, 80, 76, 83, 64)
      ..moveTo(24, 64)
      ..lineTo(76, 64);
    canvas.drawPath(bowl, paint);

    final stem = Path()
      ..moveTo(50, 63)
      ..lineTo(50, 37)
      ..cubicTo(50, 29, 44, 25, 38, 19)
      ..moveTo(50, 45)
      ..cubicTo(56, 37, 63, 31, 69, 23)
      ..moveTo(50, 53)
      ..cubicTo(43, 47, 36, 42, 29, 35)
      ..moveTo(50, 39)
      ..cubicTo(57, 46, 64, 51, 72, 57);
    canvas.drawPath(stem, paint);

    final nodePaint = Paint()..color = _pine;
    for (final node in const [
      Offset(38, 19),
      Offset(69, 23),
      Offset(29, 35),
      Offset(72, 57),
    ]) {
      canvas.drawCircle(node, 3.2, nodePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PaperGrain extends StatelessWidget {
  const _PaperGrain();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _PaperGrainPainter());
  }
}

class _PaperGrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = _pine.withValues(alpha: 0.045);
    const spacing = 24.0;
    for (var y = 12.0; y < size.height; y += spacing) {
      for (var x = 12.0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 0.7, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BrandLinesPainter extends CustomPainter {
  const _BrandLinesPainter({required this.flow, required this.pulse});

  final double flow;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 390;
    final center = Offset(size.width * 0.61, size.height * 0.49);

    final vertical = Path()
      ..moveTo(size.width * 0.48, -20)
      ..cubicTo(
        size.width * 0.48,
        size.height * 0.17,
        size.width * 0.78,
        size.height * 0.28,
        center.dx,
        center.dy,
      );
    canvas.drawPath(
      vertical,
      Paint()
        ..color = _muted.withValues(alpha: 0.24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round,
    );

    final horizontal = Path()
      ..moveTo(-30, size.height * 0.53)
      ..cubicTo(
        size.width * 0.27,
        size.height * 0.53,
        size.width * 0.43,
        size.height * 0.52,
        center.dx,
        center.dy,
      )
      ..cubicTo(
        size.width * 0.76,
        size.height * 0.46,
        size.width * 0.85,
        size.height * 0.37,
        size.width + 30,
        size.height * 0.34,
      );
    canvas.drawPath(
      horizontal,
      Paint()
        ..color = _pine.withValues(alpha: 0.14)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25
        ..strokeCap = StrokeCap.round,
    );

    final stream = Path()
      ..moveTo(center.dx, center.dy)
      ..cubicTo(
        center.dx + 7 * scale,
        center.dy + 72 * scale,
        center.dx + 62 * scale,
        center.dy + 112 * scale,
        center.dx + 30 * scale,
        center.dy + 174 * scale,
      )
      ..cubicTo(
        center.dx + 5 * scale,
        center.dy + 224 * scale,
        center.dx + 55 * scale,
        center.dy + 260 * scale,
        center.dx + 83 * scale,
        size.height + 35,
      );

    final metrics = stream.computeMetrics().toList();
    if (metrics.isNotEmpty) {
      final metric = metrics.first;
      const dashLength = 6.0;
      const gapLength = 10.0;
      final dashSpacing = dashLength + gapLength;
      final offset = flow * dashSpacing;
      final dashedPath = Path();

      for (
        var distance = -dashSpacing;
        distance < metric.length;
        distance += dashSpacing
      ) {
        final start = (distance + offset).clamp(0.0, metric.length);
        final end = (start + dashLength).clamp(0.0, metric.length);
        if (end > start) {
          dashedPath.addPath(metric.extractPath(start, end), Offset.zero);
        }
      }

      canvas.drawPath(
        dashedPath,
        Paint()
          ..color = _muted.withValues(alpha: 0.46)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.25
          ..strokeCap = StrokeCap.round,
      );
    }

    final haloRadius = (9 + pulse * 7) * scale;
    canvas.drawCircle(
      center,
      haloRadius,
      Paint()..color = _pine.withValues(alpha: 0.025 + pulse * 0.025),
    );
    canvas.drawCircle(
      center,
      2.5 * scale,
      Paint()
        ..color = _pine.withValues(alpha: 0.58)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    canvas.drawCircle(
      center,
      1.25 * scale,
      Paint()..color = _pine.withValues(alpha: 0.64),
    );

    final accentDot = Offset(size.width * 0.22, size.height * 0.76);
    canvas.drawCircle(
      accentDot,
      2.2,
      Paint()..color = _accent.withValues(alpha: 0.38),
    );
  }

  @override
  bool shouldRepaint(covariant _BrandLinesPainter oldDelegate) =>
      oldDelegate.flow != flow || oldDelegate.pulse != pulse;
}
