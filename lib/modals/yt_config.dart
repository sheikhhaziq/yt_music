class YTConfig {
  YTConfig({
    required this.visitorData,
    required this.language,
    required this.location,
    required this.apiKey,
    required this.clientName,
    required this.clientVersion,
  });
  String visitorData;
  String language;
  String location;
  String apiKey;
  String clientName;
  String clientVersion;

  YTConfig copyWith({
    String? visitorData,
    String? language,
    String? location,
    String? apiKey,
    String? clientName,
    String? clientVersion,
  }) => YTConfig(
    visitorData: visitorData ?? this.visitorData,
    language: language ?? this.language,
    location: location ?? this.location,
    apiKey: apiKey ?? this.apiKey,
    clientName: clientName ?? this.clientName,
    clientVersion: clientVersion ?? this.clientVersion,
  );

  factory YTConfig.fromJson(Map<String, dynamic> json) => YTConfig(
    visitorData: json['visitorData'],
    language: json['language'],
    location: json['location'],
    apiKey: json['apiKey'],
    clientName: json['clientName'],
    clientVersion: json['clientVersion'],
  );

  Map<String, dynamic> toJson() => {
    'visitorData': visitorData,
    'language': language,
    'location': location,
    'apiKey': apiKey,
    'clientName': clientName,
    'clientVersion': clientVersion,
  };
}
