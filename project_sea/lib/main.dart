import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_sea/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(uri: 'http://jys2erver.site/graphql'),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFFFFFFF),
          accentColor: Color(0xFF3C63D9),
          buttonColor: Color(0x9F3C63D9),
          textTheme: TextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => SignInPage(client: client),
          '/sign_up': (context) => SignUpPage(client: client),
          '/home': (context) => HomePage(client: client),
          '/notification': (context) => NotificationPage(client: client),
          '/general': (context) => GeneralPage(client: client),
          '/department': (context) => DepartmentPage(client: client),
          '/project': (context) => ProjectPage(client: client),
          '/account': (context) => AccountPage(client: client),
          '/write': (context) => WritePage(client: client),
        },
        initialRoute: '/',
      ),
    );
  }
}
