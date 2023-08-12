import 'package:flutter/material.dart';

class Category {
  final String image;
  final String title;
  final color;

  Category(this.image, this.title, this.color);
}

List<Category> categoryList = [
  Category('assets/icons/coffee.png', '카페', Colors.deepOrangeAccent),
  Category('assets/icons/food.png', '맛집', Colors.grey),
  Category('assets/icons/alcohol.png', '알콜', Colors.blueAccent),
  Category('assets/icons/ball.png', '운동장', Colors.black54),
  Category('assets/icons/hospital.png', '동물병원', Colors.green),
];

List<String> tabCategoryList = ['All', '카페', '맛집', '알콜', '운동장', '동물병원'];
