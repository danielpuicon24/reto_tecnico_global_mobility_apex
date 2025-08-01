import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasource/country_graphql_datasource.dart';


class CountryRepositoryImpl implements CountryRepository {
  final CountryGraphQLDatasource datasource;

  CountryRepositoryImpl(this.datasource);

  @override
  Future<List<Country>> getCountries() async {
    final models = await datasource.fetchCountries();
    return models.map((model) => model.toEntity()).toList();
  }
}
