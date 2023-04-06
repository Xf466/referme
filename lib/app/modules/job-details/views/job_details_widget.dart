import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({required this.title, required this.desc, Key? key})
      : super(key: key);
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(desc)
        ],
      ),
    );
  }
}
