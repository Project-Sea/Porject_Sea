import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String read = '''
  query {
    myProfile {
      nickname,
      permission,
      username,
      createdTime,
    }
  }
  ''';

  @override
  Widget build(BuildContext context) {
    var boardIcon = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text(
              '공지',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(client: widget.client),
                ),
              );
            },
          ),
          RaisedButton(
            child: Text(
              '자유',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralPage(client: widget.client),
                ),
              );
            },
          ),
          RaisedButton(
            child: Text(
              '학과',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentPage(client: widget.client),
                ),
              );
            },
          ),
          RaisedButton(
            child: Text(
              '프로젝트',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectPage(client: widget.client),
                ),
              );
            },
          ),
        ],
      ),
    );

    var boards = Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: boardIcon,
      ),
    );

    return GraphQLProvider(
      client: widget.client,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.message),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: ListView(
          children: [
            boards,
          ],
        ),
        // body: Query(
        //   options: QueryOptions(documentNode: gql("""
        //       query {
        //         myProfile {
        //           username,
        //           nickname
        //         }
        //       }
        //     """)),
        //   builder: (QueryResult result,
        //       {VoidCallback refetch, FetchMore fetchMore}) {
        //     if (result.exception != null) {
        //       return Center(
        //           child: Text("에러가 발생했습니다.\n${result.exception.toString()}"));
        //     }
        //     if (result.loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       //print(result.exception.toString());
        //       var user = json.decode(result.data.toString());
        //       print(user['myProfile']);

        //       return Text(result.data);
        //     }
        //   },
        // ),
        // body: Query(
        //   options: QueryOptions(documentNode: gql("""
        //       query {
        //         myProfile {
        //           username,
        //           nickname
        //         }
        //   }
        // """)),
        //   builder: (QueryResult result,
        //       {VoidCallback refetch, FetchMore fetchMore}) {
        //     if (result.exception != null) {
        //       return Center(
        //           child: Text("에러가 발생했습니다.\n${result.exception.toString()}"));
        //     }
        //     if (result.loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       print(result.data.toString());
        //       return Text(result.data);
        //     }
        //   },
        // ),
        // body: Query(
        //   options: QueryOptions(
        //     documentNode: gql('''
        //       query {
        //         myProfile {
        //           nickname,
        //           permission,
        //           username,
        //           createdTime,
        //         }
        //       }
        //       '''),
        //   ),
        //   builder: (QueryResult result,
        //       {VoidCallback refetch, FetchMore fetchMore}) {
        //     if (result.hasException) {
        //       return Text(result.exception.toString());
        //     }
        //     print(result.exception.toString());

        //     if (result.loading) {
        //       return Text('Loading');
        //     }
        //     return ListView(
        //       children: <Widget>[
        //         _boards(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         _best(),
        //         Text(result.data),
        //       ],
        //     );
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(client: widget.client)),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccountPage(client: widget.client)),
              );
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: '계정',
              icon: Icon(Icons.account_box),
            ),
          ],
          selectedItemColor: Color(0xFF3C63D9),
        ),
      ),
    );
  }
}
