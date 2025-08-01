import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reto_tecnico_apex/config/theme/app_colors.dart';
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
        data: (countries) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (_, index) {
              final country = countries[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge,
                      ),
                      SizedBox(height: height * 0.015),
                      Text(
                        'Código: ${country.code}',
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium,
                      ),
                      SizedBox(height: height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            country.emoji,
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium,
                          ),
                          Text('+${country.phone}')
                        ],
                      )

                    ],
                  ),
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary,)),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
