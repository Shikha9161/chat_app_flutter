class MsgData {
 late String msg;
  late String time;

  MsgData({required this.msg, required this.time});

  MsgData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['time'] = this.time;
    return data;
  }
}