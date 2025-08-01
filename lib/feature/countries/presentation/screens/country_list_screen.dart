import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/country_provider.dart';

class CountryListPage extends ConsumerWidget {
  const CountryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countryListProvider);
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height / 10,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: width / 7,
                  height: height / 18,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Lista de Países',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      body: countriesAsync.when(
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          itemBuilder: (_, index) {
            final country = countries[index];
            return ListTile(
              leading: Text(country.emoji),
              title: Text(country.name),
              subtitle: Text(country.code),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
