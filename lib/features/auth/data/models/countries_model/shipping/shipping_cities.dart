// import 'package:country_state_city/country_state_city.dart';

// /// هترجع Map بالشكل:
// /// { "EG": { "Cairo Governorate": ["Cairo", "Heliopolis", ...], ... }, ... }
// Future<Map<String, Map<String, List<String>>>> buildCountryStateCitiesMap(
//   List<String> countryCodes,
// ) async {
//   Map<String, Map<String, List<String>>> result = {};

//   for (String code in countryCodes) {
//     final states = await getStatesOfCountry(code);
//     Map<String, List<String>> stateCities = {};

//     for (var state in states) {
//       final cities = await getStateCities(code, state.isoCode);
//       stateCities[state.name] = cities.map((c) => c.name).toList();
//     }

//     result[code] = stateCities;
//   }

//   return result;
// }
