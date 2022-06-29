import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_voter/enums/vote_state.dart';
import 'package:game_voter/providers/vote_page_controller.dart';

final countProvider = StateProvider((ref) => 4);
final voteProvider = StateProvider((ref) => VoteState.hidden);
final selectedProvider = StateProvider((ref) => 1);
final visibleValueProvider = Provider((ref) {
  final vote = ref.watch(voteProvider);
  final selected = ref.watch(selectedProvider);
  String screenValue = '';
  if (vote == VoteState.shown) screenValue = selected.toString();
  return screenValue;
});
final needRandomOrderProvider = StateProvider<bool>((ref) => false);
final numberListProvider = StateProvider<List<int>>((ref) => []);
final rowCountProvider = StateProvider<int>((ref) => 1);
final showButtonText = Provider<String>((ref) {
  final isVisible = ref.watch(voteProvider);
  if (isVisible == VoteState.shown) {
    return 'Скрыть';
  } else {
    return 'Показать';
  }
});

final votePageControllerProvider = Provider((ref) => VotePageController(ref));
