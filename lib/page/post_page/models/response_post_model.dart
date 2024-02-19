class ResponsePostModel {
  bool? success;
  String? errorMessage;
  String? title;
  String? body;
  int? userId;
  int? id;

  ResponsePostModel({this.success,this.errorMessage, this.title, this.body, this.userId, this.id,});

  ResponsePostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }

  @override
  String toString() {
    return 'ResponsePostModel(success: $success, errorMessage: $errorMessage, title: $title, body: $body, userId: $userId, id: $id)';
  }

  ResponsePostModel copyWith({
    bool? success,
    String? errorMessage,
    String? title,
    String? body,
    int? userId,
    int? id,
  }) {
    return ResponsePostModel(
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }
}
