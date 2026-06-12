import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String image;

  const ServiceCard({
  super.key,
  required this.name,
  required this.image,
  required this.onTap,
});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black26,
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
   Container(
     decoration: BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  ),
     child: CircleAvatar(
       radius: 115,
       backgroundColor:
        Theme.of(context).colorScheme.primary,
       child: CircleAvatar(
      radius: 110,
      backgroundImage: AssetImage(image),
       ),
     ),
   ),

    const SizedBox(height: 24),

    Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
      ),
    );
  }
}