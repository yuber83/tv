import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../controller/state/home_state.dart';
import 'widgets/movies-and_series/trending_list.dart';
import 'widgets/performers/trending_performers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(
        HomeState(),
        trendingRepository: context.read(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.favorites);
              },
              icon: const Icon(Icons.favorite),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
              color: Colors.black,
            )
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: context.read<HomeController>().init,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: const Column(
                    children: [
                      SizedBox(height: 10),
                      TrendingList(),
                      SizedBox(height: 20),
                      TrendingPerformers(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
