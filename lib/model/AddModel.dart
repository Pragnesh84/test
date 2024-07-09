/// q : "Today is plenty; right now is enough. Tomorrow will come in good time. Until it does, live the depth of now."
/// a : "Ralph Marston"
/// h : "<blockquote>&ldquo;Today is plenty; right now is enough. Tomorrow will come in good time. Until it does, live the depth of now.&rdquo; &mdash; <footer>Ralph Marston</footer></blockquote>"

class AddModel {
  AddModel({
    String? q,
    String? a,
    String? h,
  }) {
    _q = q;
    _a = a;
    _h = h;
  }

  AddModel.fromJson(dynamic json) {
    _q = json['q'];
    _a = json['a'];
    _h = json['h'];
  }
  String? _q;
  String? _a;
  String? _h;
  AddModel copyWith({
    String? q,
    String? a,
    String? h,
  }) =>
      AddModel(
        q: q ?? _q,
        a: a ?? _a,
        h: h ?? _h,
      );
  String? get q => _q;
  String? get a => _a;
  String? get h => _h;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['q'] = _q;
    map['a'] = _a;
    map['h'] = _h;
    return map;
  }
}
