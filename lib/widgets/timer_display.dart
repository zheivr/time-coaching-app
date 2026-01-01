import 'package:flutter/material.dart';
import '../models/activity.dart';

class TimerDisplay extends StatefulWidget {
  final Activity? activity;

  const TimerDisplay({
    super.key,
    required this.activity,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    if (widget.activity != null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(TimerDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activity != null && oldWidget.activity == null) {
      _controller.repeat();
    } else if (widget.activity == null && oldWidget.activity != null) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Activity in Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Text(
              widget.activity?.elapsedTimeFormatted ?? '00:00:00',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.activity != null
                        ? Colors.green
                        : Colors.grey,
                  ),
            );
          },
        ),
      ],
    );
  }
}
