class ApiEndPoints{
  // Auth
  static const String signupUser = '/users/signup';
  static const String loginUser = '/users/login';
  static const String verifyOtp = '/users/verify-otp';
  static const String resendOtp = '/users/resend-otp';
  static const String forgotPassword = '/users/forgot-password';
  static const String resetPassword = '/users/reset-password';
  static const String forgotVerifyOtp = '/users/verify-forgot-password-otp';
  static const String updateProfile = '/users/profile';
  static const String changePassword = '/users/change-password';
  static const String createPost = '/posts';
  static const String favoriteEvent = '/users/favorites';
  static const String joinEvent = '/tickets/join';


  static String getAllEvents(String search, String category, int page, int limit, ) {
    return "/events?search=$search&category=$category&page=$page&limit=$limit";
  }
  static String toggleFavoriteEvents(String eventId) {
    return "/users/favorites/$eventId";
  }
  static String toggleLike(String id) {
    return "/posts/$id/like";
  }
  static String addComment(String id) {
    return "/posts/$id/comment";
  }
  static String getEventById(String id) {
    return "/events/$id";
  }
  static String deletePost(String id) {
    return "/posts/$id";
  }
  static String deleteTicket(String id) {
    return "/tickets/$id";
  }
  static String deleteComment(String postId, String commentId) {
    return "/posts/$postId/comment/$commentId";
  }
  static String getTickets(int page, int limit, String status){
    return '/tickets?page=$page&limit=$limit&status=$status';
  }















  // static const String signupUser = '/api/auth/fleet-manager/signup';
  //
  // static String getWheelUrl() {
  //   return "/api/fleet/assets?type=wheel&status=inStorage&search=";
  //
  // }
  // static String returnBillingUrl(String status,{int? page,int? limit}){
  //   return '/api/fleet/transaction?page=1&limit=10&status=$status';
  // }

}