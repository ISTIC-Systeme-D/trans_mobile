class Artist {
  final String datasetid;
  final Map<dynamic, dynamic> fields;
  final String record_timestamp;
  final String recordid;

  Artist(
      {required this.datasetid,
      required this.fields,
      required this.record_timestamp,
      required this.recordid});

  factory Artist.fromRTDB(Map<String, dynamic> data) {
    return Artist(
      datasetid: data['datasetid'] ?? 'NID',
      fields: data['fields'],
      record_timestamp: data['record_timestamp'] ?? '?',
      recordid: data['recordid'] ?? 'NID',
    );
  }
}
