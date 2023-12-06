import 'package:flutter/material.dart';

class WallPaper extends StatefulWidget {
  const WallPaper({super.key});

  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: 80,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.white,
                      ),
                    );
                  }),
            ),
          ),
          Container(
            child: const Text('Load More'),
            height: 50,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
