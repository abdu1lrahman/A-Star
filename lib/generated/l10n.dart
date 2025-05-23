// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `You are a star`
  String get you_are {
    return Intl.message('You are a star', name: 'you_are', desc: '', args: []);
  }

  /// `Wanna be more positive and shine`
  String get wanna_be {
    return Intl.message(
      'Wanna be more positive and shine',
      name: 'wanna_be',
      desc: '',
      args: [],
    );
  }

  /// `You are in the perfect place`
  String get perfect {
    return Intl.message(
      'You are in the perfect place',
      name: 'perfect',
      desc: '',
      args: [],
    );
  }

  /// `We are here to get the best version of you`
  String get we_are_here {
    return Intl.message(
      'We are here to get the best version of you',
      name: 'we_are_here',
      desc: '',
      args: [],
    );
  }

  /// `Let's get you started`
  String get lets {
    return Intl.message(
      'Let\'s get you started',
      name: 'lets',
      desc: '',
      args: [],
    );
  }

  /// `let's start`
  String get getstarted {
    return Intl.message('let\'s start', name: 'getstarted', desc: '', args: []);
  }

  /// `language`
  String get language {
    return Intl.message('language', name: 'language', desc: '', args: []);
  }

  /// `Select your gender`
  String get gender {
    return Intl.message(
      'Select your gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Select your age`
  String get age {
    return Intl.message('Select your age', name: 'age', desc: '', args: []);
  }

  /// `What's your name?`
  String get name {
    return Intl.message('What\'s your name?', name: 'name', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `This information helps us generate personalized motivational messages for you`
  String get this_info {
    return Intl.message(
      'This information helps us generate personalized motivational messages for you',
      name: 'this_info',
      desc: '',
      args: [],
    );
  }

  /// `You can change these informations later`
  String get dont {
    return Intl.message(
      'You can change these informations later',
      name: 'dont',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name so we can send you more personalized notifications`
  String get enter_name {
    return Intl.message(
      'Enter your name so we can send you more personalized notifications',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Let's go`
  String get letsgo {
    return Intl.message('Let\'s go', name: 'letsgo', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `My account`
  String get account {
    return Intl.message('My account', name: 'account', desc: '', args: []);
  }

  /// `Do you want to change your name`
  String get change_name {
    return Intl.message(
      'Do you want to change your name',
      name: 'change_name',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Enter your new name`
  String get enter_new_name {
    return Intl.message(
      'Enter your new name',
      name: 'enter_new_name',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change the app and notifications language?`
  String get change_language {
    return Intl.message(
      'Do you want to change the app and notifications language?',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `The language has changed successfully`
  String get language_change_confirm {
    return Intl.message(
      'The language has changed successfully',
      name: 'language_change_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Previous messages`
  String get prev_messages {
    return Intl.message(
      'Previous messages',
      name: 'prev_messages',
      desc: '',
      args: [],
    );
  }

  /// `messages`
  String get prev_messages2 {
    return Intl.message('messages', name: 'prev_messages2', desc: '', args: []);
  }

  /// `Intrests`
  String get intrests {
    return Intl.message('Intrests', name: 'intrests', desc: '', args: []);
  }

  /// `settings`
  String get settings {
    return Intl.message('settings', name: 'settings', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
