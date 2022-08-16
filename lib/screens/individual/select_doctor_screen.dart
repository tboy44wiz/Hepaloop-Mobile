import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../routes/app_routes/app_route_names.dart';
import '../../services/socketIO_service.dart';
import '../../states/auth_state_controller.dart';
import '../../states/individual_state_controller.dart';
import '../../widgets/app_snackBar_widget.dart';

class SelectDoctorScreen extends StatelessWidget {
  SelectDoctorScreen({Key? key}) : super(key: key);

  final AppSnackBar _appSnackBar = AppSnackBar();
  final IndividualStateController _individualStateController = Get.find<IndividualStateController>();
  final AuthStateController _authStateController = Get.put(AuthStateController());
  final SocketIOServiceController _socketIOServiceController = Get.isRegistered<SocketIOServiceController>()
      ? Get.find<SocketIOServiceController>()
      : Get.put(SocketIOServiceController());

  final Map<String, dynamic> routerArgument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _individualStateController.getAllNearByDoctors();
      // _socketIOServiceController.createSocketConnection();
    });

    return Scaffold(

      //  App Bar
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        // backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        flexibleSpace: Container(
          height: 100.0,
          padding: const EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.black54,
                  icon: const Icon(Iconsax.arrow_left_2),
                  padding: const EdgeInsets.all(0.0),
                  iconSize: 24.0,
                ),
              ),
              const Text(
                "Choose Specialist",
                style: TextStyle(
                  color: Color(0xff19769F),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40.0,
                width: 40.0,
              ),
            ],
          ),
        ),
      ),

      //  Body.
      body: GetBuilder<IndividualStateController>(builder: (controller) {
          return BlurryModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                children: [
                  //  Welcome message with Avatar.
                  SizedBox(
                    height: 70.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Welcome,",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${routerArgument["name"]}",
                              style: const TextStyle(
                                color: Color(0xff19769F),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 55.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              color: Colors.blue,
                              image: DecorationImage(
                                // image: AssetImage("images/profile_avatar.png"),
                                image: (routerArgument["picture"] != null) ?
                                NetworkImage(routerArgument["picture"]) :
                                const AssetImage("images/profile_avatar.png") as ImageProvider,
                                fit: BoxFit.cover,
                              )),
                          child: null,
                        ),
                      ],
                    ),
                  ),

                  // Main Body ListView.
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          "Let's help find your medical solution.",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        //  Search Bar.
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Card(
                                elevation: 3.0,
                                margin: const EdgeInsets.only(right: 15.0),
                                shadowColor: Colors.white70.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(0.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "What can I search for you?",
                                      hintStyle: TextStyle(color: Colors.grey[400]),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14.0,
                                        horizontal: 15.0,
                                      ),
                                      suffixIcon: const Icon(
                                        Iconsax.search_normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //  Filter Button.
                            Container(
                              height: 45.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                gradient: const LinearGradient(
                                  colors: [Color(0xff19769F), Color(0xff35D8A6)],
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.document_filter,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0),

                        //  Specialist Card.
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Specialties",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Container(
                                height: 80.0,
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                                child: ListView.builder(
                                  itemCount: controller.doctorsSpecialtyList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.updateSelectedSpecialistIndex(index);
                                        controller.handleSpecialistItemClicked(controller.doctorsSpecialtyList[index]["name"]);
                                      },
                                      child: AnimatedContainer(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5.0,
                                          horizontal: 2.0,
                                        ),
                                        duration: const Duration(milliseconds: 500),
                                        child: Card(
                                          color: (controller.selectedSpecialistIndex == index) ? (
                                              Colors.greenAccent[100]
                                          ) : (
                                              Colors.white
                                          ),
                                          elevation: 5.0,
                                          shadowColor: Colors.grey.withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 48.0,
                                                  width: 44.0,
                                                  padding: const EdgeInsets.all(7.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    gradient: const LinearGradient(
                                                      colors: [Color(0xff19769F), Color(0xff35D8A6)],
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                    controller.doctorsSpecialtyList[index]["icon"],
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                                const Padding(padding: EdgeInsets.all(2.0)),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Text(controller.doctorsSpecialtyList[index]["name"] + "s"),
                                                    Text(controller.doctorsSpecialtyList[index]["number"].toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        //  Nearby Specialties.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Nearby Specialists',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              height: 170.0,
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                              child: ListView.builder(
                                itemCount: controller.nearbySpecialist.length,
                                // itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.extractSelectedDoctorsData(controller.nearbySpecialist[index]["id"]);
                                      Get.toNamed(doctorsDetailsAndRequestConsultationScreen);
                                    },
                                    child: Card(
                                      elevation: 5.0,
                                      shadowColor: Colors.grey.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13.0),
                                      ),
                                      child: Container(
                                        width: 120.0,
                                        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50.0,
                                              width: 50.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50.0),
                                                image: DecorationImage(
                                                    image: NetworkImage(controller.nearbySpecialist[index]["picture"]),
                                                    fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),

                                            const Padding(padding: EdgeInsets.all(5.0)),

                                            Text(
                                              "Dr ${controller.nearbySpecialist[index]["name"].split(" ")[0]}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 3.0),

                                            Text(
                                              (controller.nearbySpecialist.isNotEmpty) ? (
                                                  controller.nearbySpecialist[index]["specialty"]
                                              ) : (
                                                  "General Doctor"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
