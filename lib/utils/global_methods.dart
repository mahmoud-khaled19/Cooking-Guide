import 'dart:developer';

import 'package:flutter/material.dart';
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
}
