class Response<T> {
  final int statusCode;
  final String comments;
  final String? errorCode;
  final T? data;

  Response(
      {required this.statusCode,
      required this.comments,
      required this.errorCode,
      required this.data});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        statusCode: json['statusCode'],
        comments: json['comments'],
        errorCode: json['errorCode'],
        data: json['data'],
      );
}
