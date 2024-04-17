class HttpResponseModel {
	String? type;
	String? message;
	dynamic data;

	HttpResponseModel({this.type, this.message, this.data});

	HttpResponseModel.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		message = json['message'];
		data = json['data'];
	}

	Map<String, dynamic> toJson() {
		data['type'] = type;
		data['message'] = message;
    data['data'] = data;
		return data;
	}
}

