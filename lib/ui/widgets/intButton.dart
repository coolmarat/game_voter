import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_voter/providers/main_model.dart';

class IntButton extends ConsumerWidget {
  final int value;

  const IntButton(this.value, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8)),
        child: TextButton(
          onPressed: () {
            var needShuffle = ref.read(needRandomOrderProvider);

            ref.read(votePageControllerProvider).setVoteNumber(value);
            if (needShuffle) {
              ref.read(votePageControllerProvider).shuffleNumbers();
            }
          },
          child: Text(
            value.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
