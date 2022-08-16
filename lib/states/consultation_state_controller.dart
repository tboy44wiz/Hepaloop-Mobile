import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../routes/api_routes/api_route_names.dart';
import '../../services/api_service.dart';
import '../models/consultation_model.dart';
import 'doctor_state_controller.dart';
import 'notification_state_controller.dart';

class ConsultationStateController extends GetxController {

  final DoctorStateController _doctorStateController = Get.find<DoctorStateController>();
  final NotificationStateController _notificationStateController = Get.isRegistered<NotificationStateController>()
      ? Get.find<NotificationStateController>()
      : Get.put(NotificationStateController());

  bool _isLoading = false;
  Map<String, dynamic>? _consultationSender;
  Consultation _consultation = Consultation();

  //
  /*
  * GETTERS
  * */
  bool get isLoading => _isLoading;
  Consultation get consultation => _consultation;
  Map<String, dynamic>? get consultationSender => _consultationSender;


  //
  /*
  * SETTERS
  * */
  void updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }
  void updateConsultationSender(Map<String, dynamic> consultationSenderValue) {
    _consultationSender = consultationSenderValue;
    update();
  }
  void updateConsultation(Consultation consultationValue) {
    _consultation = consultationValue;
    update();
  }


  /*
  * Get Single Consultation Request.
  * */
  Future<void> getSingleConsultationRequest(String id, String token) async {
    updateIsLoading(true);

    var response = await APIService.getSingleConsultationService(getSingleConsultationRoute, id, token);

    bool isSuccess = response!.data['success'];
    if (isSuccess) {
      var _consultationData = response.data["data"];
      Consultation consultation = Consultation.fromMap(_consultationData);
      updateConsultation(consultation);

      var senderId = consultation.senderId;
      if (senderId != null) {
        var senderResponse = await APIService.getSingleUser(getSingleUserRoute, senderId);

        bool isSuccess2 = senderResponse!.data['success'];
        Map<String, dynamic> consultationSenderData = senderResponse.data["data"];
        updateConsultationSender(consultationSenderData);

        return updateIsLoading(false);
      }
    } else {
      updateIsLoading(false);
    }


    // Consultation consultation = Consultation.fromJson(consultationData);
    // if (isSuccess) {
    //   updateConsultation(consultation);
    // }
  }


  /*
  * Accept Consultation Request.
  * */
  Future<void> updateConsultationRequest(String status) async {
    try {
      Map<String, dynamic> acceptConsultationData = {
        "status": status
      };
      var token = _doctorStateController.doctor.token;

      var response = await APIService.updateConsultationService(updateConsultationRoute, consultation.id!, acceptConsultationData, token!);

      bool isSuccess = response!.data['success'];
      if (isSuccess) {
        print("FFFFFF::: $response");
        String responseMessage = response.data["message"];

        //  Create a Notification.
        _notificationStateController.createNotificationContents(
            DateTime.now().millisecondsSinceEpoch.remainder(100000),
            'consultation_notification_key',
            'Request Accepted',
            responseMessage,
            "http://192.168.0.143:5000/uploads/avatar_1646303762323_profile_photo.jpg",
            NotificationLayout.BigPicture
        );
      }

    } catch(error) {
      print("ERROR::: $error");
    }

  }
}