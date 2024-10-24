class DataModel {
  String label;
  String value;
  int valueInt;
  String icon;

  DataModel({this.label = '', this.value = '', this.valueInt = 0, this.icon = ''});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    map['valueInt'] = valueInt;
    map['icon'] = icon;
    return map;
  }
}

List<DataModel> CHAT_SUGGESTIONS = [
  DataModel(label: 'Hi, Are you there?', value: 'Hi, Are you there?'),
  DataModel(label: 'I want to reschedule', value: 'I want to reschedule'),
  DataModel(label: 'Any discount available?', value: 'Any discount available?'),
  DataModel(label: 'Please share your location', value: 'Please share your location'),
];
