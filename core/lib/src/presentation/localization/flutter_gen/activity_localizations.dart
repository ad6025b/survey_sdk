import 'dart:async';

import 'package:activity_builder/src/presentation/localization/flutter_gen/activity_localizations_en.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

// ignore_for_file: lines_longer_than_80_chars

/// Callers can lookup localized strings with an instance of ActivityLocalizations
/// returned by `ActivityLocalizations.of(context)`.
///
/// Applications need to include `ActivityLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'flutter_gen/activity_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ActivityLocalizations.localizationsDelegates,
///   supportedLocales: ActivityLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ActivityLocalizations.supportedLocales
/// property.
abstract class ActivityLocalizations {
  final String localeName;

  static const LocalizationsDelegate<ActivityLocalizations> delegate =
      _ActivityLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @showMoreErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Damaged JSON'**
  String get damagedJson;

  /// No description provided for @hideErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get hideErrorDetails;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// No description provided for @showErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get showErrorDetails;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @activityLoadError.
  ///
  /// In en, this message translates to:
  /// **'Data is corrupted, activity has not been loaded'**
  String get activityLoadError;

  /// No description provided for @textField.
  ///
  /// In en, this message translates to:
  /// **'Text field'**
  String get textField;

  ActivityLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale);

  static ActivityLocalizations of(BuildContext context) {
    return Localizations.of<ActivityLocalizations>(context, ActivityLocalizations)!;
  }
}

class _ActivityLocalizationsDelegate
    extends LocalizationsDelegate<ActivityLocalizations> {
  const _ActivityLocalizationsDelegate();

  @override
  Future<ActivityLocalizations> load(Locale locale) {
    return SynchronousFuture<ActivityLocalizations>(
      lookupActivityLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(_ActivityLocalizationsDelegate old) => false;
}

ActivityLocalizations lookupActivityLocalizations(Locale locale) =>
    // Lookup logic when only language code is specified.
    switch (locale.languageCode) {
      'en' => ActivityLocalizationsEn(),
      _ => ActivityLocalizationsEn(),
    };
