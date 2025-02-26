import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationMessage {
  final RemoteMessage message;

  NotificationMessage({
    required this.message,
  });

  String get title {
    String title = "";
    if (Platform.isIOS) {
      title = message.notification?.title ?? "";
      // title = IndexWalker(message.['aps']['alert']['title']).value as String;
    } else if (Platform.isAndroid) {
      title = message.notification?.title ?? "";
    }
    return title;
  }

  String get body {
    String body = "";

    if (Platform.isIOS) {
      body = message.notification?.body ?? "";
    } else if (Platform.isAndroid) {
      body = message.notification?.body ?? "";
    }
    return body;
  }

  String get type {
    String type = "";
    if (Platform.isIOS) {
      type = message.data['notification_type'] as String;
    } else if (Platform.isAndroid) {
      type = message.data['notification_type'] as String;
    }
    return type;
  }

  String get notifierId {
    String id = "";
    if (Platform.isIOS) {
      id = message.data['notifier_id'] as String;
    } else if (Platform.isAndroid) {
      id = message.data['notifier_id'] as String;
    }
    return id;
  }

  int get unreadCount {
    int count = 0;
    if (Platform.isIOS) {
      count = int.tryParse(message.data['badge_count']?.toString() ?? '') ?? 0;
    } else if (Platform.isAndroid) {
      count = int.tryParse(message.data['badge_count']?.toString() ?? '') ?? 0;
    }
    return count;
  }
}
