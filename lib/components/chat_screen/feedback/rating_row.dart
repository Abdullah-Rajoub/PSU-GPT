import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/components/chat_screen/feedback/single_rating.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';

class RatingRow extends StatefulWidget {
  // nothing active at the beginning.
  String activeTitle = "";
  var setRating;
  RatingRow({required this.setRating});
  @override
  State<RatingRow> createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow> {
  @override
  Widget build(BuildContext context) {
    String activeTitle = widget.activeTitle;

    void onTapRating({required String newActiveTitle, required int rating}) {
      setState(() {
        widget.activeTitle = newActiveTitle;
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SingleRating(
          iconName: "fair",
          ratingTitle: LocaleKeys.fair.tr(),
          activeTitle: activeTitle,
          onTapRating: onTapRating,
          ratingValue: 1,
        ),
        SingleRating(
          iconName: 'moderate',
          ratingTitle: LocaleKeys.moderate.tr(),
          activeTitle: activeTitle,
          onTapRating: onTapRating,
          ratingValue: 2,
        ),
        SingleRating(
          iconName: 'veryGood',
          ratingTitle: LocaleKeys.veryGood.tr(),
          activeTitle: activeTitle,
          onTapRating: onTapRating,
          ratingValue: 3,
        ),
        SingleRating(
          iconName: 'excellent',
          ratingTitle: LocaleKeys.excellent.tr(),
          activeTitle: activeTitle,
          onTapRating: onTapRating,
          ratingValue: 4,
        ),
        SingleRating(
          iconName: "amazing",
          ratingTitle: LocaleKeys.amazing.tr(),
          activeTitle: activeTitle,
          onTapRating: onTapRating,
          ratingValue: 5,
        ),
      ],
    );
  }
}
