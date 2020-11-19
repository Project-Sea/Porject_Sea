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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _boards(),
          SizedBox(
            height: 20,
          ),
          _best(),
        ],
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
            label: '계정',
            icon: Icon(Icons.account_box),
          ),
        ],
        selectedItemColor: Color(0xFF3C63D9),
      ),
    );
  }

  Widget _boards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }

  Widget _best() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('제목')),
        DataColumn(label: Text('작성자')),
        DataColumn(label: Text('조회수')),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: null,
        ),
      ],
    );
  }
}