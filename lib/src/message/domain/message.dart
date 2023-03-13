import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/src/message/domain/message_type.dart';

class Message {
  const Message({
    required this.body,
    required this.dateTime,
    required this.messageType,
    required this.sentBy,
    required this.sentTo,
    this.read = false,
  });

  /// The body of the message.
  final String body;

  /// Sent or received date and time of message.
  final DateTime dateTime;

  /// Message type information.
  final MessageType messageType;

  /// Unique identifier of sender.
  final String sentBy;

  /// Unique identifier of receiver.
  final String sentTo;

  /// If the message read.
  final bool read;

  /// Factory that returns a [Message] class from [json] map.
  factory Message.fromJson(Map<String, dynamic> json) {
    final MessageType type = json['type'].toString() == 'text'
        ? MessageType.text
        : MessageType.image;
    return Message(
      body: json['body'] as String,
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      messageType: type,
      sentBy: json['sentBy'] as String,
      sentTo: json['sentTo'] as String,
      read: json['read'] as bool,
    );
  }

  /// Returns a dynamic map with data information.
  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'dateTime': dateTime,
      'type': messageType == MessageType.image ? 'image' : 'text',
      'sentBy': sentBy,
      'sentTo': sentTo,
      'read': read,
    };
  }
}
