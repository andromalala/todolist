import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/utils/theme.dart';
import 'package:to_do_list/app/domain/entities/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.grey[400] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset.fromDirection(5.0)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: CustomTheme.primaryColor),
                  borderRadius: BorderRadius.circular(4),
                  color: task.isCompleted
                      ? CustomTheme.primaryColor
                      : Colors.transparent,
                ),
                child: task.isCompleted
                    ? const Icon(Icons.check, size: 20, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomTheme.primaryColor,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      'Créé le: ${DateFormat('dd/MM/yyyy à HH:mm').format(task.createdAt)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: CustomTheme.primaryColor,
                  size: 30,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
