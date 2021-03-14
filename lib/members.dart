import 'package:hooks_riverpod/hooks_riverpod.dart';

class Member {
  String name;
  double balanceYouOwnedTo;
  double balanceYouBorrowedTo;
  List<double> balances;

  Member({this.name, this.balanceYouOwnedTo, this.balanceYouBorrowedTo});
}

class MemberList extends StateNotifier {
  MemberList(List<Member> state) : super(state);

  void addTransactionLent(int index, double value) {
    state[index].balanceYouOwnedTo -= 10;
    state = state;
  }

  void addTransactionBorrowed(int index, double value) {
    state[index].balanceYouOwnedTo += 10.00;
    state = state;
  }
}

MemberList createMemberList(List values) {
  final List<Member> members = [];
  values.forEach((value) {
    members.add(value);
  });
  return MemberList(members);
}

final memberListProvider = StateNotifierProvider((_) => createMemberList([
      Member(
          name: 'Toh Jing Wei',
          balanceYouOwnedTo: 100.00,
          balanceYouBorrowedTo: 10.00),
      Member(
          name: 'Wenrong',
          balanceYouOwnedTo: 10.00,
          balanceYouBorrowedTo: 100.00),
      Member(
          name: 'Boon Hua',
          balanceYouOwnedTo: 50.00,
          balanceYouBorrowedTo: 50.00),
      Member(
          name: 'Zachary',
          balanceYouOwnedTo: 90.00,
          balanceYouBorrowedTo: 10.00),
      Member(name: 'Sean', balanceYouOwnedTo: 0.00, balanceYouBorrowedTo: 0.00),
    ]));

final members = Provider((ref) => ref.watch(memberListProvider.state));

final total = Provider((ref) => ref.watch(memberListProvider.state));
