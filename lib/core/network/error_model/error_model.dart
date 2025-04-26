import 'package:equatable/equatable.dart';

class NetworkErrorModel extends Equatable {
  final bool? success;
  final String? message;

  const NetworkErrorModel({this.success, this.message});

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) {
    return NetworkErrorModel(
      success: json['success'] ?? true,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };

  @override
  List<Object?> get props => [success, message];
}
