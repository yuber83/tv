import 'package:flutter/material.dart';

import 'widgets/movies-and_series/trending_list.dart';
import 'widgets/performers/trending_performers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            TrendingList(),
            SizedBox(height: 20),
            TrendingPerformers(),
          ],
        ),
      ),
    );
  }
}
