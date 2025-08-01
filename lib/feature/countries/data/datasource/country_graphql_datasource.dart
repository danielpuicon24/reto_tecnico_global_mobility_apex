import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/country_model.dart';
import 'country_query.dart';

class CountryGraphQLDatasource {
  final GraphQLClient client;

  CountryGraphQLDatasource(this.client);

  Future<List<CountryModel>> fetchCountries() async {
    final result = await client.query(
      QueryOptions(document: gql(getCountriesQuery)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List countries = result.data?['countries'] ?? [];
    return countries.map((e) => CountryModel.fromJson(e)).toList();
  }
}
