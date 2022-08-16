import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../services/socketIO_service.dart';
import '../../states/individual_state_controller.dart';
import '../../states/notification_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';
import '../../widgets/show_more_option_bottom_sheet.dart';
import '../../screens/individual/individuals_dashboard_screen.dart';
import '../../screens/individual/individuals_home_screen.dart';
import '../../screens/individual/individuals_appointments_list_screen.dart';

class IndividualsMainScreen extends StatelessWidget {
  IndividualsMainScreen({Key? key}) : super(key: key);

  final IndividualStateController _individualStateController = Get.put(IndividualStateController());
  final SocketIOServiceController _socketIOServiceController = Get.put(SocketIOServiceController());
  final NotificationStateController _notificationStateController = Get.find<NotificationStateController>();
  final AppSnackBar _appSnackBar = AppSnackBar();


  final List<Widget> individualsWidgetScreensList = [
    IndividualsHomeScreen(),
    const IndividualsDashBoardScreen(),
    IndividualsAppointmentListScreen(true),
  ];

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // _individualStateController.getIndividualDetails();
      _socketIOServiceController.createSocketConnection();
      _notificationStateController.getAllNotificationsFromSQFLiteDatabase();
    });

    return Scaffold(

      //  Body.
      body: DoubleBackToCloseApp(
        snackBar: _appSnackBar.snackBar('Tap back again to exit the app.', 'Info'),
        child: GetBuilder<IndividualStateController>(builder: (controller) {
          return individualsWidgetScreensList[controller.selectedBottomNavigationBarIndex];
        }),
      ),


      //  Bottom Navigation Bar.
      bottomNavigationBar: GetBuilder<IndividualStateController>(builder: (controller) {
        return BottomAppBar(
          child: SizedBox(
            height: 60.0,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //  Home
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(0);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.home,
                        color: (controller.selectedBottomNavigationBarIndex == 0) ?
                        Colors.teal :
                        Colors.grey,
                      ),
                      const SizedBox(height: 2.0),

                      Text(
                        "Home",
                        style: TextStyle(
                            color: (controller.selectedBottomNavigationBarIndex == 0) ?
                            Colors.teal :
                            Colors.grey,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                //  Dashboard
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(1);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.element_3, size: 24.0,
                        color: (controller.selectedBottomNavigationBarIndex == 1) ?
                        Colors.teal :
                        Colors.grey,
                      ),
                      const SizedBox(height: 2.0),

                      Text(
                        "Dashboard",
                        style: TextStyle(
                            color: (controller.selectedBottomNavigationBarIndex == 1) ?
                            Colors.teal :
                            Colors.grey,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                //  Schedules
                TextButton(
                  onPressed: () {
                    controller.updateSelectedBottomNavigationBarIndex(2);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.calendar,
                        color: (controller.selectedBottomNavigationBarIndex == 2) ?
                        Colors.teal :
                        Colors.grey,
                      ),
                      const SizedBox(height: 2.0),

                      Text(
                        "Appointments",
                        style: TextStyle(
                            color: (controller.selectedBottomNavigationBarIndex == 2) ?
                            Colors.teal :
                            Colors.grey,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),

                //  More
                TextButton(
                  onPressed: () {
                    ShowMoreOptionBottomSheet.showMoreOptionBottomSheet("Individual");
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.more_vert,
                        color: (controller.selectedBottomNavigationBarIndex == 3) ?
                        Colors.teal :
                        Colors.grey,
                      ),
                      const SizedBox(height: 2.0),

                      Text(
                        "More",
                        style: TextStyle(
                            color: (controller.selectedBottomNavigationBarIndex == 3) ?
                            Colors.teal :
                            Colors.grey,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
