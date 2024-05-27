import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/HomeCr.dart';
import 'create_post_view.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Search Page'),
    Text('Messages Page'),
    Text('Profile Page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('SOCIABLESPHERE'),
      ),
      body: Obx(() {
        return Center(
          child: controller.selectedIndex.value == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      controller.responseData.value,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => CreatePostView());
                      },
                      child: Text('Create Post'),
                    ),
                  ],
                )
              : _widgetOptions.elementAt(controller.selectedIndex.value),
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.blue,
          onTap: controller.onItemTapped,
        );
      }),
    );
  }
}
