import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../data/datasource/country_graphql_datasource.dart';
import '../../data/repositories/country_repository_impl.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/get_countries_usecase.dart';


final countryListProvider = FutureProvider<List<Country>>((ref) async {
  final useCase = ref.watch(getCountriesUseCaseProvider);
  return useCase();
});

final getCountriesUseCaseProvider = Provider<GetCountriesUseCase>((ref) {
  final repo = ref.watch(countryRepositoryProvider);
  return GetCountriesUseCase(repo);
});

final countryRepositoryProvider = Provider((ref) {
  final datasource = ref.watch(countryDatasourceProvider);
  return CountryRepositoryImpl(datasource);
});

final countryDatasourceProvider = Provider((ref) {
  final client = ref.watch(graphqlClientProvider);
  return CountryGraphQLDatasource(client);
});

// Provide GraphQLClient globally
final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final link = HttpLink('https://countries.trevorblades.com/');
  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
});