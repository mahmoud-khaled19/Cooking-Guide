import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payment_application/utils/global_methods.dart';
import 'package:payment_application/view/home_screen.dart';
import 'package:payment_application/view_model/boxes.dart';
import 'package:payment_application/view_model/person.dart';
import 'package:payment_application/widgets/elevated_button_widget.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return CardScreenState();
  }
}

class CardScreenState extends State<CardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CreditCardWidget(
              glassmorphismConfig:
                  useGlassMorphism ? Glassmorphism.defaultConfig() : null,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              frontCardBorder:
                  !useGlassMorphism ? Border.all(color: Colors.grey) : null,
              backCardBorder:
                  !useGlassMorphism ? Border.all(color: Colors.grey) : null,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: Theme.of(context).splashColor,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: false,
                      obscureNumber: false,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      textColor: Colors.white,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: style,
                        labelStyle: style,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      expiryDateDecoration: InputDecoration(
                        /// validate the date
                        hintStyle: style,
                        labelStyle: style,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle: style,
                        labelStyle: style,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    DefaultButton(
                      text: 'Save',
                      function: _onValidate,
                      context: context,
                      color: Theme.of(context).splashColor,
                      width: 200,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      setState(() {
        personBox
            .put(
                'cardDetails: $cardHolderName',
                Person(
                    name: cardHolderName,
                    cardCvv: cvvCode,
                    cardExpiryDate: expiryDate,
                    cardNumber: cardNumber))
            .then((value) {
          GlobalMethods.showSnackBar(
              context, 'Card Info Saved Successfully', Colors.green);
          GlobalMethods.navigateTo(context, HomeScreen());
        });
      });
    } else {}
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
