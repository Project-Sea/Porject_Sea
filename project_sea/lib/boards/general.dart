import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class GeneralPage extends StatefulWidget {
  GeneralPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;
  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유 게시판'),
        centerTitle: true,
      ),
    );
  }
}
