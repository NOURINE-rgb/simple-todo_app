import 'package:flutter/material.dart';
import 'package:todo/data/dummy_data.dart';

class DateNow extends StatelessWidget {
  const DateNow({super.key});
  @override
  Widget build(BuildContext context) {
    const arr = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final nowTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        elevation: 2,
        margin: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    for(final e in listImportance)
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          e.name,
                          style: const TextStyle(color: Colors.white, fontSize: 16,),
                        ),
                       const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.discount,
                          color: e.color,
                          size: 18,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Spacer(),
            // hna ghadi nzid the data li rana fiha
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                children: [
                  Text(
                    nowTime.day.toString(),
                    style: const TextStyle(fontSize: 58, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arr[nowTime.month - 1],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        nowTime.year.toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
