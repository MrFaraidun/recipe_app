import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    // Try directory-based localization first: lib/l10n/<lang>/*.json
    final String lang = locale.languageCode;
    final String manifestContent = await rootBundle.loadString(
      'AssetManifest.json',
    );
    final Map<String, dynamic> manifestMap =
        json.decode(manifestContent) as Map<String, dynamic>;

    final String dirPrefix = 'lib/l10n/$lang/';
    final List<String> langFiles = manifestMap.keys
        .where((path) => path.startsWith(dirPrefix) && path.endsWith('.json'))
        .cast<String>()
        .toList();

    Map<String, String> merged = <String, String>{};

    if (langFiles.isNotEmpty) {
      for (final String path in langFiles) {
        final String fileContent = await rootBundle.loadString(path);
        final Map<String, dynamic> jsonMap =
            json.decode(fileContent) as Map<String, dynamic>;
        jsonMap.forEach((key, value) {
          merged[key] = value.toString();
        });
      }
      _localizedStrings = merged;
      return true;
    }

    // Fallback to single-file localization: lib/l10n/<lang>.json
    final String fallbackPath = 'lib/l10n/$lang.json';
    final String jsonString = await rootBundle.loadString(fallbackPath);
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ckb', 'kmr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
