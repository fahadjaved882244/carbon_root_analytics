import 'package:carbon_root_analytics/utils/core/result.dart';
import 'package:flutter/widgets.dart';

@immutable
class Company {
  final String userId;
  final String id;
  final String name;
  final String industry;
  final int numberOfEmployees;
  final String location;
  final DateTime lastUpdated;

  const Company({
    required this.userId,
    required this.id,
    required this.name,
    required this.industry,
    required this.numberOfEmployees,
    required this.location,
    required this.lastUpdated,
  });

  static Result<Company> fromMap(Map<String, dynamic> map) {
    // return error if any of the fields are missing
    if (!map.containsKey('userId') ||
        !map.containsKey('id') ||
        !map.containsKey('name') ||
        !map.containsKey('industry') ||
        !map.containsKey('numberOfEmployees') ||
        !map.containsKey('location') ||
        !map.containsKey('lastUpdated')) {
      return Result.error(Exception('Missing required fields'));
    }
    // return error if any of the fields are of the wrong type
    if (map['userId'] is! String ||
        map['id'] is! String ||
        map['name'] is! String ||
        map['industry'] is! String ||
        map['numberOfEmployees'] is! int ||
        map['location'] is! String ||
        map['lastUpdated'] is! String) {
      return Result.error(Exception('Invalid field type'));
    }

    // return error if can not parse date
    final lastUpdated = DateTime.tryParse(map['lastUpdated']);
    if (lastUpdated == null) {
      return Result.error(Exception('Invalid date format'));
    }

    // return company object
    return Result.ok(
      Company(
        userId: map['userId'],
        id: map['id'],
        name: map['name'],
        industry: map['industry'],
        numberOfEmployees: map['numberOfEmployees'],
        location: map['location'],
        lastUpdated: lastUpdated,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'name': name,
      'industry': industry,
      'numberOfEmployees': numberOfEmployees,
      'location': location,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
