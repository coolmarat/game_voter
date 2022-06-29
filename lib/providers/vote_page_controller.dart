import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_voter/enums/vote_state.dart';
import 'package:game_voter/providers/main_model.dart';

class VotePageController
// extends StateNotifier<int>
{
  VotePageController(this.ref);

  final ProviderRef ref;

  // VotePageController(this.ref);

  void setVoteNumber(int value) {
    ref.read(selectedProvider.state).state = value;
    ref.read(voteProvider.state).state = VoteState.hidden;
  }

  void toggleVisibility() {
    var isVisible = ref.read(voteProvider.state).state;
    if (isVisible == VoteState.hidden) {
      isVisible = VoteState.shown;
    } else if (isVisible == VoteState.shown) {
      isVisible = VoteState.hidden;
    }
    ref.read(voteProvider.state).state = isVisible;
  }

  void shuffleNumbers() {
    var numList = ref.read(numberListProvider.state).state;
    numList.shuffle();
    ref.read(numberListProvider.state).state = numList;
  }

  void fillNumbers() {
    var numList = ref.read(numberListProvider);
    var total = ref.read(countProvider);
    numList.clear();
    for (int i = 1; i <= total; i++) {
      numList.add(i);
    }
  }

  int getTotalCount() {
    return ref.read(countProvider);
  }

  String getValueForScreen() {
    return ref.read(visibleValueProvider);
  }

  int getRowCount() {
    return ref.read(rowCountProvider);
  }

  String getShowHideButtonText() {
    return ref.read(showButtonText);
  }

  void hideScreenValue() {
    ref.read(voteProvider.state).state = VoteState.hidden;
  }

  List<int> getNumbers() {
    return ref.read(numberListProvider);
  }
}
