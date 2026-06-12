class BookingModel {
  final String id;

  final String providerId;
  final String providerName;

  final String customerName;
  final String email;
  final String phone;

  final String notes;

  final DateTime date;
  final String time;

  BookingModel({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.customerName,
    required this.email,
    required this.phone,
    required this.notes,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'providerId': providerId,
      'providerName': providerName,
      'customerName': customerName,
      'email': email,
      'phone': phone,
      'notes': notes,
      'date': date.toIso8601String(),
      'time': time,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      providerId: json['providerId'],
      providerName: json['providerName'],
      customerName: json['customerName'],
      email: json['email'],
      phone: json['phone'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
      time: json['time'],
    );
  }
}