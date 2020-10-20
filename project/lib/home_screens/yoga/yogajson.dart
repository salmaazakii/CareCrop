
class Note {
  String sanskrit_name;
  String english_name;
  String img_url;

  Note(this.sanskrit_name, this.english_name,this.img_url);

  Note.fromJson(Map<String, dynamic> json) {
    sanskrit_name = json['sanskrit_name'];
    english_name = json['english_name'];
    img_url = json['img_url'];
  }
}