import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardTodo extends StatelessWidget {
  const CardTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Learning Web Developer"),
                    subtitle: Text("Learning topic html and CSS"),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.blueGrey,
                        shape: const CircleBorder(),
                        value: true,
                        onChanged: (value) => print("object"),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -12),
                    child: Container(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Today'),
                      Gap(12),
                      Text('09:15 - 11:45'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
