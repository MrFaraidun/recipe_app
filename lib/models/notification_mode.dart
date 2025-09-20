class NotificationModel {
  final String id;
  final String name;
  final String action;
  final String time;
  final String imageUrl;
  final bool isFollowed;
  final String? thumbnailUrl;

  NotificationModel({
    required this.id,
    required this.name,
    required this.action,
    required this.time,
    required this.imageUrl,
    required this.isFollowed,
    this.thumbnailUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      name: json['name'],
      action: json['action'],
      time: json['time'],
      imageUrl: json['imageUrl'],
      isFollowed: json['isFollowed'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}


