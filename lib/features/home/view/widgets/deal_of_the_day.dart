import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List list = [
    'https://images.unsplash.com/photo-1598327106026-d9521da673d1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8eGlhb21pfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1621330396167-b3d451b9b83b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8eGlhb21pfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1624434207310-94fc4a4394db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHhpYW9taXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1624434207310-94fc4a4394db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHhpYW9taXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1624434207310-94fc4a4394db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHhpYW9taXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1624434207310-94fc4a4394db?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHhpYW9taXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: const Text(
                  'Deal of the day',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Image.network(
                'https://images.unsplash.com/photo-1624434207284-727cf0e6ea8e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8eGlhb21pfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
                height: 235,
                fit: BoxFit.fitHeight,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: const Text(
                  '\$999',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Yacine',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: list
                      .map(
                        (e) => Image.network(
                          e,
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ).copyWith(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'See all deals',
                  style: TextStyle(
                    color: Colors.cyan[800],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
