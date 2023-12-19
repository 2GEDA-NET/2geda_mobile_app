import 'package:_2geda/pages/widgets/post/presentation/comps/enums.dart';

class ReactionModel {
  ReactionType reactionType;
  String svg;

  ReactionModel(
    this.reactionType,
    this.svg,
  );
}

final List<ReactionModel> rs = [
  // ReactionModel(ReactionType.like, 'assets/liked.svg'),
  ReactionModel(
    ReactionType.dislike,
    'assets/ulik.svg',
  ),
  ReactionModel(
    ReactionType.angry,
    'assets/emoji _pouting face_.svg',
  ),
  ReactionModel(
    ReactionType.hug,
    'assets/emoji _hugging face_.svg',
  ),
  ReactionModel(
    ReactionType.laugh,
    'assets/emoji _face with tears of joy_ (1).svg',
  ),
  ReactionModel(
    ReactionType.tears,
    'assets/emoji _crying face_.svg',
  ),
  ReactionModel(
    ReactionType.wow,
    'assets/emoji _hushed face_.svg',
  ),
];
