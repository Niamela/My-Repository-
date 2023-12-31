import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LocalizationHelper {
  final Locale locale;

  LocalizationHelper(this.locale);

  static LocalizationHelper? of(BuildContext context) {
    return Localizations.of(context, LocalizationHelper);
  }

  static const LocalizationsDelegate<LocalizationHelper> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> _load() async {
    String jsonString =
        await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String _translate(String key) {
    return _localizedStrings![key]!;
  }

  String get appName => _translate('appName');

  String get description => _translate('description');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationHelper> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'fr',
    ].contains(locale.languageCode);
  }

  @override
  Future<LocalizationHelper> load(
    Locale locale,
  ) async {
    LocalizationHelper localizations = new LocalizationHelper(
      locale,
    );
    await localizations._load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
