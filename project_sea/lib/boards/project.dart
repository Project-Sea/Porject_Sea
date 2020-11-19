import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로젝트 게시판'),
        centerTitle: true,
      ),
    );
  }
}
