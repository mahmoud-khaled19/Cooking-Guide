import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_application/utils/assets_manager.dart';
import 'package:payment_application/utils/global_methods.dart';
import 'package:payment_application/view/card_screen.dart';
import '../widgets/default_custom_text.dart';

class LocalAuth extends StatefulWidget {
  const LocalAuth({Key? key}) : super(key: key);

  @override
  State<LocalAuth> createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  bool authenticated = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth
          .authenticate(
        localizedReason: 'Scan your fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      )
          .then((value) {
        if (value == true) {
          GlobalMethods.navigateAndFinish(context, const CardScreen());
        }
        return false;
      });
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Lottie.network(ImagesManager.authenticateScreen ?? '',
                  height: size * 0.6, width: size * 0.6, fit: BoxFit.fill),
              if (_isAuthenticating)
                ElevatedButton(
                  onPressed: _cancelAuthentication,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DefaultCustomText(
                        text: 'Cancel Authentication',
                      ),
                      Icon(Icons.cancel),
                    ],
                  ),
                )
              else
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _authenticateWithBiometrics,
                      child: Container(
                        width: size * 0.17,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultCustomText(
                              text:
                                  _isAuthenticating ? 'Cancel' : 'Authenticate',
                            ),
                            const Icon(Icons.fingerprint),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
