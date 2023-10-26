/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 29
///
/// Built on 2023-10-26 at 04:04 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get appName => 'GGC Flutter';
	late final _StringsButtonEn button_ = _StringsButtonEn._(_root);
	late final _StringsCommonEn common_ = _StringsCommonEn._(_root);
	late final _StringsLoginEn login_ = _StringsLoginEn._(_root);
}

// Path: button_
class _StringsButtonEn {
	_StringsButtonEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get back => 'BACK';
	String get cancel => 'CANCEL';
	String get confirm => 'CONFIRM';
	String get complete => 'COMPLETE';
	String get close => 'CLOSE';
	String get login => 'LOGIN';
	String get logout => 'LOGOUT';
	String get next => 'NEXT';
	String get submit => 'SUBMIT';
	String get signIn => 'SIGN IN';
	String get yes => 'YES';
	String get no => 'NO';
	String get ok => 'OK';
	String get edit => 'EDIT';
}

// Path: common_
class _StringsCommonEn {
	_StringsCommonEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsCommonErrorSnackbarEn errorSnackbar = _StringsCommonErrorSnackbarEn._(_root);
	late final _StringsCommonErrorEn error_ = _StringsCommonErrorEn._(_root);
}

// Path: login_
class _StringsLoginEn {
	_StringsLoginEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get login => 'Login';
	String get username => 'Username';
	String get password => 'Password';
	String get usernameIsRequired => 'Silakan memasukkan Username Anda!';
	String get passwordIsRequired => 'Silakan memasukkan Password Anda!';
	String get forgotPassword => 'Lupa Password?';
	String get register => 'Daftar Akun';
	String get authenticationDescription => 'Please authenticate to login';
}

// Path: common_.errorSnackbar
class _StringsCommonErrorSnackbarEn {
	_StringsCommonErrorSnackbarEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Oops!!!';
	String get content => 'Terjadi kesalahan. Silakan coba lagi.';
	String get noInternetConnection => 'Tidak ada koneksi internet';
	String get connectionProblem => 'Sistem kami sedang mengalami gangguan jaringan, silakan mencoba kembali beberapa saat lagi atau hubungi admin kami.';
}

// Path: common_.error_
class _StringsCommonErrorEn {
	_StringsCommonErrorEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get generalRequired => 'Data wajib diisi';
	String get generalInvalid => 'Data tidak valid';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'GGC Flutter';
			case 'button_.back': return 'BACK';
			case 'button_.cancel': return 'CANCEL';
			case 'button_.confirm': return 'CONFIRM';
			case 'button_.complete': return 'COMPLETE';
			case 'button_.close': return 'CLOSE';
			case 'button_.login': return 'LOGIN';
			case 'button_.logout': return 'LOGOUT';
			case 'button_.next': return 'NEXT';
			case 'button_.submit': return 'SUBMIT';
			case 'button_.signIn': return 'SIGN IN';
			case 'button_.yes': return 'YES';
			case 'button_.no': return 'NO';
			case 'button_.ok': return 'OK';
			case 'button_.edit': return 'EDIT';
			case 'common_.errorSnackbar.title': return 'Oops!!!';
			case 'common_.errorSnackbar.content': return 'Terjadi kesalahan. Silakan coba lagi.';
			case 'common_.errorSnackbar.noInternetConnection': return 'Tidak ada koneksi internet';
			case 'common_.errorSnackbar.connectionProblem': return 'Sistem kami sedang mengalami gangguan jaringan, silakan mencoba kembali beberapa saat lagi atau hubungi admin kami.';
			case 'common_.error_.generalRequired': return 'Data wajib diisi';
			case 'common_.error_.generalInvalid': return 'Data tidak valid';
			case 'login_.login': return 'Login';
			case 'login_.username': return 'Username';
			case 'login_.password': return 'Password';
			case 'login_.usernameIsRequired': return 'Silakan memasukkan Username Anda!';
			case 'login_.passwordIsRequired': return 'Silakan memasukkan Password Anda!';
			case 'login_.forgotPassword': return 'Lupa Password?';
			case 'login_.register': return 'Daftar Akun';
			case 'login_.authenticationDescription': return 'Please authenticate to login';
			default: return null;
		}
	}
}
