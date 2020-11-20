import 'dart:collection';
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
  String bestBaord = '''
  query bestboard(\$minDate: String!, \$maxDate: String!, \$size: Int!) {
    bestBoard(minDate: \$minDate, maxDate: \$maxDate, size: \$size) {
      category
      recommendCount
      content
      subject
      writer
      readCount
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

    var boardsButton = Container(
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.note_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WritePage(client: widget.client),
                ),
              );
            },
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(documentNode: gql(bestBaord), variables: {
          'minDate': '2020-11-01',
          'maxDate': '2020-11-20',
          'size': 10,
        }),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Text('loading');
          }

          List bestBoard = result.data['bestBoard'];
          Map read = bestBoard[0];

          var boards = [];
          for (var i = 0; i < bestBoard.length; i++) {
            boards.add(
              ListEntry(
                read['categories'].toString(),
                read['recommedCount'].toString(),
                read['title'].toString(),
                read['content'].toString(),
                read['writer'].toString(),
                read['view'].toString(),
              ),
            );
          }

          return Column(
            children: [
              boardsButton,
              Container(
                padding: const EdgeInsets.all(3.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                ),
                child: ListTile(
                  title: Text(boards[0].title),
                  subtitle: Text(boards[0].writer),
                  leading: Icon(
                    Icons.dashboard,
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
            label: '알림',
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: '계정',
            icon: Icon(Icons.account_box),
          ),
        ],
        selectedItemColor: Color(0xFF3C63D9),
      ),
    );
  }
}

class Board extends StatelessWidget {
  const Board(this.board);

  final ListEntry board;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 3.0,
      ),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: ListTile(
        title: Text(board.title),
        subtitle: Text(board.writer),
        trailing: new Row(
          verticalDirection: VerticalDirection.up,
        ),
        onTap: () {
          // Navigator.pushNamed(context, '/forum/1');
        },
      ),
    );
  }
}

class ListEntry {
  final String category;
  final String recommedCount;
  final String title;
  final String content;
  final String writer;
  final String view;
  ListEntry(this.category, this.recommedCount, this.title, this.content,
      this.writer, this.view);
}
