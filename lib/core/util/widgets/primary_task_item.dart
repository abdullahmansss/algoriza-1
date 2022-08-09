import 'package:flutter/material.dart';
import 'package:test1/core/models/task_model.dart';
import 'package:test1/core/util/blocs/app/cubit.dart';

class PrimaryTaskItem extends StatelessWidget {
  final TaskModel task;

  const PrimaryTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                AppBloc.get(context).updateCompleteTask(task.id);
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: task.completed == 1
                      ? AppBloc.get(context).taskColors[task.color]
                      : null,
                  border: Border.all(
                    color: AppBloc.get(context).taskColors[task.color],
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: task.completed == 1
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30.0,
                      )
                    : Container(),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                AppBloc.get(context).updateFavoriteTask(task.id);
              },
              icon: Icon(
                task.favorite == 1
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: AppBloc.get(context).taskColors[task.color],
              ),
            )
          ],
        ),
      ),
    );
  }
}
