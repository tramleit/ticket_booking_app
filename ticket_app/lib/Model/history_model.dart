

class HistoryModel{

  String? id;
  String? idMovie;
  String? idSeat;
  String? datebuy;

  String? namemoive;
  String? imageasset;
  double? price;
  HistoryModel({this.id, this.idMovie, this.idSeat, this.datebuy, this.namemoive,
      this.imageasset, this.price});

  factory HistoryModel.fromJson(Map<String, dynamic> json){
    return HistoryModel(
      id: json['id'],
      idMovie: json['idMovie'],
      idSeat: json['idSeat'],

    );
  }
}