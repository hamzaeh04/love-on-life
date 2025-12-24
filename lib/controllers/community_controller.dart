import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_on_life/controllers/auth_controller.dart';
import 'package:love_on_life/controllers/dashboard_controller.dart';
import 'package:love_on_life/model/community_post_model.dart';
import 'package:love_on_life/model/favorite_event_model.dart';
import 'package:love_on_life/model/get_all_events_model.dart';
import 'package:love_on_life/model/get_event_by_id_model.dart';
import 'package:love_on_life/utils/shared_prefrences_methods.dart';
import 'package:love_on_life/widgets/custom_ticket_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../model/community_post_model.dart';
import '../outh_file/local_db_key.dart';
import '../utils/utility.dart';
import 'package:intl/intl.dart';


class CommunityController extends GetxController {
  final AuthController controller = Get.find<AuthController>();
  final DashboardController dashboardController = Get.find<DashboardController>();


  RxInt currentCarouselIndex = 0.obs;
  var isPostingComment = false.obs; // 🔹 disable button during post
  RxString postVisibility = 'Public'.obs;
  var isLoadingPosts = false.obs;
  var getAllPostModel = Rxn<GetAllPostModel>();
  Rx<GetAllEventModel?> getAllEventsModel = Rx<GetAllEventModel?>(null);
  Rx<GetEventByIdModel?> getEventByIdModel = Rx<GetEventByIdModel?>(null);
  Rx<FavoriteEventModel?> getFavoriteEventModel = Rx<FavoriteEventModel?>(null);
  RxString searchFieldContent = ''.obs;

  final prefs = SharedPreferencesMethod.storage;
  // PostModel will parse your API JSON
  final profilePic = ''.obs;
  RxBool isFavorite = false.obs;

  final TextEditingController searchField = TextEditingController();
  final TextEditingController postDescField = TextEditingController();
  final TextEditingController addCommentField = TextEditingController();
  BaseService baseService = BaseService();
  RxBool canPost = false.obs;
  RxInt addLike = 0.obs;
  var isLikeIncremnet = 0;
  RxInt visiblePostCount = 3.obs;

  void loadMorePosts() {
    visiblePostCount.value += 2;
  }
  void toggleIsFav(){
    isFavorite.value = !isFavorite.value;
  }

  RxList<Events> eventsList = <Events>[].obs;

