class Loader {
  bool initial;
  bool common;

  bool get loader => initial == true || common == true;

  Loader({required this.initial, required this.common});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['initial'] = initial;
    map['common'] = common;
    return map;
  }
}
