class VersionDatamodel {
  bool? status;
  CurrentVersion? currentVersion;
  String? message;

  VersionDatamodel({this.status, this.currentVersion, this.message});

  VersionDatamodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currentVersion = json['current_version'] != null
        ? CurrentVersion.fromJson(json['current_version'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (currentVersion != null) {
      data['current_version'] = currentVersion!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class CurrentVersion {
  String? name;
  int? iosVersion;
  int? androidVersion;

  CurrentVersion({this.name, this.iosVersion, this.androidVersion});

  CurrentVersion.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iosVersion = json['ios_version'];
    androidVersion = json['android_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ios_version'] = iosVersion;
    data['android_version'] = androidVersion;
    return data;
  }
}
