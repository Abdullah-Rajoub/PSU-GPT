// local testing:
// class AppRoutes {
//   static const domainName = "beta.psu-gpt.com";
//   static const _serverURL = "192.168.1.83";
//   static const _portNumber = "8000";
//   static const signupRoute = "http://${_serverURL}:${_portNumber}/auth/users/";
//   static const loginRoute =
//       "http://${_serverURL}:${_portNumber}/auth/jwt/create/";
//   static const guestChatRoute =
//       "http://${_serverURL}:${_portNumber}/api/guest/psu_support_gpt";
//   static const userChatRoute =
//       "http://${_serverURL}:${_portNumber}/api/psu_support_gpt";
//   static const getUserMessages =
//       "http://${_serverURL}:${_portNumber}/api/user/messages";
//   static const getUserDetials =
//       "http://${_serverURL}:${_portNumber}/api/user/details";
//   static String guestReviewRoute({required messageID}) {
//     return "http://${_serverURL}:${_portNumber}/api/guest/psu_support_gpt/${messageID}";
//   }
//
//   static String userReviewRoute({required messageID}) {
//     return "http://${_serverURL}:${_portNumber}/api/psu_support_gpt/${messageID}";
//   }
//
//   static String editeUserDetails({required userID}) {
//     return "http://${_serverURL}:${_portNumber}/api/edit/user/details/${userID}";
//   }
//
//   // Beta: might change:
//   static const resetPasswordRoute = "/auth/users/reset_password_confirm/";
//   static const activateAccount = "/activate/";
// }

// live server:
class AppRoutes {
  static const domainName = "beta.psu-gpt.com";
  static const _serverURL = "192.168.1.83";
  static const _portNumber = "8000";
  static const signupRoute = "https://${domainName}/auth/users/";
  static const loginRoute = "https://${domainName}/auth/jwt/create/";
  static const guestChatRoute =
      "https://${domainName}/api/guest/psu_support_gpt";
  static const userChatRoute = "https://${domainName}/api/psu_support_gpt";
  static const getUserMessages = "https://${domainName}/api/user/messages";
  static const getUserDetials = "https://${domainName}/api/user/details";
  static String guestReviewRoute({required messageID}) {
    return "https://${domainName}/api/guest/psu_support_gpt/${messageID}";
  }

  static String userReviewRoute({required messageID}) {
    return "https://${domainName}/api/psu_support_gpt/${messageID}";
  }

//   static String editeUserDetails({required userID}) {
//     return "http://${_serverURL}:${_portNumber}/api/edit/user/details/${userID}";
//   }
  static String editeUserDetails({required userID}) {
    return "https://${domainName}/api/edit/user/details/${userID}";
  }

  // Beta: might change:
  static const resetPasswordRoute = "/auth/users/reset_password_confirm/";
  static const activateAccount = "/activate/";
}
