import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import '../models/category.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final Category category;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat('HH:mm').format(activity.startTime);
    final endTime = activity.endTime != null
        ? DateFormat('HH:mm').format(activity.endTime!)
        : 'ongoing';
    final duration = activity.elapsedMinutes;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 12,
          decoration: BoxDecoration(
            color: category.colorValue,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        title: Text(category.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('$startTime - $endTime'),
            if (activity.memo != null && activity.memo!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  activity.memo!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        trailing: Text(
          '$duration min',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
