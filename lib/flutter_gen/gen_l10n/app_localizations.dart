import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @careers.
  ///
  /// In en, this message translates to:
  /// **'Careers'**
  String get careers;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @loggedIn.
  ///
  /// In en, this message translates to:
  /// **'Logged in'**
  String get loggedIn;

  /// No description provided for @enterEmailAndPasswordToLogin.
  ///
  /// In en, this message translates to:
  /// **'Enter email and password to login'**
  String get enterEmailAndPasswordToLogin;

  /// No description provided for @loginFailedPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Login failed Please try again later'**
  String get loginFailedPleaseTryAgainLater;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get loggedOut;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// No description provided for @passwordsDoNotMatchPleaseCorrectAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match Please correct and try again'**
  String get passwordsDoNotMatchPleaseCorrectAndTryAgain;

  /// No description provided for @passwordConfirmPasswordCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password Confirm password cannot be empty'**
  String get passwordConfirmPasswordCannotBeEmpty;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get accountCreatedSuccessfully;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// No description provided for @emailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailCannotBeEmpty;

  /// No description provided for @mobileNumberCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Mobile number cannot be empty'**
  String get mobileNumberCannotBeEmpty;

  /// No description provided for @signUpFailedPleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed Please try again later'**
  String get signUpFailedPleaseTryAgainLater;

  /// No description provided for @forAnyQueriesPleaseContactUs.
  ///
  /// In en, this message translates to:
  /// **'For any queries please contact us'**
  String get forAnyQueriesPleaseContactUs;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @discoverSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Discover Suppliers'**
  String get discoverSuppliers;

  /// No description provided for @getAnInstantQuote.
  ///
  /// In en, this message translates to:
  /// **'Get an Instant Quote'**
  String get getAnInstantQuote;

  /// No description provided for @registerAsABuyer.
  ///
  /// In en, this message translates to:
  /// **'Register as a Buyer'**
  String get registerAsABuyer;

  /// No description provided for @findAndCompareSuppliersInOver70000Categories.
  ///
  /// In en, this message translates to:
  /// **'Find and compare suppliers in over 70,000 categories Our team keeps listings up to date and assists with strategic sourcing opportunities'**
  String get findAndCompareSuppliersInOver70000Categories;

  /// No description provided for @uploadACADModelToGetAQuoteWithinSecondsForCNCMachining3DPrintingInjectionMoldingSheetMetalFabricationAndMore.
  ///
  /// In en, this message translates to:
  /// **'Upload a CAD model to get a quote within seconds for CNC machining, 3D printing, injection molding, sheet metal fabrication, and more'**
  String get uploadACADModelToGetAQuoteWithinSecondsForCNCMachining3DPrintingInjectionMoldingSheetMetalFabricationAndMore;

  /// No description provided for @registeredBuyersCanContactAndQuoteWithMultipleSuppliersCheckOutWithAQuoteAndPayOnTermsWithinOnePlatform.
  ///
  /// In en, this message translates to:
  /// **'Registered buyers can contact and quote with multiple suppliers, check out with a quote, and pay on terms within one platform'**
  String get registeredBuyersCanContactAndQuoteWithMultipleSuppliersCheckOutWithAQuoteAndPayOnTermsWithinOnePlatform;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account'**
  String get dontHaveAnAccount;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @websites.
  ///
  /// In en, this message translates to:
  /// **'Websites'**
  String get websites;

  /// No description provided for @youCanAddUpTo3WebsitesOnly.
  ///
  /// In en, this message translates to:
  /// **'You can add up to 3 websites only'**
  String get youCanAddUpTo3WebsitesOnly;

  /// No description provided for @websiteUrl.
  ///
  /// In en, this message translates to:
  /// **'Website url'**
  String get websiteUrl;

  /// No description provided for @pleaseAddWebsites.
  ///
  /// In en, this message translates to:
  /// **'Please add websites'**
  String get pleaseAddWebsites;

  /// No description provided for @editCompanyInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit company info'**
  String get editCompanyInfo;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @pleaseAddServices.
  ///
  /// In en, this message translates to:
  /// **'Please add services'**
  String get pleaseAddServices;

  /// No description provided for @pleaseAddProducts.
  ///
  /// In en, this message translates to:
  /// **'Please add products'**
  String get pleaseAddProducts;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @productImageUrl.
  ///
  /// In en, this message translates to:
  /// **'Product image url'**
  String get productImageUrl;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @profilePictureChanged.
  ///
  /// In en, this message translates to:
  /// **'Profile picture changed'**
  String get profilePictureChanged;

  /// No description provided for @errorProfilePictureUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Error Profile picture upload failed'**
  String get errorProfilePictureUploadFailed;

  /// No description provided for @supplierDetails.
  ///
  /// In en, this message translates to:
  /// **'Supplier details'**
  String get supplierDetails;

  /// No description provided for @supplierName.
  ///
  /// In en, this message translates to:
  /// **'Supplier name'**
  String get supplierName;

  /// No description provided for @supplierEmail.
  ///
  /// In en, this message translates to:
  /// **'Supplier email'**
  String get supplierEmail;

  /// No description provided for @supplierLocation.
  ///
  /// In en, this message translates to:
  /// **'Supplier location'**
  String get supplierLocation;

  /// No description provided for @supplierContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Supplier contact number'**
  String get supplierContactNumber;

  /// No description provided for @servicesOffered.
  ///
  /// In en, this message translates to:
  /// **'Services offered'**
  String get servicesOffered;

  /// No description provided for @aboutSupplier.
  ///
  /// In en, this message translates to:
  /// **'About supplier'**
  String get aboutSupplier;

  /// No description provided for @errorFetchingAddresses.
  ///
  /// In en, this message translates to:
  /// **'Error fetching addresses'**
  String get errorFetchingAddresses;

  /// No description provided for @errorSearchingUsers.
  ///
  /// In en, this message translates to:
  /// **'Error searching users'**
  String get errorSearchingUsers;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAnAccount;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @aboutCompany.
  ///
  /// In en, this message translates to:
  /// **'About company'**
  String get aboutCompany;

  /// No description provided for @pleaseAddCompanyInformation.
  ///
  /// In en, this message translates to:
  /// **'Please add company information'**
  String get pleaseAddCompanyInformation;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @websitesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Websites updated'**
  String get websitesUpdated;

  /// No description provided for @couldNotUpdateTheWebsite.
  ///
  /// In en, this message translates to:
  /// **'Could not update the website'**
  String get couldNotUpdateTheWebsite;

  /// No description provided for @dataUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data updated successfully'**
  String get dataUpdatedSuccessfully;

  /// No description provided for @detailsUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Details updated successfully'**
  String get detailsUpdatedSuccessfully;

  /// No description provided for @companyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Company update'**
  String get companyUpdate;

  /// No description provided for @couldNotUpdateTheDetails.
  ///
  /// In en, this message translates to:
  /// **'Could not update the details'**
  String get couldNotUpdateTheDetails;

  /// No description provided for @userNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User not authenticated'**
  String get userNotAuthenticated;

  /// No description provided for @failedToPickAFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick a file'**
  String get failedToPickAFile;

  /// No description provided for @pleaseSelectAProfilePictureToUpload.
  ///
  /// In en, this message translates to:
  /// **'Please select a profile picture to upload'**
  String get pleaseSelectAProfilePictureToUpload;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
