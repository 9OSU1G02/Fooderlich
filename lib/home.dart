import 'package:flutter/material.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/recipes_screen.dart';
import 'package:provider/provider.dart';
import 'screens/grocery_screen.dart';
import 'models/tab_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // 2
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          // 3
          currentIndex: tabManager.selectedTab,
          onTap: (index) {
            // 4
            tabManager.goToTab(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'To Buy',
            ),
          ],
        ),
      );
    });
  }
}

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Sliver Example'),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(title: Text('Item $index'));
              },
              childCount: 10,
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Colors.pink,
                  child: Center(child: Text('Item $index')),
                );
              },
              childCount: 6,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverFixedExtentList(
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    color: Colors.green,
                    child: Center(child: Text('Item $index')),
                  );
                },
                childCount: 4,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: Colors.blue,
              child: Center(child: Text('SliverToBoxAdapter')),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              color: Colors.yellow,
              child: Center(child: Text('SliverFillRemaining')),
            ),
          ),
          SliverPersistentHeader(
            delegate: MyPersistentHeaderDelegate(),
            pinned: true,
          ),
          // SliverOverlapInjector(
          //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          // ),
          SliverSafeArea(
            top: false,
            bottom: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(title: Text('Item $index'));
                },
                childCount: 10,
              ),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 3,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: ListTile(title: Text('Item $index')),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: Colors.purple,
              child: Center(child: Text('SliverToBoxAdapter')),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.orange,
      child: Center(child: Text('Persistent Header')),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
