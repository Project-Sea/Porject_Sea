import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class DepartmentPage extends StatefulWidget {
  DepartmentPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('학과 게시판'),
        centerTitle: true,
      ),
    );
  }
}
