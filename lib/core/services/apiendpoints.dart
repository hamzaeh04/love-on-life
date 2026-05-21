import 'package:firebase_auth/firebase_auth.dart';

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
  static const String getMyEvents = '/events/my-events';
  static const String readAllNotifications = '/notifications/mark-all-read';


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
  static String getNotifications(int page, int limit){
    return '/notifications/my-notifications?page=$page&limit=$limit';
  }
  static String readSingleNotification(String notificationId){
    return '/notifications/$notificationId/read';
  }

  //Payment
  static const String createPaymentIntent = '/tickets/pay';
  //Google Login
  static const String googleSignIn = "/users/auth/google";
  //Apple Login
  static const String appleSignIn = "/users/auth/apple";

  //Delete Account
  static const String deleteAccount = "/users/delete-account";
  //Report
  static const String reportComment = "/reports";
  static const String reportPost = "/reports";
  //Block
  static String blockUser(String UserId){
    return '/users/block/$UserId?block=true';
  }
  static String unblockUser(String UserId){
    return '/users/block/$UserId?block=false';
  }
  static const String getAllBlockedUsers = "/users/blocked";

}
