import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Navigator(
      pages: [
        MaterialPage(child: UsersView(
          didSelectUser: (user) {
            setState(() => _selectedUser = user);
          },
        )),
        if (_selectedUser != null)
          MaterialPage(
              child: UserDetailsView(user: _selectedUser.toString()),
              key: UserDetailsView.valueKey)
      ],
      onPopPage: (route, result) {
        final page = route.settings as MaterialPage;

        if (page.key == UserDetailsView.valueKey) {
          _selectedUser = null;
        }

        return route.didPop(result);
      },
    ));
  }
}

class UsersView extends StatelessWidget {
  final _users = ["Daniel", "Roberta", "Martin", "Maria", "Tedi"];

  final ValueChanged didSelectUser;

  UsersView({Key? key, required this.didSelectUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            final user = _users[index];
            return Card(
                child: ListTile(
              title: Text(user),
              onTap: () => didSelectUser(user),
            ));
          }),
    );
  }
}

class UserDetailsView extends StatelessWidget {
  static const valueKey = ValueKey('UserDetailsView');

  final String user;

  UserDetailsView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Center(child: Text('Hello, $user')));
  }
}
