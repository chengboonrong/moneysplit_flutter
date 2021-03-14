import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneysplit_flutter/members.dart';

class AddTransactionPage extends HookWidget {
  const AddTransactionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memberList = useProvider(members);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Hero(
              child: Icon(Icons.add),
              tag: "addTransaction",
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: memberList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(memberList[index].name),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              print(
                                  'You have borrowed RM 10.00 from ${memberList[index].name}');
                              context
                                  .read(memberListProvider)
                                  .addTransactionBorrowed(index, 10.0);
                              Navigator.pop(context);
                              print(
                                  '[ ] Added new transaction : ${memberList[index].name}');
                            },
                            child: Text('Borrow')),
                        TextButton(
                            onPressed: () {
                              print(
                                  'You have lent RM 10.00 to ${memberList[index].name}');
                              context
                                  .read(memberListProvider)
                                  .addTransactionLent(index, 10.0);
                              Navigator.pop(context);
                              print(
                                  '[ ] Added new transaction : ${memberList[index].name}');
                            },
                            child: Text('Lent')),
                      ],
                    ),
                  ],
                ),
                onTap: () {});
          },
        ),
      ),
    );
  }
}
