// ignore_for_file: file_names

class QuotesModel {
  String? q;
  String? a;

  QuotesModel({
    this.q,
    this.a,
  });

  QuotesModel.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    a = json['a'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = (<String, dynamic>{});
    data['q'] = q;
    data['a'] = a;

    return data;
  }
}
