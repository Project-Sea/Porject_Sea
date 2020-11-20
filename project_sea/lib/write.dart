import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class WritePage extends StatefulWidget {
  WritePage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  final items = ['NOTICE', 'FREE', 'DEPARTMENT'];
  var _selected = '자유';

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String mutation = '''
  mutation CreateBoard(\$subject: String!, \$content: String!, \$category: String!){
    createBoard(subject: \$subject, content: \$content, category: \$category)
  }
  ''';
  String category;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Write'),
        actions: [
          IconButton(
            icon: Icon(Icons.app_registration),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Mutation(
        options: MutationOptions(documentNode: gql(mutation)),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return Column(
            children: [
              DropdownButton(
                items: widget.items.map((value) {
                  return DropdownMenuItem(
                    value: widget._selected,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget._selected = value;
                    category = widget.items[value];
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Content'),
                controller: contentController,
              ),
              RaisedButton(
                child: Text('등록'),
                onPressed: () {
                  runMutation(
                    {
                      'category': category,
                      'subject': titleController.text,
                      'content': contentController.text,
                    },
                  );
                  if (result.exception == null) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
