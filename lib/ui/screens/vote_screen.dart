import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_voter/providers/main_model.dart';
import 'package:game_voter/ui/widgets/intButton.dart';

class VoteScreen extends ConsumerWidget {
  const VoteScreen({Key? key}) : super(key: key);
  static const rowHeight = 40;
  static const rowMarginSize = 8;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int rowCount = ref.watch(votePageControllerProvider).getRowCount();
    String screenValue =
        ref.watch(votePageControllerProvider).getValueForScreen();
    String buttonText =
        ref.watch(votePageControllerProvider).getShowHideButtonText();
    bool isVisible = (screenValue != '');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Голосование'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: isVisible
                ? FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      screenValue,
                      style: const TextStyle(
                        fontSize: 200,
                      ),
                    ),
                  )
                : const Text(''),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            height: rowCount * (rowHeight + (rowMarginSize - 4) * 2.0),
            child: IntButtonsArray(),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ref.read(votePageControllerProvider).toggleVisibility();
              },
              child: Text(ref.watch(showButtonText)),
            ),
          ),
        ],
      ),
    );
  }
}

class IntButtonsArray extends ConsumerWidget {
  IntButtonsArray({Key? key}) : super(key: key);

  int rows = 1;
  int cols = 1;
  int maxCols = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(votePageControllerProvider).getTotalCount();
    final numList = ref.watch(votePageControllerProvider).getNumbers();
    calcSize(count);
    ref.read(rowCountProvider.state).state = rows;
    return Column(
      children: [
        for (int r = 0; r < rows; r++)
          SizedBox(
            height: 40 + VoteScreen.rowMarginSize * 1.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = r * cols; (i < (r + 1) * cols) && (i < count); i++)
                  IntButton(numList[i]),
              ],
            ),
          ),
        // ),
      ],
    );
  }

  void calcSize(int total) {
    int maxCols = 4;
    rows = ((total - 1) ~/ maxCols) + 1;
    var mod = total % rows;
    cols = (total / rows).truncate();
    if (mod > 0) cols++;
  }
}
