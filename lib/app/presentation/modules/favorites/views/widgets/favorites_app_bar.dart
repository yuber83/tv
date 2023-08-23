import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // elevation: 0,
      // titleTextStyle: const TextStyle(
      //   color: Colors.black,
      // ),
      title: const Text('Favorites'),
      centerTitle: true,
      // iconTheme: const IconThemeData(
      //   color: Colors.black,
      // ),
      // backgroundColor: Colors.white,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        // labelColor: Colors.black,
        indicator: const _Decoration(
          color: Colors.red,
          width: 20,
        ),
        // indicatorWeight: 3.0,
        /*
        indicator: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(30),
        ),
        */
        tabs: const [
          Tab(
            // icon: Icon(
            //   Icons.movie,
            // ),
            text: 'Movies',
            // child: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15.0),
            //   child: Text('Movies'),
            // ),
          ),
          Tab(
            //   icon: Icon(Icons.tv),
            text: 'Series',
            /*
                        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Seriess'),
            ),
              */
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  const _Decoration({
    required this.color,
    required this.width,
  });
  final Color color;
  final double width;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _Painter(color, width);
  }
}

class _Painter extends BoxPainter {
  _Painter(this.color, this.width);
  final Color color;
  final double width;

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5 + offset.dx - width * 0.5,
          size.height * 0.9,
          width,
          width * 0.3,
        ),
        const Radius.circular(4),
      ),
      paint,
    );

/*
    canvas.drawCircle(
      Offset(size.width * 0.5 + offset.dx, size.height * 0.9),
      4,
      paint,
    );
    */
  }
}
