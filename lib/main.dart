import 'package:flutter/material.dart';
import 'package:restfullapi_example/models/user_model.dart';
import 'package:restfullapi_example/services/user_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  UserService _service = UserService();
  List<UsersModelData?> users = [];
  bool? isLoading;

  @override
  void initState() {
    super.initState();
    _service.fetchUser().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber[200],
        fontFamily: 'Verdana',
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Restfull Api Example'),
          ),
          body: isLoading == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                "${users[index]!.firstName! + users[index]!.lastName!}"),
                            subtitle: Text(users[index]!.email!),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(users[index]!.avatar!),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text("Bir sorun oluştu"),
                    )),
    );
  }
}
