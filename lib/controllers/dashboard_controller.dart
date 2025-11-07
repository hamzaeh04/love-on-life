import 'package:get/get.dart';

class DashboardController extends GetxController{
   RxInt discoverIndex = 0.obs;
   var selectedIndex = 0.obs;
   RxBool isHomePage = false.obs;
// Map to track favorite state by index
  RxMap<int, bool> favoriteStatus = <int, bool>{}.obs;

  // Toggle the favorite state (index can be null)
  void toggleFavorite(int? index) {
    if (index == null) return; // if no index, ignore safely
    favoriteStatus[index] = !(favoriteStatus[index] ?? false);
  }

  // Check if a specific index is favorite
  bool isFavorite(int? index) {
    if (index == null) return false; // default false if no index
    return favoriteStatus[index] ?? false;
  }



   final List<String> discoverList = [
    "All",
    "Educational",
    "Music",
    "Buisness",
    "Motivational",
  ];
   final List<String> ticketList = [
     "Leadership skills",
     "Business Conference",
     "Album Release",
     "Future Consultation",
     "Youth Education"
   ];
   final List<String> options = ["Pending", "Approved", "Rejected"];
   final List<Map<String, dynamic>> events = [
     {
       "imagePath": 'assets/png/discover1.jpeg',
       "eventName": 'Young Education Program',
       "description":
       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
       "date": '10 Sep, 2025',
       "time": '12:00 AM',
       "ticketPrice": '\$40',
       "tag": "Educational",
       "noOfPeople": "25 people attending",
       "ticketsLeft": '7 Tickets left',
     },
     {
       "imagePath": 'assets/png/event_detail_icon/people.png',
       "eventName": 'Young Education Program',
       "description":
       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
       "date": '10 Sep, 2025',
       "time": '12:00 AM',
       "ticketPrice": '\$40',
       "tag": "Educational",
       "noOfPeople": "25 people attending",
       "ticketsLeft": '7 Tickets left',
     },
     {
       "imagePath": 'assets/png/event_detail_icon/people.png',
       "eventName": 'Young Education Program',
       "description":
       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
       "date": '10 Sep, 2025',
       "time": '12:00 AM',
       "ticketPrice": '\$40',
       "tag": "Educational",
       "noOfPeople": "25 people attending",
       "ticketsLeft": '7 Tickets left',
     },
     {
       "imagePath": 'assets/png/event_detail_icon/people.png',
       "eventName": 'Young Education Program',
       "description":
       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium.',
       "date": '10 Sep, 2025',
       "time": '12:00 AM',
       "ticketPrice": '\$40',
       "tag": "Educational",
       "noOfPeople": "25 people attending",
       "ticketsLeft": '7 Tickets left',
     },
   ];

   void switchDiscoverTab(int index){
    discoverIndex.value = index;
  }

}
