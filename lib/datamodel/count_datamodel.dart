class CountDatamodel {
  bool? status;
  Counts? counts;
  String? message;

  CountDatamodel({this.status, this.counts, this.message});

  CountDatamodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    counts =
        json['counts'] != null ? new Counts.fromJson(json['counts']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.counts != null) {
      data['counts'] = this.counts!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Counts {
  int? pending;
  int? inProgress;
  int? completed;

  Counts({this.pending, this.inProgress, this.completed});

  Counts.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    inProgress = json['in_progress'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['in_progress'] = this.inProgress;
    data['completed'] = this.completed;
    return data;
  }
}
