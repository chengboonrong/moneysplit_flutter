import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TransactionHistoryPage extends HookWidget {
  const TransactionHistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: RefreshIndicator(
            onRefresh: () {},
            child: SingleChildScrollView(
              child: Center(
                  child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height,
                      child: Text('haha'))),
            )),
      ),
    );
  }
}
