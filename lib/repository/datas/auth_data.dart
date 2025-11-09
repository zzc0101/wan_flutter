class AuthData {
  AuthData({
      bool? admin, 
      List<dynamic>? chapterTops, 
      num? coinCount, 
      List<dynamic>? collectIds, 
      String? email, 
      num? id, 
      String? nickname, 
      String? password, 
      String? publicName, 
      String? token, 
      num? type, 
      String? username,}){
    _admin = admin;
    _chapterTops = chapterTops;
    _coinCount = coinCount;
    _collectIds = collectIds;
    _email = email;
    _id = id;
    _nickname = nickname;
    _password = password;
    _publicName = publicName;
    _token = token;
    _type = type;
    _username = username;
}

  AuthData.fromJson(dynamic json) {
    _admin = json['admin'];
    if (json['chapterTops'] != null) {
      _chapterTops = [];
      json['chapterTops'].forEach((v) {
        _chapterTops?.add(v);
      });
    }
    _coinCount = json['coinCount'];
    if (json['collectIds'] != null) {
      _collectIds = [];
      json['collectIds'].forEach((v) {
        _collectIds?.add(v);
      });
    }
    _email = json['email'];
    _id = json['id'];
    _nickname = json['nickname'];
    _password = json['password'];
    _publicName = json['publicName'];
    _token = json['token'];
    _type = json['type'];
    _username = json['username'];
  }
  bool? _admin;
  List<dynamic>? _chapterTops;
  num? _coinCount;
  List<dynamic>? _collectIds;
  String? _email;
  num? _id;
  String? _nickname;
  String? _password;
  String? _publicName;
  String? _token;
  num? _type;
  String? _username;

  bool? get admin => _admin;
  List<dynamic>? get chapterTops => _chapterTops;
  num? get coinCount => _coinCount;
  List<dynamic>? get collectIds => _collectIds;
  String? get email => _email;
  num? get id => _id;
  String? get nickname => _nickname;
  String? get password => _password;
  String? get publicName => _publicName;
  String? get token => _token;
  num? get type => _type;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admin'] = _admin;
    if (_chapterTops != null) {
      map['chapterTops'] = _chapterTops?.map((v) => v.toJson()).toList();
    }
    map['coinCount'] = _coinCount;
    if (_collectIds != null) {
      map['collectIds'] = _collectIds?.map((v) => v.toJson()).toList();
    }
    map['email'] = _email;
    map['id'] = _id;
    map['nickname'] = _nickname;
    map['password'] = _password;
    map['publicName'] = _publicName;
    map['token'] = _token;
    map['type'] = _type;
    map['username'] = _username;
    return map;
  }
}