


// @GenerateMocks([CountryRepository])
// void main() {
//   late GetCountriesUseCase useCase;
//   late MockCountryRepository mockRepository;
//
//   setUp(() {
//     mockRepository = MockCountryRepository();
//     useCase = GetCountriesUseCase(mockRepository);
//   });
//
//   test('should return a list of countries', () async {
//     // Arrange
//     when(mockRepository.getCountries()).thenAnswer(
//           (_) async => ['Peru', 'Colombia', 'Mexico'],
//     );
//
//     // Act
//     final result = await useCase();
//
//     // Assert
//     expect(result, ['Peru', 'Colombia', 'Mexico']);
//   });
// }
