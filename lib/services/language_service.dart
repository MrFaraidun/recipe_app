import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';

  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<Locale> getLocale() async {
    final languageCode = await getLanguage();
    return Locale(languageCode);
  }
}

class LanguageNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await LanguageService.setLanguage(languageCode);
    notifyListeners();
  }

  Future<void> loadSavedLanguage() async {
    _locale = await LanguageService.getLocale();
    notifyListeners();
  }
}
