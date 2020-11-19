import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.client}) : super(key: key);
  final ValueNotifier<GraphQLClient> client;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String signIn = '''
  mutation(\$username: String!, \$password: String!){
    signIn(username: \$username, password: \$password, scopes: ["board_read", "board_write", "notification_read", "project_read", "project_write", "team_read"]) {
      access_token,
      scope
    }
  }''';

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text('Welcome'),
        ),
        body: Mutation(
          options: MutationOptions(
            documentNode: gql(signIn),
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
                    // child: Image.asset(
                    //   'img/Logo.png',
                    //   fit: BoxFit.fill,
                    // ),
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
                    child: Text('Sign In'),
                    onPressed: () {
                      runMutation(
                        {
                          'username': usernameController.text,
                          'password': passwordController.text,
                        },
                      );
                      if (queryResult.exception == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(client: widget.client),
                          ),
                        );
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpPage(client: widget.client)),
                      );
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
