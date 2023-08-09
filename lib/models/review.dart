class Review {
  // String :either null or like / dislike
  var _feedback = null;
  // int: rating either null or 1-5 inclusive and  whole numbers only
  var _rating = null;
  // String: feedback either null or less 1000< letters.
  var _comment = null;
  Review();
  void setRating({required rating}) {
    if (rating == null) _rating = -1;
    _rating = rating;
  }

  void setComment({required comment}) {
    if (comment == null) _comment = "";
    _comment = comment;
  }

  void setFeedback({required feedback}) {
    if (feedback == null) _feedback = "";
    _feedback = feedback;
  }

  int getRating() {
    if (_rating == null) return -1;
    return _rating;
  }

  String getComment() {
    if (_comment == null) return "";
    return _comment;
  }

  String getFeedback() {
    if (_feedback == null) return "";
    return _feedback;
  }
}
