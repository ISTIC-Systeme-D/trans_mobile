import 'package:trans_mobile/back/model.dart';

class ArtistsFilter {
  Map<String, bool> countriesFilter = {};
  Map<String, bool> yearsFilter = {};
  Map<String, Map<String, bool>> filters = {};

  ArtistsFilter(TransModel model) {
    _generateFilters(model);
  }

  void _generateCountriesFilter(TransModel model) {
    for (var country in model.countries) {
      countriesFilter.addEntries({country: true}.entries);
    }
  }

  void _generateYearsFilter(TransModel model) {
    for (var year in model.years) {
      yearsFilter.addEntries({year: true}.entries);
    }
  }

  void _generateFilters(TransModel model) {
    _generateCountriesFilter(model);
    _generateYearsFilter(model);
    filters = {'Pays': countriesFilter, 'Éditions': yearsFilter};
  }
}
