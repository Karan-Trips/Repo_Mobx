class UserData {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<Datum> data;
  final Support support;

  UserData({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        page: json["page"] ?? 0,
        perPage: json["per_page"] ?? 0,
        total: json["total"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };
}

class Datum {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  final String url;
  final String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}

class UserSave {
  final String email;
  final String password;

  UserSave({
    required this.email,
    required this.password,
  });

  factory UserSave.fromJson(Map<String, dynamic> json) => UserSave(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class SaveJob {
  final String name;
  final String job;

  SaveJob({required this.name, required this.job});

  factory SaveJob.toJson(Map<String, dynamic> json) => SaveJob(
        name: json["name"],
        job: json["job"],
      );
}
