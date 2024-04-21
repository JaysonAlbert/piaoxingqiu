class Pagination {
  final int count;
  final int offset;
  final int length;
  final bool countable;
  final int pageSize;
  final int total;
  final int pageNo;

  bool get hasNextPage => pageNo * pageSize < total;

  Pagination(
      {required this.count,
      required this.offset,
      required this.length,
      required this.countable,
      required this.pageSize,
      required this.total,
      required this.pageNo});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json['count'] as int,
      offset: json['offset'] as int,
      length: json['length'] as int,
      countable: json['countable'] as bool,
      pageSize: json['pageSize'] as int,
      total: json['total'] as int,
      pageNo: json['pageNo'] as int,
    );
  }
}
