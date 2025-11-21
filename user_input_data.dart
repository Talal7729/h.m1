import 'package:flutter/material.dart'; 

class UserInputData {
		
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNo;
  final String? age;
  final String? gender;
  final String? country;
  final String? selectedDate;
  final String? selectedTime;
  final double? rating;
  final double? percentage;
  final String? priceRange;
  final bool? notifications;
  final bool? agreePolicy;
  
  UserInputData({
    this.fullName,
    this.email,
    this.password,
    this.phoneNo,
    this.age,
    this.gender,
    this.country,
    this.selectedDate,
    this.selectedTime,
    this.rating,
    this.percentage,
    this.priceRange,
    this.notifications,
    this.agreePolicy,
  });
}

