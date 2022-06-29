import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_voter/consts.dart';
import 'package:game_voter/ui/screens/vote_screen.dart';

import '../../providers/main_model.dart';

class StartForm extends StatefulWidget {
  const StartForm({Key? key}) : super(key: key);

  @override
  StartFormState createState() => StartFormState();
}

class StartFormState extends State<StartForm> {
  final _formKey = GlobalKey<FormState>();
  int total = 0;
  static const errMsg = 'Введите число от $minValue до $maxValue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Голосования'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                initialValue: minValue.toString(),
                maxLength: maxValue.toString().length,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null) return errMsg;
                  if ((number < minValue) || (number > maxValue)) {
                    return errMsg;
                  }
                  total = number;
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Максимальное число',
                  labelStyle: TextStyle(
                    color: myPurple,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myPurple),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('Перемешивать кнопки'),
                  const Expanded(
                      child: SizedBox(
                    height: 40,
                  )),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      var needShuffle = ref.watch(needRandomOrderProvider);
                      return Switch(
                          value: needShuffle,
                          onChanged: (value) {
                            ref.read(needRandomOrderProvider.state).state =
                                value;
                          });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(countProvider.state).state = total;
                        ref.read(votePageControllerProvider).fillNumbers();

                        ref.read(rowCountProvider.state).state =
                            ((total - 1) ~/ maxButtonsInRow) + 1;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VoteScreen()),
                        );
                      }
                    },
                    child: const Text('Поехали'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
