import 'package:flutter/material.dart';
import 'main_config.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   late  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: MainConfig.pages,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: BottomNavigationBar(
            items: MainConfig.items,
            unselectedFontSize: 14,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (idx) => setState(() => _currentIndex = idx),
          ),
        ),
        Positioned(
          top: 10,
          child: FloatingActionButton(
            child: const Icon(Icons.add,size: 30),
            onPressed: () => setState(() {
              _currentIndex = 2;
            })
          ),
        )
      ],
    );
  }
}
