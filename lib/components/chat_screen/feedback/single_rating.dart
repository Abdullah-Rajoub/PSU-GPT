import 'package:flutter/material.dart';
import 'package:gpt_clone/components/chat_screen/feedback/rating_icon.dart';

class SingleRating extends StatefulWidget {
  var iconName;
  // for some reason, the value of rating is displayed as string in front end
  String ratingTitle;
  String activeTitle;
  // for some reason again, the value of the rating is saved as a whole number in the database (1-5)
  int ratingValue;
  var onTapRating;

  SingleRating(
      {required this.iconName,
      required this.ratingTitle,
      required this.activeTitle,
      required this.onTapRating,
      required this.ratingValue});

  @override
  State<SingleRating> createState() => _SingleRatingState();
}

class _SingleRatingState extends State<SingleRating> {
  @override
  Widget build(BuildContext context) {
    var onTapRating = widget.onTapRating;
    String ratingTitle = widget.ratingTitle;
    String iconName = widget.iconName;
    String activeTitle = widget.activeTitle;
    int rating = widget.ratingValue;
    bool isActive() {
      return ratingTitle == activeTitle;
    }

    return GestureDetector(
      onTap: () {
        onTapRating(newActiveTitle: ratingTitle, rating: rating);
      },
      child: Container(
        height: 36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingIcon(
              iconName: iconName,
              isActive: isActive(),
            ),
            Text(
              ratingTitle,
              style: TextStyle(
                  color: isActive() ? Colors.black : Colors.grey, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorChangeAnimation extends StatefulWidget {
  @override
  _ColorChangeAnimationState createState() => _ColorChangeAnimationState();
}

class _ColorChangeAnimationState extends State<ColorChangeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1), // Change the duration as needed
      vsync: this,
    );

    _colorAnimation = _animationController.drive(
      ColorTween(
          begin: Colors.grey, end: Colors.black), // Change the colors as needed
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradual Color Change'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              width: 100,
              height: 100,
              color: _colorAnimation.value,
            );
          },
        ),
      ),
    );
  }
}
