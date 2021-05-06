
class TrailerModel {
  int _id;
  List<_Result> _results = [];
  List<_Result> get results => _results;
  int get id => _id;

  //  not needed
  //TrailerModel({this.id, this._results});

  TrailerModel.fromJson(Map<String, dynamic> json) {
    print(json['results'].length);
    _id = json['id'];
    if (json['results'] != null) {

      json['results'].forEach((v) {
        _results.add(new _Result.fromJson(v));
      });
    }
  }
}

class _Result {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  _Result(
      {this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type});

  _Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}