  RxBool isLoadingEvents = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    postDescField.addListener(_validatePost);
  }

  void _validatePost() {
    canPost.value =
        postDescField.text.trim().isNotEmpty || selectedPostImage.value != null;
  }

  void shareEvent(String link) {
    Share.share(link);
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return '';

    try {
      final parts = time.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      final isPM = hour >= 12;
      hour = hour % 12;
      if (hour == 0) hour = 12;

      return "$hour:${minute.toString().padLeft(2, '0')} ${isPM ? 'PM' : 'AM'}";
    } catch (e) {
      return '';
    }
  }

  String formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(isoDate).toLocal();

      return "${dateTime.day.toString().padLeft(2, '0')} "
          "${_monthName(dateTime.month)} "
          "${dateTime.year}";
    } catch (e) {
      return '';
    }
  }

  String formatTime2(String isoTimestamp) {
    return DateFormat.jm().format(DateTime.parse(isoTimestamp).toLocal());
  }


  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  // Image selection
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedPostImage = Rx<File?>(null);
  Future<void> pickImagePost() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      selectedPostImage.value = File(image.path);
      _validatePost();
    }
  }
  void IncrementLike(bool isLiked) {
    if (isLiked == true) {
      isLikeIncremnet--;
    }
    else if (isLiked == false) {
      isLikeIncremnet++;
    }
    else {

    }
  }

  void removePostImage() {
    selectedPostImage.value = null;
    _validatePost();
  }

  // Controller ke andar toggleLike function ko aise update karein:

  Future<void> toggleLike(String postId, int postIndex) async {
    try {
      var postsList = getAllPostModel.value?.data;
      if (postsList != null && postIndex < postsList.length) {
        final post = postsList[postIndex];

        // 1. Pehle current state save karein (Backup)
        final bool wasLiked = post.isLiked ?? false;
        final int oldLikeCount = post.likesCount ?? 0;

        // 2. UI ko foran update karein (Optimistic UI)
        post.isLiked = !wasLiked;
        // Agar pehle liked tha to ab -1, warna +1
        post.likesCount = wasLiked ? (oldLikeCount - 1) : (oldLikeCount + 1);

        getAllPostModel.refresh(); // Poori list refresh karein taake UI update ho

        // 3. API Call
        final uri = Uri.parse("${BaseService().baseURL}${ApiEndPoints.toggleLike(postId)}");
        final request = http.MultipartRequest('POST', uri);
        print(uri);

        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString(LocalDBKeys.TOKEN);
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }

        final streamedResponse = await request.send().timeout(const Duration(seconds: 20));
        final responseString = await streamedResponse.stream.bytesToString();
        final decoded = json.decode(responseString);

        if (decoded['success'] == true) {
          // Server se agar naya count aa raha hai to wo set kar dein
          // Assume API returns: { success: true, likesCount: 10, isLiked: true }
          if(decoded['data'] != null) {
            post.likesCount = decoded['data']['likesCount'] ?? post.likesCount;
            post.isLiked = decoded['data']['isLiked'] ?? post.isLiked;
            getAllPostModel.refresh();
          }
          print(decoded['data']);
        } else {
          // Agar API fail hui to wapis purani state par le aayein (Rollback)
          post.isLiked = wasLiked;
          post.likesCount = oldLikeCount;
          getAllPostModel.refresh();
          Utils.showToast("Failed to update like", true);
        }
      }
    } catch (e) {
      // Error handling
      print("Like Error: $e");
    }
  }

  Future<void> toggleFavoriteEvent(String eventId, int eventIndex) async {
    try {
      final events = getAllEventsModel.value?.data?.events;

      if (events == null || eventIndex >= events.length) return;

      final event = events[eventIndex];

      // 1️⃣ Backup old state
      final bool oldFavoriteStatus = event.isFavorite ?? false;

      // 2️⃣ Optimistic UI update
      event.isFavorite = !oldFavoriteStatus;

// Sirf model ko nahi, apni eventsList ko bhi refresh karein
      eventsList.refresh();
      getAllEventsModel.refresh();

      // 3️⃣ API Call
      final uri = Uri.parse(
        "${BaseService().baseURL}${ApiEndPoints.toggleFavoriteEvents(eventId)}",
      );
      print(uri);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(LocalDBKeys.TOKEN);

      final response = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 20));

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201 && decoded['success'] == true) {
        // 4️⃣ Sync UI with server response
        event.isFavorite = decoded['data']['isFavorite'] ?? event.isFavorite;
        getAllEventsModel.refresh();
        dashboardController.toggleFavorite(eventIndex);
        print(event.isFavorite);
      } else {
        // 5️⃣ Rollback on failure
        event.isFavorite = oldFavoriteStatus;
        getAllEventsModel.refresh();
        Utils.showToast("Failed to update favorite", true);
      }
    } catch (e) {
      // 6️⃣ Rollback on error
      final events = getAllEventsModel.value?.data?.events;
      if (events != null && eventIndex < events.length) {
        events[eventIndex].isFavorite =
        !(events[eventIndex].isFavorite ?? false);
        getAllEventsModel.refresh();
      }

      debugPrint("Toggle Favorite Error: $e");
      Utils.showToast("Something went wrong", true);
    }
  }

  Future<void> getFavoriteEvents() async {
    try {
      final uri = ApiEndPoints.favoriteEvent; // Replace with your API endpoint
      //final response = await http.get(uri);

      final response = await baseService.baseGetAPI(uri);
      print(uri);

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        final model = FavoriteEventModel.fromJson(response);
        getFavoriteEventModel.value = model;
        print("message: ${response['message']}");
      } else {
        print("Failed to fetch favorite events. Status code: ${response['statusCode']}. message: ${response['message']}");
        return null;
      }
    } catch (e) {
      print("Error fetching favorite events: $e");
      return null;
    }
  }

  Future<void> joinEvent(BuildContext context, String eventId, String title, String date, String time) async {
    try {
      final uri = ApiEndPoints.joinEvent; // Your API endpoint
      final body = {"eventId": eventId};

      final response = await baseService.basePostAPI(uri, body, loading: true);

      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        Utils.showToast('${response['message']}', false);
        print("Event joined successfully: ${response['message']}");
        showTicketDialog(context, title: title, ticketNumber: response['ticketNumber'], ticketLeft: response['status'], price: response['price'], date: date, time: time);
      } else {
        print("Failed to join event. Status code: ${response['statusCode']}. Message: ${response['message']}");
      }
    } catch (e) {
      print("Error joining event: $e");
    }
  }


  Future<void> addComment(String postId, int postIndex) async {
    String commentText = addCommentField.text.trim();
    if (commentText.isEmpty) return;


    // 1. Local UI Update (Optimistic Update)
    final newComment = Comments(
      id: "temp_${DateTime.now().millisecondsSinceEpoch}", // Temporary ID
      comment: commentText,
      userId: UserId(
        fullname: controller.userName.value, // Aap apna user name yahan dynamic bhi rakh sakte hain
        profilePicture: controller.userProfilePic.value, // User ki current DP ka path
      ),
    );

    // Local list mein add karna
    getAllPostModel.value?.data?[postIndex].comments?.add(newComment);
    getAllPostModel.refresh(); // UI ko refresh karne ke liye

    // TextField clear kar dein foran
    addCommentField.clear();

    final body = {"comment": commentText};

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.addComment(postId),
        body,
        loading: false, // Local update ho gaya hai isliye loader ki zaroorat nahi
      );

      if (response == false || response == null) {
        // Agar fail ho jaye to temporary comment remove kar dein
        getAllPostModel.value?.data?[postIndex].comments?.removeWhere((c) => c.id == newComment.id);
        getAllPostModel.refresh();
        Utils.showToast('Failed to post comment', true);
        return;
      }

      final int statusCode = response['statusCode'] ?? 0;

      if (statusCode >= 200 && statusCode < 300) {
        // Success: Server se fresh data le aao (taake IDs wagera correct ho jayein)
        // GetAllPost();
      } else {
        // Error handling: Rollback local change
        getAllPostModel.value?.data?[postIndex].comments?.removeWhere((c) => c.id == newComment.id);
        getAllPostModel.refresh();
      }

    } catch (e) {
      // Rollback on crash
      getAllPostModel.value?.data?[postIndex].comments?.removeWhere((c) => c.id == newComment.id);
      getAllPostModel.refresh();
      Utils.showToast('Something went wrong', true);
    }
  }

  Future<void> createPost() async {
    try {
      final uri = Uri.parse("${BaseService().baseURL}${ApiEndPoints.createPost}");
      final request = http.MultipartRequest('POST', uri);

      // Required field
      request.fields['description'] = postDescField.text.trim();

      // Optional image
      if (selectedPostImage.value != null &&
          selectedPostImage.value!.existsSync()) {
        final file = selectedPostImage.value!;
        final fileName = file.path.split('/').last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.path,
            filename: fileName,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      // Auth header
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(LocalDBKeys.TOKEN);
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Send request
      final streamedResponse = await request.send().timeout(const Duration(seconds: 60));
      final responseString = await streamedResponse.stream.bytesToString();

      print("Raw API response: $responseString");

      // Decode safely
      final decoded = json.decode(responseString);
      if (decoded is Map<String, dynamic>) {
        final int statusCode = decoded['statusCode'] ?? streamedResponse.statusCode;
        final bool success = decoded['success'] ?? false;

        if (success && statusCode == 201) {
          Utils.showToast(decoded['message'] ?? "Post created successfully", false);

          // Optional: access the newly created post
          final newPost = decoded['data'];
          print("New post created: $newPost");

          // Clear fields
          clearPostFields();
          return;
        }

        // Handle error messages from API
        final message = decoded['message'] ?? "Post creation failed";
        Utils.showToast(message is List ? message.join(", ") : message.toString(), true);
      } else {
        Utils.showToast("Unexpected API response format", true);
        print("Decoded response: $decoded");
      }
    } on TimeoutException {
      Utils.showToast("Request timed out", true);
    } on SocketException {
      Utils.showToast("No Internet connection", true);
    } catch (e, st) {
      Utils.showToast("Unexpected error: $e", true);
      print("Stack trace: $st");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      isLoadingPosts.value = true;

      // Use the correct DELETE endpoint
      String url = ApiEndPoints.deletePost(postId);
      final responseData = await baseService.baseDeleteAPI(url);

      print("DELETE URL: $url");
      print("Response: $responseData");

      if (responseData["success"] != true) {
        Utils.showToast(responseData["message"] ?? "Something went wrong", true);
        return;
      }

      Utils.showToast(responseData["message"] ?? "Post deleted successfully", false);

      // Optional: remove the post from your list locally
      getAllPostModel.value?.data?.removeWhere((post) => post.id == postId);

    } catch (e) {
      print("❌ Delete Post: $e");
      Utils.showToast("Unexpected error occurred", true);
    } finally {
      isLoadingPosts.value = false;
    }
  }

  Future<void> GetAllPost() async {
    try {
      isLoadingPosts.value = true;

      String url = ApiEndPoints.createPost; // Replace with correct GET endpoint
      final responseData = await baseService.baseGetAPI(url);

      print("GET URL: $url");
      print("Response: $responseData");

      if (responseData["success"] != true) {
        Utils.showToast(
          responseData["message"] ?? "Something went wrong",
          true,
        );
        getAllPostModel.value = null;
        return;
      }

      // Parse response
      getAllPostModel.value = GetAllPostModel.fromJson(responseData);

      // ✅ IMPORTANT: Ensure refresh after parsing
      getAllPostModel.refresh();

      // Set profile picture
      if (getAllPostModel.value != null && getAllPostModel.value!.data!.isNotEmpty) {
        profilePic.value = getAllPostModel.value!.data![0].userId?.profilePicture ?? '';
      }

      print("✅ Total posts: ${getAllPostModel.value?.data?.length ?? 0}");

      // Debug: Print isLiked values
      getAllPostModel.value?.data?.asMap().forEach((index, post) {
        print("Post $index - isLiked: ${post.isLiked}");
      });

    } catch (e) {
      print("❌ GetAllPost() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      getAllPostModel.value = null;
    } finally {
      isLoadingPosts.value = false;
    }
  }

  Future<void> GetEventById(String id) async {
    try {
      isLoadingPosts.value = true;

      String url = ApiEndPoints.getEventById(id); // Replace with correct GET endpoint
      final responseData = await baseService.baseGetAPI(url);

      print("GET URL: $url");
      print("Response: $responseData");

      if (responseData["success"] != true) {
        Utils.showToast(
          responseData["message"] ?? "Something went wrong",
          true,
        );
        getEventByIdModel.value = null;
        return;
      }

      // Parse response
      getEventByIdModel.value = GetEventByIdModel.fromJson(responseData);

      // ✅ IMPORTANT: Ensure refresh after parsing
      getEventByIdModel.refresh();

      print("✅ Total posts: ${getEventByIdModel.value?.data}");

      // Debug: Print isLiked values


    } catch (e) {
      print("❌ Get Event By Id() ERROR: $e");
      Utils.showToast("Unexpected error occurred", true);
      getEventByIdModel.value = null;
    } finally {
      isLoadingPosts.value = false;
    }
  }

  Future<void> getAllEvents({
    String search = '',
    String category = '',
    int page = 1,
    int limit = 10,
    bool isLoadMore = false,
  }) async {
    try {
      if (!isLoadMore) {
        isLoadingEvents.value = true;
        eventsList.clear();
        currentPage.value = 1;
      }

      final url = ApiEndPoints.getAllEvents(
        search,
        category,
        page,
        limit,
      );

      print("📌 GET EVENTS URL: $url");

      final responseData = await baseService.baseGetAPI(url);

      if (responseData == null || responseData["success"] != true) {
        Utils.showToast(responseData?["message"] ?? "Failed to load events", true);
        return;
      }

      final model = GetAllEventModel.fromJson(responseData);
      getAllEventsModel.value = model;

      final newEvents = model.data?.events ?? [];

      if (isLoadMore) {
        eventsList.addAll(newEvents);
      } else {
        eventsList.assignAll(newEvents);
      }

      currentPage.value = model.data?.page ?? 1;
      totalPages.value = model.data?.totalPages ?? 1;

      print("✅ EVENTS LOADED: ${eventsList.length}");

    } catch (e) {
      print("❌ getAllEvents ERROR: $e");
      Utils.showToast("Something went wrong", true);
    } finally {
      isLoadingEvents.value = false;
    }
  }



  Future<bool> deleteComment(String postId, String commentId) async {
    try {
      // Call your base service
      final data = await baseService.baseDeleteAPI(
        ApiEndPoints.deleteComment(postId, commentId),
        loading: true,
      );

      // If data is a Map, check success
      if (data != null && data is Map<String, dynamic>) {

        return data['success'] == true;

      }


      print("Failed to delete comment. Response: $data");
      return false;
    } catch (e) {
      print("Error deleting comment: $e");
      return false;
    }
  }




  void clearPostFields() {
    postDescField.clear();
    selectedPostImage.value = null;
    canPost.value = false;
  }
}
