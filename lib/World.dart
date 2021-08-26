import 'package:flagscoloring_pixelart/DataStorage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'dart:convert';

class Country {
    String title;
    List<List<int>> pixels;
    List<String> colors;
    bool isEasySolved = false;
    bool isNormalSolved = false;

    Country({required this.title, required this.pixels, required this.colors});

    factory Country.fromJson(String countryTitle, Map<String, dynamic> data) {
        Country country = Country(
            title: countryTitle, 
            pixels: List<List<dynamic>>
                  .from(data['pixels'])
                  .map((row) => row.map((pixel) => pixel as int).toList())
                  .toList(),
            colors: List<String>.from(data['colors']));

        return country;
    }

    @override
    String toString() {
        return title;
    }
}

class Continent {
    String title;
    List<Country> countries = [];

    Continent({required this.title});

    factory Continent.fromJson(String continentTitle, Map<String, dynamic> countries) {
        Continent continent = Continent(title: continentTitle);
        countries.forEach((countryTitle, data) {
            continent.countries.add(Country.fromJson(countryTitle, data));
        });

        continent.countries.sort((a, b) {
            return a.title.compareTo(b.title);
        });

        return continent;
    }

    bool get isEasySolved {
        return countries.length == countries.where((country) => country.isEasySolved).length;
    }

    bool get isNormalSolved {
        return countries.length == countries.where((country) => country.isNormalSolved).length;
    }

    int get totalStars {
        return 2 * countries.length;
    }

    int get totalSolvedCountries {
        return totalNormalSolvedStars;
    }

    int get totalSolvedStars {
        return totalEasySolvedStars + totalNormalSolvedStars;
    }

    int get totalEasySolvedStars {
        return countries.where((country) => country.isEasySolved).length;
    }

    int get totalNormalSolvedStars {
        return countries.where((country) => country.isNormalSolved).length;
    }

    Country getCountryByTitle(String countryTitle) {
        return countries.firstWhere((country) => country.title == countryTitle);
    }

    @override
    String toString() {
        return '{$title: $countries}';
    }
}

class World {
	static List<Continent> continents = [];

	static Future<bool> init() async {

        Future<String> loadAsset() async {
            return await rootBundle.loadString('assets/data/world.json');
        }

		Future<bool> fetchCountries() async {
			await loadAsset().then((val) {
                Map<String, dynamic> data = jsonDecode(val);

                data['world'].forEach((title, value) {
                    continents.add(Continent.fromJson(title, value));
                });

                continents.sort((a, b) {
                    return a.title.compareTo(b.title);
                });
            });

			return true;
		}

		return fetchCountries();
    }

    static Continent getContinentByTitle(String continentTitle) {
        return continents.firstWhere((continent) => continent.title == continentTitle);
    }

    static int get totalCountries {
        int count = 0;

        continents.forEach((continent) {
            count += continent.countries.length;
        });

        return count;
    }

    static int get totalSolvedCountries {
        int count = 0;

        continents.forEach((continent) {
            count += continent.totalSolvedCountries;
        });

        return count;
    }

    static int get totalEasySolvedCountries {
        int count = 0;

        continents.forEach((continent) {
            count += continent.totalEasySolvedStars;
        });

        return count;
    }

    static int get totalNormalSolvedCountries {
        int count = 0;

        continents.forEach((continent) {
            count += continent.totalNormalSolvedStars;
        });

        return count;
    }

    static int get totalEasySolvedStars {
        int count = 0;

        continents.forEach((continent) {
            count += continent.totalEasySolvedStars;
        });

        return count;
    }

    static int get totalNormalSolvedStars {
        int count = 0;

        continents.forEach((continent) {
            count += continent.totalNormalSolvedStars;
        });

        return count;
    }

        static int get totalStars {
        int count = 0;

        continents.forEach((continent) {
            count += continent.countries.length;
        });

        return count * 2;
    }

    static get totalSolvedStars {
        return totalEasySolvedStars + totalNormalSolvedStars;
    }

    static bool get isEasySolved {
        return totalCountries == totalEasySolvedCountries;
    }

    static bool get isNormalSolved {
        return totalCountries == totalNormalSolvedCountries;
    }

    static void storeData() {
		String str = '{"world":{';

        int continentIdx = World.continents.length;
        World.continents.forEach((continent) {
            str += '"${continent.title}":{';
            int countryIdx = continent.countries.length;
            continent.countries.forEach((country) {
                str += '"${country.title}":{"isEasySolved":${country.isEasySolved},"isNormalSolved":${country.isNormalSolved}}';

                str += '${(--countryIdx > 0 ? ',' : '')}';
            });
            str += '${(--continentIdx > 0 ? '},' : '')}';
        });

        str += '}},"hints":$hints}';

		DataStorage.writeData(str);
    }

    static loadDataStorage() {
		DataStorage.fileExists().then((value) {
			if (value) {
				DataStorage.readData().then((value) {
					if (value.isNotEmpty) {
						Map<String, dynamic> data = jsonDecode(value);

                        data['world'].forEach((continentTitle, countriesData) {
                            Continent continent = getContinentByTitle(continentTitle);

                            Map<String, dynamic> countries = countriesData;

                            countries.forEach((countryTitle, countryData) {
                                Country? country = continent.getCountryByTitle(countryTitle);

                                country.isEasySolved = countryData['isEasySolved'];
                                country.isNormalSolved = countryData['isNormalSolved'];
                            });
                        });

                        hints = data['hints'];
                    }
				});
			} else {
				DataStorage.createFile();
			}
		});
	}
}

int hints = 23;