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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Al-baseet app`
  String get app_name {
    return Intl.message(
      'Al-baseet app',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get user_name {
    return Intl.message(
      'User name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `collected amount`
  String get collected_amount {
    return Intl.message(
      'collected amount',
      name: 'collected_amount',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Search for customer`
  String get search_customer {
    return Intl.message(
      'Search for customer',
      name: 'search_customer',
      desc: '',
      args: [],
    );
  }

  /// `Collected`
  String get collected {
    return Intl.message(
      'Collected',
      name: 'collected',
      desc: '',
      args: [],
    );
  }

  /// `Click again to exit!`
  String get press_again_to_exit {
    return Intl.message(
      'Click again to exit!',
      name: 'press_again_to_exit',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My warehouse`
  String get warehouse {
    return Intl.message(
      'My warehouse',
      name: 'warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Receipts`
  String get receipts {
    return Intl.message(
      'Receipts',
      name: 'receipts',
      desc: '',
      args: [],
    );
  }

  /// `Invoices`
  String get invoices {
    return Intl.message(
      'Invoices',
      name: 'invoices',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Create backup`
  String get create_backup {
    return Intl.message(
      'Create backup',
      name: 'create_backup',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_q {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_q',
      desc: '',
      args: [],
    );
  }

  /// `You will be permanently logged out form this app`
  String get logout_info {
    return Intl.message(
      'You will be permanently logged out form this app',
      name: 'logout_info',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `تغير اللغة`
  String get change_lang_info {
    return Intl.message(
      'تغير اللغة',
      name: 'change_lang_info',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد تغير لغة التطبيق؟`
  String get change_language_qu {
    return Intl.message(
      'هل تريد تغير لغة التطبيق؟',
      name: 'change_language_qu',
      desc: '',
      args: [],
    );
  }

  /// `تغير`
  String get change_lang {
    return Intl.message(
      'تغير',
      name: 'change_lang',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء`
  String get cancel_lang {
    return Intl.message(
      'إلغاء',
      name: 'cancel_lang',
      desc: '',
      args: [],
    );
  }

  /// `New invoice`
  String get new_invoice {
    return Intl.message(
      'New invoice',
      name: 'new_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Create receipt`
  String get create_receipt {
    return Intl.message(
      'Create receipt',
      name: 'create_receipt',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Payment type`
  String get payment_type {
    return Intl.message(
      'Payment type',
      name: 'payment_type',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Return invoice`
  String get return_invoice {
    return Intl.message(
      'Return invoice',
      name: 'return_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get approval_invoice {
    return Intl.message(
      'Approve',
      name: 'approval_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Create invoice`
  String get create_invoice {
    return Intl.message(
      'Create invoice',
      name: 'create_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Save invoice`
  String get update_invoice {
    return Intl.message(
      'Save invoice',
      name: 'update_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Unselected`
  String get unselected {
    return Intl.message(
      'Unselected',
      name: 'unselected',
      desc: '',
      args: [],
    );
  }


  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get add_product {
    return Intl.message(
      'Add product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get total_amount {
    return Intl.message(
      'Total amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this product`
  String get delete_product_qu {
    return Intl.message(
      'Do you want to delete this product',
      name: 'delete_product_qu',
      desc: '',
      args: [],
    );
  }

  /// `This product will be deleted from the invoice`
  String get delete_product_info {
    return Intl.message(
      'This product will be deleted from the invoice',
      name: 'delete_product_info',
      desc: '',
      args: [],
    );
  }

  /// `Receipts details`
  String get receipts_details {
    return Intl.message(
      'Receipts details',
      name: 'receipts_details',
      desc: '',
      args: [],
    );
  }

  /// `Invoice no`
  String get invoice_no {
    return Intl.message(
      'Invoice no',
      name: 'invoice_no',
      desc: '',
      args: [],
    );
  }

  /// `On it, the delegate is delivered`
  String get deliver_customer {
    return Intl.message(
      'On it, the delegate is delivered',
      name: 'deliver_customer',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Select invoices`
  String get select_invoices {
    return Intl.message(
      'Select invoices',
      name: 'select_invoices',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Edit invoices`
  String get edit_invoices {
    return Intl.message(
      'Edit invoices',
      name: 'edit_invoices',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Totals`
  String get totals {
    return Intl.message(
      'Totals',
      name: 'totals',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the invoice?`
  String get delete_invoice_qu {
    return Intl.message(
      'Do you want to delete the invoice?',
      name: 'delete_invoice_qu',
      desc: '',
      args: [],
    );
  }

  /// `This invoice will deleted from receipt`
  String get delete_invoice_info {
    return Intl.message(
      'This invoice will deleted from receipt',
      name: 'delete_invoice_info',
      desc: '',
      args: [],
    );
  }

  /// `Sales of today`
  String get sales_of_today {
    return Intl.message(
      'Sales of today',
      name: 'sales_of_today',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Search for product by name or code`
  String get search_for_product {
    return Intl.message(
      'Search for product by name or code',
      name: 'search_for_product',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available_in_warehouse {
    return Intl.message(
      'Available',
      name: 'available_in_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Processes`
  String get processes {
    return Intl.message(
      'Processes',
      name: 'processes',
      desc: '',
      args: [],
    );
  }

  /// `Receive statement`
  String get pull_products {
    return Intl.message(
      'Receive statement',
      name: 'pull_products',
      desc: '',
      args: [],
    );
  }

  /// `Return statement`
  String get push_products {
    return Intl.message(
      'Return statement',
      name: 'push_products',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get return_product {
    return Intl.message(
      'Return',
      name: 'return_product',
      desc: '',
      args: [],
    );
  }

  /// `No thing to view`
  String get no_data_to_view {
    return Intl.message(
      'No thing to view',
      name: 'no_data_to_view',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get back_again {
    return Intl.message(
      'Go back',
      name: 'back_again',
      desc: '',
      args: [],
    );
  }

  /// `Un known`
  String get un_known {
    return Intl.message(
      'Un known',
      name: 'un_known',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Accredited`
  String get accredited {
    return Intl.message(
      'Accredited',
      name: 'accredited',
      desc: '',
      args: [],
    );
  }

  /// `Un accredited`
  String get un_Accredited {
    return Intl.message(
      'Un accredited',
      name: 'un_Accredited',
      desc: '',
      args: [],
    );
  }

  /// `Un paid`
  String get un_paid {
    return Intl.message(
      'Un paid',
      name: 'un_paid',
      desc: '',
      args: [],
    );
  }

  /// `Sub paid`
  String get sub_paid {
    return Intl.message(
      'Sub paid',
      name: 'sub_paid',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get full_paid {
    return Intl.message(
      'Paid',
      name: 'full_paid',
      desc: '',
      args: [],
    );
  }

  /// `The user does not exist or the password is incorrect, try again.`
  String get login_au_auth_user {
    return Intl.message(
      'The user does not exist or the password is incorrect, try again.',
      name: 'login_au_auth_user',
      desc: '',
      args: [],
    );
  }

  /// `There is no internet connection, please check the phone data connection.`
  String get no_internet_connection_error {
    return Intl.message(
      'There is no internet connection, please check the phone data connection.',
      name: 'no_internet_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Problem!`
  String get problem {
    return Intl.message(
      'Problem!',
      name: 'problem',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Add products that you want return`
  String get add_products_message {
    return Intl.message(
      'Add products that you want return',
      name: 'add_products_message',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to return this products?`
  String get return_products_qu {
    return Intl.message(
      'Do you want to return this products?',
      name: 'return_products_qu',
      desc: '',
      args: [],
    );
  }

  /// `this products will be return to the main warehouse`
  String get return_products_info {
    return Intl.message(
      'this products will be return to the main warehouse',
      name: 'return_products_info',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `New amount`
  String get enter_paid_amount {
    return Intl.message(
      'New amount',
      name: 'enter_paid_amount',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Products returned successfully`
  String get return_success {
    return Intl.message(
      'Products returned successfully',
      name: 'return_success',
      desc: '',
      args: [],
    );
  }

  /// `Invalid quantity`
  String get invalid_quantity {
    return Intl.message(
      'Invalid quantity',
      name: 'invalid_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Invalid amount`
  String get invalid_amount {
    return Intl.message(
      'Invalid amount',
      name: 'invalid_amount',
      desc: '',
      args: [],
    );
  }

  /// `You have no New receive statement`
  String get no_new_receive_statement {
    return Intl.message(
      'You have no New receive statement',
      name: 'no_new_receive_statement',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `When you accept this statement it's products will be added to your warehouse`
  String get accept_statement_info {
    return Intl.message(
      'When you accept this statement it\'s products will be added to your warehouse',
      name: 'accept_statement_info',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reject this statement?`
  String get reject_statement_info {
    return Intl.message(
      'Are you sure you want to reject this statement?',
      name: 'reject_statement_info',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Un approved`
  String get unapproved {
    return Intl.message(
      'Un approved',
      name: 'unapproved',
      desc: '',
      args: [],
    );
  }

  /// `Soon...`
  String get soon {
    return Intl.message(
      'Soon...',
      name: 'soon',
      desc: '',
      args: [],
    );
  }

  /// `PLease fill all fields`
  String get please_fill_field {
    return Intl.message(
      'PLease fill all fields',
      name: 'please_fill_field',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `R.S`
  String get currency_rs {
    return Intl.message(
      'R.S',
      name: 'currency_rs',
      desc: '',
      args: [],
    );
  }

  /// `Please enter amount for all invoices`
  String get valid_receipts_message {
    return Intl.message(
      'Please enter amount for all invoices',
      name: 'valid_receipts_message',
      desc: '',
      args: [],
    );
  }

  /// `Invoice remain amount`
  String get invoice_remain_amount {
    return Intl.message(
      'Invoice remain amount',
      name: 'invoice_remain_amount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to approve this invoice?`
  String get approve_invoice_qu {
    return Intl.message(
      'Are you sure to approve this invoice?',
      name: 'approve_invoice_qu',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to approve this receipt?`
  String get approve_receipt_qu {
    return Intl.message(
      'Are you sure to approve this receipt?',
      name: 'approve_receipt_qu',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this receipt?`
  String get delete_receipt_qu {
    return Intl.message(
      'Are you sure to delete this receipt?',
      name: 'delete_receipt_qu',
      desc: '',
      args: [],
    );
  }

  /// `please select customer`
  String get please_select_customer {
    return Intl.message(
      'please select customer',
      name: 'please_select_customer',
      desc: '',
      args: [],
    );
  }

  /// `please select products`
  String get please_select_products {
    return Intl.message(
      'please select products',
      name: 'please_select_products',
      desc: '',
      args: [],
    );
  }

  /// `Available quantity`
  String get available_quantity {
    return Intl.message(
      'Available quantity',
      name: 'available_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Simplified tax invoice`
  String get simple_tax_invoice {
    return Intl.message(
      'Simplified tax invoice',
      name: 'simple_tax_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Detailed tax invoice`
  String get details_tax_invoice {
    return Intl.message(
      'Detailed tax invoice',
      name: 'details_tax_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Create request products`
  String get create_request_products {
    return Intl.message(
      'Create request products',
      name: 'create_request_products',
      desc: '',
      args: [],
    );
  }

  /// `Save request products`
  String get update_request_products {
    return Intl.message(
      'Save request products',
      name: 'update_request_products',
      desc: '',
      args: [],
    );
  }

  /// `Request products`
  String get request_products {
    return Intl.message(
      'Request products',
      name: 'request_products',
      desc: '',
      args: [],
    );
  }

  /// `New request products`
  String get new_request_products {
    return Intl.message(
      'New request products',
      name: 'new_request_products',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this receipt?`
  String get delete_request_products_qu {
    return Intl.message(
      'Are you sure to delete this receipt?',
      name: 'delete_request_products_qu',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to approve this request?`
  String get approve_request_products_qu {
    return Intl.message(
      'Are you sure to approve this request?',
      name: 'approve_request_products_qu',
      desc: '',
      args: [],
    );
  }

  /// `Print design`
  String get print_design_title {
    return Intl.message(
      'Print design',
      name: 'print_design_title',
      desc: '',
      args: [],
    );
  }

  /// `Please select design`
  String get print_design_sub_title {
    return Intl.message(
      'Please select design',
      name: 'print_design_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Tax invoice`
  String get print_design_BTB {
    return Intl.message(
      'Tax invoice',
      name: 'print_design_BTB',
      desc: '',
      args: [],
    );
  }

  /// `Simplified tax invoice`
  String get print_design_BTC {
    return Intl.message(
      'Simplified tax invoice',
      name: 'print_design_BTC',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Current price`
  String get current_price {
    return Intl.message(
      'Current price',
      name: 'current_price',
      desc: '',
      args: [],
    );
  }

  /// `Customer name`
  String get customer_name {
    return Intl.message(
      'Customer name',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Tax id`
  String get tax_id {
    return Intl.message(
      'Tax id',
      name: 'tax_id',
      desc: '',
      args: [],
    );
  }

  /// `Please add customer name`
  String get customer_name_qr {
    return Intl.message(
      'Please add customer name',
      name: 'customer_name_qr',
      desc: '',
      args: [],
    );
  }

  /// `Please add customer tax id`
  String get tax_id_qr {
    return Intl.message(
      'Please add customer tax id',
      name: 'tax_id_qr',
      desc: '',
      args: [],
    );
  }

  /// `Large size invoice`
  String get print_design_large {
    return Intl.message(
      'Large size invoice',
      name: 'print_design_large',
      desc: '',
      args: [],
    );
  }

  /// `Small size invoice`
  String get print_design_small {
    return Intl.message(
      'Small size invoice',
      name: 'print_design_small',
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
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}