import 'dart:ui';

import 'package:camion/core/cache/cache_helper.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localizations_state.dart';

class LocalizationsCubit extends Cubit<Locale> {
  LocalizationsCubit() : super(const Locale('en'));

  Future<void> loadSavedLanguage() async {
    final savedLangCode = sl<CacheHelper>().getData(key:  'languageCode') ?? 'en';
    emit(Locale(savedLangCode));
  }

  Future<void> changeLocale({required Locale locale}) async{
    await sl<CacheHelper>().saveData(key: 'languageCode', value: locale.languageCode);
    emit(locale);
  }
}
