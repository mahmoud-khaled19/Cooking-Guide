import 'package:flutter/material.dart';
import '../view_model/boxes.dart';
import '../view_model/person.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context,index){
            Person? person = personBox.getAt(index);
            return Container(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( person!.name!),
                  Text( person.cardNumber!),
                  Text( person.cardExpiryDate!),
                  Text( person.cardCvv!),

                ],
              ),
            );
          },
          separatorBuilder: (context,index){
            return const Divider(
              thickness: 2,
            );
          },
          itemCount: personBox.length,
        ),
      ),
    );
  }
}
