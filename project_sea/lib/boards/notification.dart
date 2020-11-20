import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String query = '''
  query searchBoard(\$category: String!){
    searchBoard(catgory: \$category) {
      boards {
        content
      }
    }
  }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지'),
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(documentNode: gql(query), variables: {
          'category': 'NOTICE',
        }),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Text(result.data.toString());
        },
      ),
    );
  }
}
