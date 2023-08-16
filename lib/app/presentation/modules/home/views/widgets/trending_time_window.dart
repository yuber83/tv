import 'package:flutter/material.dart';

import '../../../../../domain/enums.dart';

class TrendingTimeWindow extends StatelessWidget {
  const TrendingTimeWindow(
      {super.key, required this.timeWindow, required this.onChanged});
  final TimeWindow timeWindow;
  final void Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          const Text(
            'TRENDING',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: const Color(0xfff0f0f0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<TimeWindow>(
                    value: timeWindow,
                    isDense: true,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                        value: TimeWindow.day,
                        child: Text('Last 24h'),
                      ),
                      DropdownMenuItem(
                        value: TimeWindow.week,
                        child: Text('Last Week'),
                      )
                    ],
                    onChanged: (newTimewindow) {
                      if (newTimewindow == null ||
                          newTimewindow == timeWindow) {
                        return;
                      }
                      onChanged(newTimewindow);
                    }),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
