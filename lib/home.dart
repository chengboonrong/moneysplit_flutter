import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneysplit_flutter/addTransaction.dart';
import 'package:moneysplit_flutter/members.dart';
import 'package:moneysplit_flutter/svg.dart';

class HomePage extends HookWidget {
  HomePage({Key key}) : super(key: key);

  final List<Widget> pages = <Widget>[
    HomeBalances(),
    HomeTransactions(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Profile'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              'Home ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            SvgPicture.string(homeIcon),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xFF173A60).withOpacity(0.5),
          onTap: (value) => selectedIndex.value = value,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: '')
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "addTransaction",
        backgroundColor: Color(0xFF173A60),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddTransactionPage()));
        },
      ),
      body: Center(
        child: pages.elementAt(selectedIndex.value),
      ),
    );
  }
}

class HomeBalances extends ConsumerWidget {
  const HomeBalances({Key key, this.selectedIndex}) : super(key: key);

  final selectedIndex;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final memberList = watch(memberListProvider.state);

    List<double> totalBalances(var memberList) {
      print(memberList);
      double totalBalanceYouOwnedTo = 0;
      double totalBalanceYouBorrowedTo = 0;
      for (var member in memberList) {
        final balance = member.balanceYouOwnedTo - member.balanceYouBorrowedTo;
        if (balance > 0)
          totalBalanceYouOwnedTo += balance.abs();
        else
          totalBalanceYouBorrowedTo += balance.abs();
      }
      return [
        totalBalanceYouBorrowedTo,
        totalBalanceYouOwnedTo,
      ];
    }

    final _totalBalances = totalBalances(memberList);

    return SingleChildScrollView(
      child: Consumer(builder: (context, watch, child) {
        return Column(
          children: [
            Column(
              children: [
                // My summary card
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 20.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  width: 362,
                  height: 169,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 32.5,
                            child: ClipOval(
                              child: Image.asset(
                                'images/1.png',
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Ashe Louis\n',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'ashe8372@gmail.com',
                                    style: TextStyle(
                                        color: Color(0xFFA3A3A3), fontSize: 18),
                                  )
                                ]),
                          )
                        ],
                      ),
                      Container(
                        width: 300,
                        height: 1,
                        color: Color(0xFF9A9A9A).withOpacity(0.9),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add,
                            color: Color(0xFF3FD627),
                          ),
                          Text('RM ${_totalBalances[0]}'),
                          Icon(
                            Icons.remove,
                            color: Color(0xFFE51E1E),
                          ),
                          Text('RM ${_totalBalances[1]}'),
                        ],
                      ),
                    ],
                  ),
                  // Members
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 29.0),
                  child: Row(
                    children: [
                      Text(
                        'Members ',
                        style: TextStyle(fontFamily: 'Centaur', fontSize: 24),
                      ),
                      SvgPicture.string(membersIcon),
                    ],
                  ),
                ),
                // Column(
                // children: [
                // memberWidget(
                //     'images/2.png', 'Toh Jing Wei', 'RM 450.00', true),
                // memberWidget('images/3.png', 'Wenrong', 'RM 100.00', false),
                // memberWidget('images/4.png', 'Boon Hua', 'RM 20.00', false),
                // memberWidget('images/4.png', 'Boon Hua', 'RM 20.00', false),
                // memberWidget('images/4.png', 'Boon Hua', 'RM 20.00', false),
                // memberWidget('images/4.png', 'Boon Hua', 'RM 20.00', false),
                // ],
                // ),

                for (var member in memberList)
                  memberWidget(
                    'images/2.png',
                    member.name,
                    (member.balanceYouOwnedTo - member.balanceYouBorrowedTo) ==
                            0
                        ? 'Settled'
                        : (member.balanceYouOwnedTo -
                                    member.balanceYouBorrowedTo) >
                                0
                            ? 'you owe \nRM ${(member.balanceYouOwnedTo - member.balanceYouBorrowedTo).abs().toStringAsFixed(2)}'
                            : 'owes you \nRM ${(member.balanceYouOwnedTo - member.balanceYouBorrowedTo).abs().toStringAsFixed(2)}',
                    (member.balanceYouOwnedTo - member.balanceYouBorrowedTo) ==
                            0
                        ? null
                        : (member.balanceYouOwnedTo -
                                    member.balanceYouBorrowedTo) >
                                0
                            ? false
                            : true,
                  )
              ],
            ),
          ],
        );
      }),
    );
  }
}

Widget memberWidget(String imageSrc, String _name, String balance, bool add) {
  return Padding(
    padding: const EdgeInsets.all(17.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20.0,
              spreadRadius: 2.0,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30)),
      width: 362,
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 25,
            child: ClipOval(
              child: Image.asset(
                imageSrc,
              ),
            ),
          ),
          Text(_name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (add == null)
                Icon(
                  Icons.thumb_up_alt,
                )
              else
                add
                    ? Icon(
                        Icons.add,
                        color: Color(0xFF3FD627),
                      )
                    : Icon(
                        Icons.remove,
                        color: Color(0xFFE51E1E),
                      ),
              Text(balance),
            ],
          ),
        ],
      ),
    ),
  );
}

class HomeTransactions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
        body: new Container(
      child: new Center(
        child: Stack(
          children: [
            Center(child: Text('Hahahha')),
            new RefreshIndicator(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 2 - 100,
                      horizontal: MediaQuery.of(context).size.width / 2.25),
                  children: List.generate(0, (f) => Text("Item $f")),
                ),
                onRefresh: () {
                  return Future.value(false);
                }),
          ],
        ),
      ),
    ));
  }
}
