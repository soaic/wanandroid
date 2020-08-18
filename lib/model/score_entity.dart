class ScoreEntity {
	int date;
	String reason;
	int id;
	int type;
	String userName;
	int userId;
	int coinCount;
	String desc;

	ScoreEntity({this.date, this.reason, this.id, this.type, this.userName, this.userId, this.coinCount, this.desc});

	ScoreEntity.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		reason = json['reason'];
		id = json['id'];
		type = json['type'];
		userName = json['userName'];
		userId = json['userId'];
		coinCount = json['coinCount'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['reason'] = this.reason;
		data['id'] = this.id;
		data['type'] = this.type;
		data['userName'] = this.userName;
		data['userId'] = this.userId;
		data['coinCount'] = this.coinCount;
		data['desc'] = this.desc;
		return data;
	}
}
