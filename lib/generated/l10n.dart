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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Name here`
  String get name {
    return Intl.message('Name here', name: 'name', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_Number {
    return Intl.message(
      'Phone Number',
      name: 'phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Sign up`
  String get Sign_up {
    return Intl.message('Sign up', name: 'Sign_up', desc: '', args: []);
  }

  /// `Don't have an account`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to the mobile number 📱`
  String get enter_verify_otp {
    return Intl.message(
      'Enter the verification code sent to the mobile number 📱',
      name: 'enter_verify_otp',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to your mobile:`
  String get enter_verify_otp_subtitle {
    return Intl.message(
      'Enter the verification code sent to your mobile:',
      name: 'enter_verify_otp_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Resend after`
  String get resend_otp {
    return Intl.message('Resend after', name: 'resend_otp', desc: '', args: []);
  }

  /// `Continue`
  String get continuee {
    return Intl.message('Continue', name: 'continuee', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Stories`
  String get stories {
    return Intl.message('Stories', name: 'stories', desc: '', args: []);
  }

  /// `Join Us Now`
  String get join_us {
    return Intl.message('Join Us Now', name: 'join_us', desc: '', args: []);
  }

  /// `Join Our Affiliate Team`
  String get join_our_team {
    return Intl.message(
      'Join Our Affiliate Team',
      name: 'join_our_team',
      desc: '',
      args: [],
    );
  }

  /// `Turn your time online into profits! Join our affiliate program and start earning money from the comfort of your home.`
  String get join_our_team_description {
    return Intl.message(
      'Turn your time online into profits! Join our affiliate program and start earning money from the comfort of your home.',
      name: 'join_our_team_description',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `View All`
  String get view_all {
    return Intl.message('View All', name: 'view_all', desc: '', args: []);
  }

  /// `Camion Offers`
  String get camion_offers {
    return Intl.message(
      'Camion Offers',
      name: 'camion_offers',
      desc: '',
      args: [],
    );
  }

  /// `Top Sales`
  String get top_sales {
    return Intl.message('Top Sales', name: 'top_sales', desc: '', args: []);
  }

  /// `Choose Product`
  String get choose_prduct {
    return Intl.message(
      'Choose Product',
      name: 'choose_prduct',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get my_wallet {
    return Intl.message('My Wallet', name: 'my_wallet', desc: '', args: []);
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message('My Orders', name: 'my_orders', desc: '', args: []);
  }

  /// `Affiliate Marketing`
  String get affiliate_marketing {
    return Intl.message(
      'Affiliate Marketing',
      name: 'affiliate_marketing',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Rate Us`
  String get rate_us {
    return Intl.message('Rate Us', name: 'rate_us', desc: '', args: []);
  }

  /// `Give Us Feedback`
  String get give_us_feedback {
    return Intl.message(
      'Give Us Feedback',
      name: 'give_us_feedback',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message('About Us', name: 'about_us', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get are_you_sure_you_want_to_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'are_you_sure_you_want_to_logout',
      desc: '',
      args: [],
    );
  }

  /// `Your current session will be terminated, and you will need to log in again to access your account.`
  String get logout_description {
    return Intl.message(
      'Your current session will be terminated, and you will need to log in again to access your account.',
      name: 'logout_description',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get are_you_sure_you_want_to_delete {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'are_you_sure_you_want_to_delete',
      desc: '',
      args: [],
    );
  }

  /// `All your data will be permanently deleted and will not be recoverable later. This action is irreversible.`
  String get delete_account_description {
    return Intl.message(
      'All your data will be permanently deleted and will not be recoverable later. This action is irreversible.',
      name: 'delete_account_description',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `German`
  String get german {
    return Intl.message('German', name: 'german', desc: '', args: []);
  }

  /// `French`
  String get french {
    return Intl.message('French', name: 'french', desc: '', args: []);
  }

  /// `Spanish`
  String get spanish {
    return Intl.message('Spanish', name: 'spanish', desc: '', args: []);
  }

  /// `Italian`
  String get italian {
    return Intl.message('Italian', name: 'italian', desc: '', args: []);
  }

  /// `Bengali`
  String get bengali {
    return Intl.message('Bengali', name: 'bengali', desc: '', args: []);
  }

  /// `Dutch`
  String get dutch {
    return Intl.message('Dutch', name: 'dutch', desc: '', args: []);
  }

  /// `Hindi`
  String get hindi {
    return Intl.message('Hindi', name: 'hindi', desc: '', args: []);
  }

  /// `Indonesian`
  String get indonesian {
    return Intl.message('Indonesian', name: 'indonesian', desc: '', args: []);
  }

  /// `Japanese`
  String get japanese {
    return Intl.message('Japanese', name: 'japanese', desc: '', args: []);
  }

  /// `Javanese`
  String get javanese {
    return Intl.message('Javanese', name: 'javanese', desc: '', args: []);
  }

  /// `Korean`
  String get korean {
    return Intl.message('Korean', name: 'korean', desc: '', args: []);
  }

  /// `Malay/Indonesian`
  String get malay {
    return Intl.message('Malay/Indonesian', name: 'malay', desc: '', args: []);
  }

  /// `Mandarin Chinese`
  String get mandarin_chinese {
    return Intl.message(
      'Mandarin Chinese',
      name: 'mandarin_chinese',
      desc: '',
      args: [],
    );
  }

  /// `Marathi`
  String get marathi {
    return Intl.message('Marathi', name: 'marathi', desc: '', args: []);
  }

  /// `Persian (Farsi)`
  String get persian {
    return Intl.message('Persian (Farsi)', name: 'persian', desc: '', args: []);
  }

  /// `Polish`
  String get polish {
    return Intl.message('Polish', name: 'polish', desc: '', args: []);
  }

  /// `Portuguese`
  String get portuguese {
    return Intl.message('Portuguese', name: 'portuguese', desc: '', args: []);
  }

  /// `Punjabi`
  String get punjabi {
    return Intl.message('Punjabi', name: 'punjabi', desc: '', args: []);
  }

  /// `Romanian`
  String get romanian {
    return Intl.message('Romanian', name: 'romanian', desc: '', args: []);
  }

  /// `Russian`
  String get russian {
    return Intl.message('Russian', name: 'russian', desc: '', args: []);
  }

  /// `Swahili`
  String get swahili {
    return Intl.message('Swahili', name: 'swahili', desc: '', args: []);
  }

  /// `Tamil`
  String get tamil {
    return Intl.message('Tamil', name: 'tamil', desc: '', args: []);
  }

  /// `Telugu`
  String get telugu {
    return Intl.message('Telugu', name: 'telugu', desc: '', args: []);
  }

  /// `Thai`
  String get thai {
    return Intl.message('Thai', name: 'thai', desc: '', args: []);
  }

  /// `Turkish`
  String get turkish {
    return Intl.message('Turkish', name: 'turkish', desc: '', args: []);
  }

  /// `Ukrainian`
  String get ukrainian {
    return Intl.message('Ukrainian', name: 'ukrainian', desc: '', args: []);
  }

  /// `Urdu`
  String get urdu {
    return Intl.message('Urdu', name: 'urdu', desc: '', args: []);
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message('Vietnamese', name: 'vietnamese', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Coupon Code`
  String get coupon_code {
    return Intl.message('Coupon Code', name: 'coupon_code', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Product Details`
  String get product_details {
    return Intl.message(
      'Product Details',
      name: 'product_details',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `In Stock`
  String get in_stock {
    return Intl.message('In Stock', name: 'in_stock', desc: '', args: []);
  }

  /// `Out of Stock`
  String get out_of_stock {
    return Intl.message(
      'Out of Stock',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message('Add to Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Go to Cart`
  String get go_to_cart {
    return Intl.message('Go to Cart', name: 'go_to_cart', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Add Review`
  String get add_review {
    return Intl.message('Add Review', name: 'add_review', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Available Options`
  String get available_options {
    return Intl.message(
      'Available Options',
      name: 'available_options',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Pending....`
  String get pedning {
    return Intl.message('Pending....', name: 'pedning', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Your request is currently under review.\nPlease wait for admin approval.`
  String get pending_message {
    return Intl.message(
      'Your request is currently under review.\nPlease wait for admin approval.',
      name: 'pending_message',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Your registration request has been rejected.\nPlease try registering again.`
  String get rejected_message {
    return Intl.message(
      'Your registration request has been rejected.\nPlease try registering again.',
      name: 'rejected_message',
      desc: '',
      args: [],
    );
  }

  /// `Register Again as Affiliate`
  String get register_again_as_affiliate {
    return Intl.message(
      'Register Again as Affiliate',
      name: 'register_again_as_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Transaction`
  String get transactions {
    return Intl.message(
      'Transaction',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get My_Wallet {
    return Intl.message('My Wallet', name: 'My_Wallet', desc: '', args: []);
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message('Withdraw', name: 'withdraw', desc: '', args: []);
  }

  /// `Affiliate Marketing`
  String get Affiliate_marketing {
    return Intl.message(
      'Affiliate Marketing',
      name: 'Affiliate_marketing',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get start_now {
    return Intl.message('Start Now', name: 'start_now', desc: '', args: []);
  }

  /// `We are honored to have you join our marketing team`
  String get affiliate_welcome_message {
    return Intl.message(
      'We are honored to have you join our marketing team',
      name: 'affiliate_welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `We offer a simple and effective affiliate marketing system based on unique codes for each marketer. These codes can be shared with their audience, allowing them to earn a commission on every sale made using the code. The commission is transferred directly to their wallet without any intermediaries or delays, ensuring fast and easy payouts.We provide a wide variety of products across different fields, so every marketer can find what suits their audience and achieve the highest sales rates. Our goal is to help you earn a steady income through minimal effort and smart marketing.`
  String get affiliate_welcome_subtitle {
    return Intl.message(
      'We offer a simple and effective affiliate marketing system based on unique codes for each marketer. These codes can be shared with their audience, allowing them to earn a commission on every sale made using the code. The commission is transferred directly to their wallet without any intermediaries or delays, ensuring fast and easy payouts.We provide a wide variety of products across different fields, so every marketer can find what suits their audience and achieve the highest sales rates. Our goal is to help you earn a steady income through minimal effort and smart marketing.',
      name: 'affiliate_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Affiliate Account`
  String get affiliate_account {
    return Intl.message(
      'Affiliate Account',
      name: 'affiliate_account',
      desc: '',
      args: [],
    );
  }

  /// `My Coupons`
  String get my_coupuns {
    return Intl.message('My Coupons', name: 'my_coupuns', desc: '', args: []);
  }

  /// `Create Coupon`
  String get create_coupon {
    return Intl.message(
      'Create Coupon',
      name: 'create_coupon',
      desc: '',
      args: [],
    );
  }

  /// `Join Us as an Affiliate`
  String get join_us_as_affiliate {
    return Intl.message(
      'Join Us as an Affiliate',
      name: 'join_us_as_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Coupon`
  String get coupon {
    return Intl.message('Coupon', name: 'coupon', desc: '', args: []);
  }

  /// `Discount Rate`
  String get discount_rate {
    return Intl.message(
      'Discount Rate',
      name: 'discount_rate',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personal_data {
    return Intl.message(
      'Personal Data',
      name: 'personal_data',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message('Nationality', name: 'nationality', desc: '', args: []);
  }

  /// `About You`
  String get about_you {
    return Intl.message('About You', name: 'about_you', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `Help us improve your experience`
  String get help_us_improve {
    return Intl.message(
      'Help us improve your experience',
      name: 'help_us_improve',
      desc: '',
      args: [],
    );
  }

  /// `Share your thoughts and help us improve your experience`
  String get feed_back_description {
    return Intl.message(
      'Share your thoughts and help us improve your experience',
      name: 'feed_back_description',
      desc: '',
      args: [],
    );
  }

  /// `Policies - Camion App`
  String get privacy_poilicy_camion_app {
    return Intl.message(
      'Policies - Camion App',
      name: 'privacy_poilicy_camion_app',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get terms_of_use {
    return Intl.message(
      'Terms of Use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `By using Camion, you agree to comply with all the terms and conditions stated in this policy.`
  String get terms_of_use_description1 {
    return Intl.message(
      'By using Camion, you agree to comply with all the terms and conditions stated in this policy.',
      name: 'terms_of_use_description1',
      desc: '',
      args: [],
    );
  }

  /// `Camion reserves the right to update or modify these policies at any time. Users will be notified of any changes via the app or email.`
  String get terms_of_use_description2 {
    return Intl.message(
      'Camion reserves the right to update or modify these policies at any time. Users will be notified of any changes via the app or email.',
      name: 'terms_of_use_description2',
      desc: '',
      args: [],
    );
  }

  /// `The app must not be used for any illegal activities or in violation of local or international laws.`
  String get terms_of_use_description3 {
    return Intl.message(
      'The app must not be used for any illegal activities or in violation of local or international laws.',
      name: 'terms_of_use_description3',
      desc: '',
      args: [],
    );
  }

  /// `Product Policy`
  String get product_policy {
    return Intl.message(
      'Product Policy',
      name: 'product_policy',
      desc: '',
      args: [],
    );
  }

  /// `All products listed on Camion are original and match the specifications described on the product page.`
  String get product_policy_description1 {
    return Intl.message(
      'All products listed on Camion are original and match the specifications described on the product page.',
      name: 'product_policy_description1',
      desc: '',
      args: [],
    );
  }

  /// `Prices include VAT (if applicable) and do not include shipping fees unless otherwise stated.`
  String get product_policy_description2 {
    return Intl.message(
      'Prices include VAT (if applicable) and do not include shipping fees unless otherwise stated.',
      name: 'product_policy_description2',
      desc: '',
      args: [],
    );
  }

  /// `Product colors may slightly vary due to screen settings or manufacturing differences.`
  String get product_policy_description3 {
    return Intl.message(
      'Product colors may slightly vary due to screen settings or manufacturing differences.',
      name: 'product_policy_description3',
      desc: '',
      args: [],
    );
  }

  /// `Payment Policy`
  String get payment_policy {
    return Intl.message(
      'Payment Policy',
      name: 'payment_policy',
      desc: '',
      args: [],
    );
  }

  /// `Camion supports multiple payment methods (credit/debit cards, bank transfer, e-wallets, and cash on delivery if available).`
  String get payment_policy_description1 {
    return Intl.message(
      'Camion supports multiple payment methods (credit/debit cards, bank transfer, e-wallets, and cash on delivery if available).',
      name: 'payment_policy_description1',
      desc: '',
      args: [],
    );
  }

  /// `All payments are secured through certified payment service providers.`
  String get payment_policy_description2 {
    return Intl.message(
      'All payments are secured through certified payment service providers.',
      name: 'payment_policy_description2',
      desc: '',
      args: [],
    );
  }

  /// `If a payment fails, the order will not be confirmed, and the user may retry using a different method.`
  String get payment_policy_description3 {
    return Intl.message(
      'If a payment fails, the order will not be confirmed, and the user may retry using a different method.',
      name: 'payment_policy_description3',
      desc: '',
      args: [],
    );
  }

  /// `Shipping & Delivery Policy`
  String get shipping_policy {
    return Intl.message(
      'Shipping & Delivery Policy',
      name: 'shipping_policy',
      desc: '',
      args: [],
    );
  }

  /// `Camion provides worldwide shipping through trusted international courier services.`
  String get shipping_policy_description1 {
    return Intl.message(
      'Camion provides worldwide shipping through trusted international courier services.',
      name: 'shipping_policy_description1',
      desc: '',
      args: [],
    );
  }

  /// `Delivery time varies depending on the destination country and shipping provider.`
  String get shipping_policy_description2 {
    return Intl.message(
      'Delivery time varies depending on the destination country and shipping provider.',
      name: 'shipping_policy_description2',
      desc: '',
      args: [],
    );
  }

  /// `Customers will receive a tracking number once their order has been dispatched.`
  String get shipping_policy_description3 {
    return Intl.message(
      'Customers will receive a tracking number once their order has been dispatched.',
      name: 'shipping_policy_description3',
      desc: '',
      args: [],
    );
  }

  /// `Camion is not responsible for delays caused by customs, natural events, or courier issues beyond our control.`
  String get shipping_policy_description4 {
    return Intl.message(
      'Camion is not responsible for delays caused by customs, natural events, or courier issues beyond our control.',
      name: 'shipping_policy_description4',
      desc: '',
      args: [],
    );
  }

  /// `Return & Refund Policy`
  String get return_policy {
    return Intl.message(
      'Return & Refund Policy',
      name: 'return_policy',
      desc: '',
      args: [],
    );
  }

  /// `Customers may request a return within 14 days of receiving the order, provided the item is unused, undamaged, and in its original packaging.`
  String get return_policy_description1 {
    return Intl.message(
      'Customers may request a return within 14 days of receiving the order, provided the item is unused, undamaged, and in its original packaging.',
      name: 'return_policy_description1',
      desc: '',
      args: [],
    );
  }

  /// `Certain items such as personal care products, food, or customized items are non-returnable.`
  String get return_policy_description2 {
    return Intl.message(
      'Certain items such as personal care products, food, or customized items are non-returnable.',
      name: 'return_policy_description2',
      desc: '',
      args: [],
    );
  }

  /// `Refunds will be processed to the original payment method within 7–14 business days after the returned item is inspected.`
  String get return_policy_description3 {
    return Intl.message(
      'Refunds will be processed to the original payment method within 7–14 business days after the returned item is inspected.',
      name: 'return_policy_description3',
      desc: '',
      args: [],
    );
  }

  /// `Shipping fees are non-refundable, and return shipping costs are the responsibility of the customer (unless the item is defective or incorrect).`
  String get return_policy_description4 {
    return Intl.message(
      'Shipping fees are non-refundable, and return shipping costs are the responsibility of the customer (unless the item is defective or incorrect).',
      name: 'return_policy_description4',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy_details {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy_details',
      desc: '',
      args: [],
    );
  }

  /// `Camion respects and protects your personal data.`
  String get privacy_policy_description1 {
    return Intl.message(
      'Camion respects and protects your personal data.',
      name: 'privacy_policy_description1',
      desc: '',
      args: [],
    );
  }

  /// `We collect information (such as name, address, contact details, and payment info) only to process orders and improve user experience.`
  String get privacy_policy_description2 {
    return Intl.message(
      'We collect information (such as name, address, contact details, and payment info) only to process orders and improve user experience.',
      name: 'privacy_policy_description2',
      desc: '',
      args: [],
    );
  }

  /// `Personal data will never be sold or shared with third parties, except with shipping and payment partners to complete your order.`
  String get privacy_policy_description3 {
    return Intl.message(
      'Personal data will never be sold or shared with third parties, except with shipping and payment partners to complete your order.',
      name: 'privacy_policy_description3',
      desc: '',
      args: [],
    );
  }

  /// `All data is securely stored, and users have the right to request access, correction, or deletion of their personal information.`
  String get privacy_policy_description4 {
    return Intl.message(
      'All data is securely stored, and users have the right to request access, correction, or deletion of their personal information.',
      name: 'privacy_policy_description4',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of Liability`
  String get limitation_liability {
    return Intl.message(
      'Limitation of Liability',
      name: 'limitation_liability',
      desc: '',
      args: [],
    );
  }

  /// `Camion is not liable for any indirect, incidental, or consequential damages arising from the use of the app or purchased products.`
  String get limitation_liability_description1 {
    return Intl.message(
      'Camion is not liable for any indirect, incidental, or consequential damages arising from the use of the app or purchased products.',
      name: 'limitation_liability_description1',
      desc: '',
      args: [],
    );
  }

  /// `Responsibility for product usage lies with the customer.`
  String get limitation_liability_description2 {
    return Intl.message(
      'Responsibility for product usage lies with the customer.',
      name: 'limitation_liability_description2',
      desc: '',
      args: [],
    );
  }

  /// `In case of disputes, Camion’s liability is limited to the order value only.`
  String get limitation_liability_description3 {
    return Intl.message(
      'In case of disputes, Camion’s liability is limited to the order value only.',
      name: 'limitation_liability_description3',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Shipping and Delivery`
  String get Shipping_and_Delivery {
    return Intl.message(
      'Shipping and Delivery',
      name: 'Shipping_and_Delivery',
      desc: '',
      args: [],
    );
  }

  /// `How long is the delivery time and what are the coverage areas?`
  String get question_1 {
    return Intl.message(
      'How long is the delivery time and what are the coverage areas?',
      name: 'question_1',
      desc: '',
      args: [],
    );
  }

  /// `Delivery typically takes 3 to 5 business days and shipping is available worldwide.`
  String get answer_1 {
    return Intl.message(
      'Delivery typically takes 3 to 5 business days and shipping is available worldwide.',
      name: 'answer_1',
      desc: '',
      args: [],
    );
  }

  /// `How can I track my order?`
  String get question_2 {
    return Intl.message(
      'How can I track my order?',
      name: 'question_2',
      desc: '',
      args: [],
    );
  }

  /// `Once your order has shipped, you'll receive a notification and an email containing a tracking number. You can use this number to track your order directly on the shipping company's website. You can also check your order status through the My Orders section of your account.`
  String get answer_2 {
    return Intl.message(
      'Once your order has shipped, you\'ll receive a notification and an email containing a tracking number. You can use this number to track your order directly on the shipping company\'s website. You can also check your order status through the My Orders section of your account.',
      name: 'answer_2',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get Payments {
    return Intl.message('Payments', name: 'Payments', desc: '', args: []);
  }

  /// `What payment methods are available?`
  String get question_3 {
    return Intl.message(
      'What payment methods are available?',
      name: 'question_3',
      desc: '',
      args: [],
    );
  }

  /// `We accept payments via credit cards, Mada, Apple Pay, and cash on delivery.`
  String get answer_3 {
    return Intl.message(
      'We accept payments via credit cards, Mada, Apple Pay, and cash on delivery.',
      name: 'answer_3',
      desc: '',
      args: [],
    );
  }

  /// `Return and Exchange`
  String get Return_and_Exchange {
    return Intl.message(
      'Return and Exchange',
      name: 'Return_and_Exchange',
      desc: '',
      args: [],
    );
  }

  /// `What is the return policy?`
  String get question_4 {
    return Intl.message(
      'What is the return policy?',
      name: 'question_4',
      desc: '',
      args: [],
    );
  }

  /// `Products can be returned within 14 days from the date of receipt, provided they are in their original condition.`
  String get answer_4 {
    return Intl.message(
      'Products can be returned within 14 days from the date of receipt, provided they are in their original condition.',
      name: 'answer_4',
      desc: '',
      args: [],
    );
  }

  /// `Direct communication`
  String get Direct_communication {
    return Intl.message(
      'Direct communication',
      name: 'Direct_communication',
      desc: '',
      args: [],
    );
  }

  /// `Contact us via WhatsApp`
  String get Contact_us_via_WhatsApp {
    return Intl.message(
      'Contact us via WhatsApp',
      name: 'Contact_us_via_WhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `For immediate assistance`
  String get For_immediate_assistance {
    return Intl.message(
      'For immediate assistance',
      name: 'For_immediate_assistance',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Selected for sharing`
  String get selected_for_sharing {
    return Intl.message(
      'Selected for sharing',
      name: 'selected_for_sharing',
      desc: '',
      args: [],
    );
  }

  /// `Your wishlist is empty`
  String get Your_wishlist_is_empty {
    return Intl.message(
      'Your wishlist is empty',
      name: 'Your_wishlist_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Add some products to your favorites!`
  String get add_some_products_to_your_favorites {
    return Intl.message(
      'Add some products to your favorites!',
      name: 'add_some_products_to_your_favorites',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get s {
    return Intl.message('s', name: 's', desc: '', args: []);
  }

  /// `Continue To Checkout`
  String get Continue_To_Checkout {
    return Intl.message(
      'Continue To Checkout',
      name: 'Continue_To_Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Payment page is loading, please wait...`
  String get payment_page_loading {
    return Intl.message(
      'Payment page is loading, please wait...',
      name: 'payment_page_loading',
      desc: '',
      args: [],
    );
  }

  /// `Address Confirmation`
  String get address_confirmation {
    return Intl.message(
      'Address Confirmation',
      name: 'address_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Please enter your first name`
  String get please_enter_your_first_name {
    return Intl.message(
      'Please enter your first name',
      name: 'please_enter_your_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get please_enter_your_last_name {
    return Intl.message(
      'Please enter your last name',
      name: 'please_enter_your_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Shipping Address`
  String get shipping_address {
    return Intl.message(
      'Shipping Address',
      name: 'shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Address 1`
  String get address_1 {
    return Intl.message('Address 1', name: 'address_1', desc: '', args: []);
  }

  /// `Please enter your address`
  String get please_enter_your_address {
    return Intl.message(
      'Please enter your address',
      name: 'please_enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Address 2`
  String get address_2 {
    return Intl.message('Address 2', name: 'address_2', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Please select your country`
  String get please_select_your_country {
    return Intl.message(
      'Please select your country',
      name: 'please_select_your_country',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get please_enter_your_phone_number {
    return Intl.message(
      'Please enter your phone number',
      name: 'please_enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your city`
  String get please_enter_your_city {
    return Intl.message(
      'Please enter your city',
      name: 'please_enter_your_city',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your state`
  String get please_enter_your_state {
    return Intl.message(
      'Please enter your state',
      name: 'please_enter_your_state',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your postal code`
  String get please_enter_your_postal_code {
    return Intl.message(
      'Please enter your postal code',
      name: 'please_enter_your_postal_code',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message('State', name: 'state', desc: '', args: []);
  }

  /// `Postal Code`
  String get postal_code {
    return Intl.message('Postal Code', name: 'postal_code', desc: '', args: []);
  }

  /// `Confirm your shipping address`
  String get confirm_your_shipping_address {
    return Intl.message(
      'Confirm your shipping address',
      name: 'confirm_your_shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `View Cart`
  String get view_cart {
    return Intl.message('View Cart', name: 'view_cart', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Review Your Shipping Address Data`
  String get Review_Your_Shipping_Address_Data {
    return Intl.message(
      'Review Your Shipping Address Data',
      name: 'Review_Your_Shipping_Address_Data',
      desc: '',
      args: [],
    );
  }

  /// `Enter coupon code`
  String get enter_your_coupon_code {
    return Intl.message(
      'Enter coupon code',
      name: 'enter_your_coupon_code',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get order_id {
    return Intl.message('Order ID', name: 'order_id', desc: '', args: []);
  }

  /// `Order Number:`
  String get order_number {
    return Intl.message(
      'Order Number:',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Order Date:`
  String get order_date {
    return Intl.message('Order Date:', name: 'order_date', desc: '', args: []);
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get payment_details {
    return Intl.message(
      'Payment Details',
      name: 'payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Order Tracking`
  String get order_tracking {
    return Intl.message(
      'Order Tracking',
      name: 'order_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get order_status {
    return Intl.message(
      'Order Status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge`
  String get delivery_charge {
    return Intl.message(
      'Delivery Charge',
      name: 'delivery_charge',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get delivery_address {
    return Intl.message(
      'Delivery Address',
      name: 'delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Grand Total`
  String get grand_total {
    return Intl.message('Grand Total', name: 'grand_total', desc: '', args: []);
  }

  /// `Order is Paid`
  String get order_is_paid {
    return Intl.message(
      'Order is Paid',
      name: 'order_is_paid',
      desc: '',
      args: [],
    );
  }

  /// `Order is Delivered`
  String get order_is_delivered {
    return Intl.message(
      'Order is Delivered',
      name: 'order_is_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Delivery is in Progress`
  String get delivery_is_in_progress {
    return Intl.message(
      'Delivery is in Progress',
      name: 'delivery_is_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Will arrive within days`
  String get Will_arrive_within_days {
    return Intl.message(
      'Will arrive within days',
      name: 'Will_arrive_within_days',
      desc: '',
      args: [],
    );
  }

  /// `Your order is in progress`
  String get your_order_is_in_progress {
    return Intl.message(
      'Your order is in progress',
      name: 'your_order_is_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Number of products`
  String get Number_of_products {
    return Intl.message(
      'Number of products',
      name: 'Number_of_products',
      desc: '',
      args: [],
    );
  }

  /// `Ordered in`
  String get Ordered_in {
    return Intl.message('Ordered in', name: 'Ordered_in', desc: '', args: []);
  }

  /// `Shipping address added successfully`
  String get Shipping_address_added_successfully {
    return Intl.message(
      'Shipping address added successfully',
      name: 'Shipping_address_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Shipping address updated successfully`
  String get Shipping_address_updated_successfully {
    return Intl.message(
      'Shipping address updated successfully',
      name: 'Shipping_address_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Please enter your name`
  String get please_enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'please_enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get account_created_successfully {
    return Intl.message(
      'Account created successfully',
      name: 'account_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Choose Country`
  String get choose_country {
    return Intl.message(
      'Choose Country',
      name: 'choose_country',
      desc: '',
      args: [],
    );
  }

  /// `Search for countries`
  String get search_for_countries {
    return Intl.message(
      'Search for countries',
      name: 'search_for_countries',
      desc: '',
      args: [],
    );
  }

  /// `Coupon applied successfully`
  String get Coupon_applied_successfully {
    return Intl.message(
      'Coupon applied successfully',
      name: 'Coupon_applied_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Review Added Successfully`
  String get Review_Added_Successfully {
    return Intl.message(
      'Review Added Successfully',
      name: 'Review_Added_Successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gender`
  String get please_select_your_gender {
    return Intl.message(
      'Please select your gender',
      name: 'please_select_your_gender',
      desc: '',
      args: [],
    );
  }

  /// `Please select your nationality`
  String get please_select_your_nationality {
    return Intl.message(
      'Please select your nationality',
      name: 'please_select_your_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your bio`
  String get please_enter_your_bio {
    return Intl.message(
      'Please enter your bio',
      name: 'please_enter_your_bio',
      desc: '',
      args: [],
    );
  }

  /// `Coupon created successfully`
  String get Coupon_created_successfully {
    return Intl.message(
      'Coupon created successfully',
      name: 'Coupon_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your coupon code`
  String get please_enter_your_coupon_code {
    return Intl.message(
      'Please enter your coupon code',
      name: 'please_enter_your_coupon_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your discount rate`
  String get please_enter_your_discount_rate {
    return Intl.message(
      'Please enter your discount rate',
      name: 'please_enter_your_discount_rate',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `You are subscribed to affiliate marketing`
  String get You_are_subscribed_to_affiliate_marketing {
    return Intl.message(
      'You are subscribed to affiliate marketing',
      name: 'You_are_subscribed_to_affiliate_marketing',
      desc: '',
      args: [],
    );
  }

  /// `View your activity`
  String get view_your_activity {
    return Intl.message(
      'View your activity',
      name: 'view_your_activity',
      desc: '',
      args: [],
    );
  }

  /// `You are not subscribed to affiliate marketing`
  String get You_are_not_subscribed_to_affiliate_marketing {
    return Intl.message(
      'You are not subscribed to affiliate marketing',
      name: 'You_are_not_subscribed_to_affiliate_marketing',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe Now!`
  String get subscribe_now {
    return Intl.message(
      'Subscribe Now!',
      name: 'subscribe_now',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get Something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'Something_went_wrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'jv'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pa'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sw'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
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
