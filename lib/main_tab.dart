import 'package:dim_app_flutter/contact_list.dart';
import 'package:dim_app_flutter/res.dart';
import 'package:dim_app_flutter/user_info.dart';
import 'package:flutter/material.dart';

import 'chat_list.dart';

class MainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainTabPageState();
  }
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
          _Header(),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [ChatListPage(), ContactListPage()],
          ))
        ])),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.chat), title: Text('Chat')),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.group), title: Text('Friends'))
            ],
            currentIndex: _tabIndex,
            onTap: (int index) {
              setState(() {
                _tabIndex = index;
              });
              _tabController.animateTo(index);
            },
            fixedColor: kColorPrimary));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          InkWell(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://avatars3.githubusercontent.com/u/2757460?s=460&v=4',
              ),
              backgroundColor: Colors.transparent,
              radius: 32,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfoPage('sickworm')));
            },
          ),
          const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text('Sickworm', style: const TextStyle(fontSize: 28))),
          const Flexible(fit: FlexFit.tight, child: SizedBox()),
          IconButton(
            icon: Icon(Icons.add, size: 32),
            onPressed: () {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('add button')));
            },
          )
        ]));
  }
}
