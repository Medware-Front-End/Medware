import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class PushNotification {
  static final _noti = FlutterLocalNotificationsPlugin();
  static final _onNoti = BehaviorSubject<String?>();

  static Future init() async {
    final androidInitSetting =
        AndroidInitializationSettings('@drawable/event_available');

    final iOSInitSetting = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );

    final initSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iOSInitSetting,
    );

    await _noti.initialize(
      initSetting,
      // onDidReceiveBackgroundNotificationResponse: () => NotificationResponse(
      //   notificationResponseType:
      //       NotificationResponseType.selectedNotificationAction,
      // ),
    );
  }

  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async =>
      _noti.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'main',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: payload,
      );

  static Future log({
    required int id,
    required int type,
    required String title,
    required String body,
    required int appointmentId,
    required DateTime dateCreated,
  }) async =>
      {};
}
