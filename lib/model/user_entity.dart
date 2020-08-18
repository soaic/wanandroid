class UserEntity {
	String icon;
	bool admin;
	int type;
	String token;
	String password;
	String publicName;
	List<Null> chapterTops;
	String nickname;
	List<Null> collectIds;
	int id;
	String email;
	int coinCount;
	String username;

	UserEntity({this.icon, this.admin, this.type, this.token, this.password, this.publicName, this.chapterTops, this.nickname, this.collectIds, this.id, this.email, this.coinCount, this.username});

	UserEntity.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		admin = json['admin'];
		type = json['type'];
		token = json['token'];
		password = json['password'];
		publicName = json['publicName'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		nickname = json['nickname'];
		if (json['collectIds'] != null) {
			collectIds = new List<Null>();
		}
		id = json['id'];
		email = json['email'];
		coinCount = json['coinCount'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['admin'] = this.admin;
		data['type'] = this.type;
		data['token'] = this.token;
		data['password'] = this.password;
		data['publicName'] = this.publicName;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['nickname'] = this.nickname;
		if (this.collectIds != null) {
      data['collectIds'] =  [];
    }
		data['id'] = this.id;
		data['email'] = this.email;
		data['coinCount'] = this.coinCount;
		data['username'] = this.username;
		return data;
	}
}
