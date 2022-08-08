import 'package:flutter/material.dart';

class PrimaryTaskItem extends StatelessWidget {
  final int index;

  const PrimaryTaskItem({
    Key? key,
    required this.index,
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
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: index %2 == 0 ? Colors.green : null,
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: index %2 == 0
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
            const Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
