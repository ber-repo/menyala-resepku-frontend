import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

Future<Map<String, dynamic>?> addRecipe(String recipeName, List<String> images, String recipeDescription) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation AddRecipe($recipeName: String!, $images: [String!], $recipeDescription: String) {
      addRecipe(recipeName: $recipeName, images: $images, recipeDescription: $recipeDescription) {
        id
        recipeName
        images {
          id
          downloadUrl
        }
        recipeDescription
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'recipeName': recipeName,
      'images': images,
      'recipeDescription': recipeDescription,
    },
  );

  final result = await client.mutate(options);

  if (result.hasException) {
    print(result.exception.toString());
    return null;
  } else {
    return result.data?['addRecipe'];
  }
}


Future<void> addIngredient(String name, int recipeId) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation AddIngredient($ingredientName: String!, $recipeId: ID!) {
      addIngredient(ingredientName: $ingredientName, recipeId: $recipeId) {
        id
        ingredientName
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'ingredientName': name,
      'recipeId': recipeId,
    },
  );

  final result = await client.mutate(options);
  if (result.hasException) {
    print(result.exception.toString());
  }
}

Future<void> addStep(String stepDescription, int recipeId) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation AddStep($stepDescription: String!, $recipeId: ID!) {
      addStep(stepDescription: $stepDescription, recipeId: $recipeId) {
        id
        stepDescription
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'stepDescription': stepDescription,
      'recipeId': recipeId,
    },
  );

  final result = await client.mutate(options);
  if (result.hasException) {
    print(result.exception.toString());
  }
}

Future<void> setRecipeCategory(String category, int recipeId) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );

  const String mutation = r'''
    mutation SetRecipeCategory($recipeId: ID!, $categoryName: String!) {
      setRecipeCategory(recipeId: $recipeId, categoryName: $categoryName) {
        id
        category { id name }
      }
    }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'recipeId': recipeId,
      'categoryName': category,
    },
  );

  final result = await client.mutate(options);
  if (result.hasException) {
    print(result.exception.toString());
  }
}

Future<void> setRecipeFavorite(int recipeId, bool isFavorite) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
  const String mutation = r'''
    mutation SetRecipeFavorite($recipeId: ID!, $isFavorite: Boolean!) {
      setRecipeFavorite(recipeId: $recipeId, isFavorite: $isFavorite) {
        id
        isFavorite
      }
    }
  ''';
  final MutationOptions options = MutationOptions(
    document: gql(mutation),
    variables: {
      'recipeId': recipeId,
      'isFavorite': isFavorite,
    },
  );
  final result = await client.mutate(options);
  if (result.hasException) {
    print(result.exception.toString());
  }
}

Future<Map<String, dynamic>?> fetchRecipeById(dynamic recipeId) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
  const String query = r'''
    query RecipeById($id: ID!) {
      recipeById(id: $id) {
        id
        recipeName
        recipeDescription
        isFavorite
        category { name }
        images { downloadUrl }
        ingredients { ingredientName }
        steps { stepDescription }
      }
    }
  ''';
  final result = await client.query(QueryOptions(
    document: gql(query),
    variables: {'id': recipeId},
  ));
  if (result.hasException) {
    print(result.exception.toString());
    return null;
  }
  return result.data?['recipeById'];
}

Future<List<String>> fetchCategories() async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
  const String query = r'''
    query {
      allRecipe {
        category { name }
      }
    }
  ''';
  final result = await client.query(QueryOptions(document: gql(query)));
  if (result.hasException) {
    print(result.exception.toString());
    return [];
  }
  final recipes = result.data?['allRecipe'] as List;
  final categories = recipes
      .map((r) => r['category']?['name'])
      .where((name) => name != null)
      .toSet()
      .cast<String>()
      .toList();
  return categories;
}

Future<List<Map<String, dynamic>>> fetchRecipesByCategory(String category) async {
  final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
  const String query = r'''
    query {
      allRecipe {
        id
        recipeName
        recipeDescription
        isFavorite
        category { name }
        images { downloadUrl }
        ingredients { ingredientName }
        steps { stepDescription }
      }
    }
  ''';
  final result = await client.query(QueryOptions(document: gql(query)));
  if (result.hasException) {
    print(result.exception.toString());
    return [];
  }
  final recipes = (result.data?['allRecipe'] as List)
      .map((e) => e as Map<String, dynamic>)
      .where((r) => r['category']?['name'] == category)
      .toList();
  return recipes;
}