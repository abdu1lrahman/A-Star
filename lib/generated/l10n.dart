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

  /// `What are your intrests?`
  String get what_intrests {
    return Intl.message(
      'What are your intrests?',
      name: 'what_intrests',
      desc: '',
      args: [],
    );
  }

  /// `You can choose up to 5 diffirent categories`
  String get you_can_choose {
    return Intl.message(
      'You can choose up to 5 diffirent categories',
      name: 'you_can_choose',
      desc: '',
      args: [],
    );
  }

  /// `health`
  String get health {
    return Intl.message('health', name: 'health', desc: '', args: []);
  }

  /// `Sport`
  String get sport {
    return Intl.message('Sport', name: 'sport', desc: '', args: []);
  }

  /// `Tech`
  String get tech {
    return Intl.message('Tech', name: 'tech', desc: '', args: []);
  }

  /// `Books`
  String get books {
    return Intl.message('Books', name: 'books', desc: '', args: []);
  }

  /// `Music`
  String get music {
    return Intl.message('Music', name: 'music', desc: '', args: []);
  }

  /// `Art`
  String get art {
    return Intl.message('Art', name: 'art', desc: '', args: []);
  }

  /// `Travel`
  String get travel {
    return Intl.message('Travel', name: 'travel', desc: '', args: []);
  }

  /// `Games`
  String get games {
    return Intl.message('Games', name: 'games', desc: '', args: []);
  }

  /// `Science`
  String get science {
    return Intl.message('Science', name: 'science', desc: '', args: []);
  }

  /// `Education`
  String get education {
    return Intl.message('Education', name: 'education', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Fashion`
  String get fashion {
    return Intl.message('Fashion', name: 'fashion', desc: '', args: []);
  }

  /// `Psychology`
  String get psychology {
    return Intl.message('Psychology', name: 'psychology', desc: '', args: []);
  }

  /// `+ Add your own (e.g. AI, Law)`
  String get add_your_own {
    return Intl.message(
      '+ Add your own (e.g. AI, Law)',
      name: 'add_your_own',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Enable Notifications`
  String get enable_noti {
    return Intl.message(
      'Enable Notifications',
      name: 'enable_noti',
      desc: '',
      args: [],
    );
  }

  /// `You can only select 5 interests.`
  String get you_can_only_select {
    return Intl.message(
      'You can only select 5 interests.',
      name: 'you_can_only_select',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get noti {
    return Intl.message('Notification', name: 'noti', desc: '', args: []);
  }

  /// `Personal Informations`
  String get personal_info {
    return Intl.message(
      'Personal Informations',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get username {
    return Intl.message('username', name: 'username', desc: '', args: []);
  }

  /// `age`
  String get age1 {
    return Intl.message('age', name: 'age1', desc: '', args: []);
  }

  /// `gender`
  String get gender1 {
    return Intl.message('gender', name: 'gender1', desc: '', args: []);
  }

  /// `share the motivation with your friend ❤`
  String get share_motivation {
    return Intl.message(
      'share the motivation with your friend ❤',
      name: 'share_motivation',
      desc: '',
      args: [],
    );
  }

  /// `No Previous messages available.`
  String get no_prev {
    return Intl.message(
      'No Previous messages available.',
      name: 'no_prev',
      desc: '',
      args: [],
    );
  }

  /// `Today's quote`
  String get today_quote {
    return Intl.message(
      'Today\'s quote',
      name: 'today_quote',
      desc: '',
      args: [],
    );
  }

  /// `Good morning`
  String get morning {
    return Intl.message('Good morning', name: 'morning', desc: '', args: []);
  }

  /// `Good afternoon`
  String get afternoon {
    return Intl.message(
      'Good afternoon',
      name: 'afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good evening`
  String get evening {
    return Intl.message('Good evening', name: 'evening', desc: '', args: []);
  }

  /// `Good night`
  String get night {
    return Intl.message('Good night', name: 'night', desc: '', args: []);
  }

  /// `There was an error while getting your daily quote\n Please check your internet connection and try again`
  String get todayQuote_message_error {
    return Intl.message(
      'There was an error while getting your daily quote\n Please check your internet connection and try again',
      name: 'todayQuote_message_error',
      desc: '',
      args: [],
    );
  }

  /// `The messages scheduled successfully`
  String get archived_message_confirm {
    return Intl.message(
      'The messages scheduled successfully',
      name: 'archived_message_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Get new quote`
  String get get_new_quote {
    return Intl.message(
      'Get new quote',
      name: 'get_new_quote',
      desc: '',
      args: [],
    );
  }

  /// `This app was developed by Abdulrahman`
  String get this_app_was_developed {
    return Intl.message(
      'This app was developed by Abdulrahman',
      name: 'this_app_was_developed',
      desc: '',
      args: [],
    );
  }

  /// `built with Flutter Framework`
  String get built_with {
    return Intl.message(
      'built with Flutter Framework',
      name: 'built_with',
      desc: '',
      args: [],
    );
  }

  /// `All rights reserved 2025`
  String get rights {
    return Intl.message(
      'All rights reserved 2025',
      name: 'rights',
      desc: '',
      args: [],
    );
  }

  /// `Special intrest added successfully`
  String get special_intrests_added {
    return Intl.message(
      'Special intrest added successfully',
      name: 'special_intrests_added',
      desc: '',
      args: [],
    );
  }

  /// `Add new Messages`
  String get add_new_messages {
    return Intl.message(
      'Add new Messages',
      name: 'add_new_messages',
      desc: '',
      args: [],
    );
  }

  /// `Delete my data`
  String get delete_my_data {
    return Intl.message(
      'Delete my data',
      name: 'delete_my_data',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name1 {
    return Intl.message('Name', name: 'name1', desc: '', args: []);
  }

  /// `Do you want to change your age`
  String get change_age {
    return Intl.message(
      'Do you want to change your age',
      name: 'change_age',
      desc: '',
      args: [],
    );
  }

  /// `Brighten your day and unlock your potential with personalized AI-powered motivation. Get inspiring messages crafted just for you, discover daily wisdom quotes, and let A Star guide you toward your goals, anytime, anywhere.`
  String get description {
    return Intl.message(
      'Brighten your day and unlock your potential with personalized AI-powered motivation. Get inspiring messages crafted just for you, discover daily wisdom quotes, and let A Star guide you toward your goals, anytime, anywhere.',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Create a new account`
  String get create_new_account {
    return Intl.message(
      'Create a new account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Create your account to start your journey`
  String get create_your_account {
    return Intl.message(
      'Create your account to start your journey',
      name: 'create_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email address`
  String get enter_your_email {
    return Intl.message(
      'Enter your Email address',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Your journey is finally here`
  String get your_journey {
    return Intl.message(
      'Your journey is finally here',
      name: 'your_journey',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signout {
    return Intl.message('Sign Out', name: 'signout', desc: '', args: []);
  }

  /// `Successfully logged in`
  String get successfully_logged_in {
    return Intl.message(
      'Successfully logged in',
      name: 'successfully_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `create one`
  String get create_one {
    return Intl.message('create one', name: 'create_one', desc: '', args: []);
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
