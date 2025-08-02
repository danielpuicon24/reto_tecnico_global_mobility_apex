import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reto_tecnico_apex/feature/countries/domain/entities/country.dart';
import 'package:reto_tecnico_apex/feature/countries/domain/usecases/get_countries_usecase.dart';

import '../presentation/providers/mocks_country.mocks.dart';


void main() {
  group('GetCountriesUseCase', () {
    late MockCountryRepository mockRepository;
    late GetCountriesUseCase useCase;

    setUp(() {
      mockRepository = MockCountryRepository();
      useCase = GetCountriesUseCase(mockRepository);
    });

    test('should return list of countries from repository', () async {
      // Arrange
      final fakeCountries = [
        const Country(name: 'Peru', code: 'PE', emoji: '', phone: '51'),
        const Country(name: 'Brazil', code: 'BR', emoji: '', phone: '55'),
      ];
      when(mockRepository.getCountries()).thenAnswer((_) async => fakeCountries);

      // Act
      final result = await useCase();

      // Assert
      expect(result, fakeCountries);
      verify(mockRepository.getCountries()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
