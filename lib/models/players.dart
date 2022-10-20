class Players {
  String nickname;
  String nama;
  String posisi;
  String tim;
  String liga;
  String negara_asal;
  String umur;

  Players({
    required this.nickname,
    required this.nama,
    required this.posisi,
    required this.tim,
    required this.liga,
    required this.negara_asal,
    required this.umur,
  });

  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
        nickname: json['nickname'],
        nama: json['nama'],
        posisi: json['posisi'],
        tim: json['tim'],
        liga: json['liga'],
        negara_asal: json['negara_asal'],
        umur: json['umur']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'nama': nama,
      'posisi': posisi,
      'tim': tim,
      'liga': liga,
      'negara_asal': negara_asal,
      'umur': umur,
    };
  }
}
