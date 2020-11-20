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
  String query = '''
  query searchBoard(\$category: String!){
    searchBoard(category: \$category){
      boards{
        subject
      }
    }
  }
  ''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유 게시판'),
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(query),
          variables: {
            'category': 'FREE',
          },
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          // List free = result.data['searchBoard']['subject'];
          // Map read = free[0];
          return Column(
            children: [
              Container(
                child: Text(result.data.toString()),
              ),
              // Text(read[0].toString())
            ],
          );
        },
      ),
    );
  }
}
