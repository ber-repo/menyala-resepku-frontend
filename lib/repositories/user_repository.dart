import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signUpUser(String userName, String email, String password) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');

  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation SignUp($userName: String!, $email: String!, $password: String!) {
      signUp(userName: $userName, email: $email, password: $password) {
        id
        userName
        email
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'userName': userName,
      'email': email,
      'password': password,
    },
  );

  final result = await client.mutate(options);

  if (result.hasException) {
    print(result.exception.toString());
  } else {
    print(result.data);
  }
}

Future<bool> loginUser(String email, String password) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation LogIn($email: String!, $password: String!) {
      logIn(email: $email, password: $password) {
        id
        email
        token
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'email': email,
      'password': password,
    },
  );

  final result = await client.mutate(options);

  if (result.hasException) {
    print(result.exception.toString());
    return false;
  } else {
    print(result.data);
    // save token JWT
    final token = result.data?['logIn']?['token'];
    final userId = result.data?['logIn']?['id']?.toString();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token ?? '');
    await prefs.setString('user_id', userId ?? '');
    return true;
  }
}

