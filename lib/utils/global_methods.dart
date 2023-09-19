import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/default_custom_text.dart';
import 'package:share_plus/share_plus.dart';

class GlobalMethods {
  static navigateTo(context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static navigateAndFinish(context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static showVideo(String? videoUrl) async {
    final Uri url = Uri.parse(videoUrl!);
    if (!await launchUrl(
      url,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      content: DefaultCustomText(
        text: text,
      ),
    ));
  }

  static validate(text, String? value) {
    if (value!.isEmpty) {
      return text;
    } else {
      return null;
    }
  }

  static showAlertDialog({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: title,
            content: content,
            actions: actions,
          );
        });
  }

  static openWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  static mailTo(String mail) async {
    final Uri url = Uri.parse('mailto:$mail');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static callPhoneNumber(String phoneNumber) async {
    final Uri url = Uri.parse('tel:///$phoneNumber');
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  static shareLink(String url) async {
    try {
      Share.share(url, subject: 'Look what I made!');
    } catch (e) {
      log(e.toString());
    }
  }

  static String errorMessagesConditions(dynamic error) {
    if (error ==
        '[firebase_auth/channel-error] Unable to establish connection on channel.') {
      return AppStrings.networkRequestFailed;
    } else if (error ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      return AppStrings.wrongPassword;
    } else if (error ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      return AppStrings.userNotFound;
    } else if (error ==
        '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
      return AppStrings.networkRequestFailed;
    } else if (error ==
        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
      return AppStrings.emailAlreadyInUse;
    } else if (error ==
        '[firebase_auth/invalid-email] The email address is badly formatted.') {
      return AppStrings.invalidEmail;
    } else if (error ==
        '[firebase_auth/operation-not-allowed] This operation is not allowed. You must enable this service in the Firebase Console.') {
      return 'operationNotAllowed';
    } else if (error ==
        '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.') {
      return 'tooManyRequests';
    } else {
      return 'Check All Fields';
    }
  }

  static showErrorMessage(
    dynamic error,
    BuildContext context,
  ) {
    log(error.toString());
    String errorMessage = errorMessagesConditions(error.toString());
    log(errorMessage);
    log(error.toString());
    return GlobalMethods.showAlertDialog(
        context: context,
        title: DefaultCustomText(text: 'Error'),
        content: Container(
          height: AppSize.s70,
          child: DefaultCustomText(
            text: errorMessage.toString().toLowerCase(),
            maxLines: 4,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const DefaultCustomText(
                alignment: Alignment.centerRight,
                text: 'ok',
                color: Colors.red,
              )),
        ]);
  }
}
