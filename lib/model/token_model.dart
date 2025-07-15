class TokenModel {
  String? token;
  String? appId;
  String? uid;
  String? channelName;

  TokenModel({this.token, this.appId, this.uid, this.channelName});

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    appId = json['appId'];
    uid = json['uid'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['appId'] = this.appId;
    data['uid'] = this.uid;
    data['channelName'] = this.channelName;
    return data;
  }
}
