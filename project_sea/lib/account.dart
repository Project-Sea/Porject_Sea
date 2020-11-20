import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String myProfile = '''
    query {
      myProfile {
        nickname
        username
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('계정정보'),
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(myProfile),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Text('loading');
          }
          Map myProfile = result.data['myProfile'];
          return Column(
            children: <Widget>[
              Text(myProfile['nickname'].toString()),
              Text(myProfile['username'].toString()),
            ],
          );
        },
      ),
    );
  }
}
