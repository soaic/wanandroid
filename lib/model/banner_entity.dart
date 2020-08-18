class BannerEntity{
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerEntity.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        imagePath = json['imagePath'],
        id = json['id'],
        title = json['title'],
        isVisible = json['isVisible'],
        type = json['type'],
        url = json['url'],
        order = json['order'];

  Map<String, dynamic> toJson() => {
    'desc': desc,
    'imagePath': imagePath,
    'id': id,
    'title': title,
    'isVisible': isVisible,
    'type': type,
    'url': url,
    'order': order,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"desc\":\"$desc\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write(",\"id\":$id");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"isVisible\":\"$isVisible\"");
    sb.write(",\"type\":\"$type\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"order\":\"$order\"");
    sb.write('}');
    return sb.toString();
  }
}