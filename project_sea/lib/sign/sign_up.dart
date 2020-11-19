import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text('Sign Up'),
        ),
        body: Mutation(
          options: MutationOptions(
            documentNode: gql('''
              mutation(\$nickname: String!, \$username: String!, \$password: String!){
                signUp(username: \$username, nickname: \$nickname, password: \$password) {
                  username
                }
              }
          '''),
          ),
          builder: (
            RunMutation runMutation,
            QueryResult queryResult,
          ) {
            return Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    height: 200,
                    alignment: Alignment.center,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Nickname',
                      filled: true,
                      fillColor: Color(0x2F3C63D9),
                    ),
                    controller: nicknameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'University e-mail (~@ptu.ac.kr)',
                      filled: true,
                      fillColor: Color(0x2F3C63D9),
                    ),
                    controller: usernameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Color(0x2F3C63D9),
                    ),
                    controller: passwordController,
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      runMutation(
                        {
                          'nickname': nicknameController.text,
                          'username': usernameController.text,
                          'password': passwordController.text,
                        },
                      );
                      if (queryResult.exception == null) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Text("Error : ${queryResult.exception.toString()}"),
                  Text("Result : ${queryResult.data}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
