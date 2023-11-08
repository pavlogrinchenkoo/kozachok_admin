import 'package:flutter/material.dart';
import 'package:kozachok_admin/style.dart';
import 'package:kozachok_admin/widgets/spaces.dart';

class CustomSideBar extends StatelessWidget {
  final int? currentIndex;
  final void Function(int, {bool notify})? onTap;

  CustomSideBar({required this.currentIndex, required this.onTap, super.key});

  final items = [
    'Shows',
    'Events',
    'Offered guests',
    'Bugs',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      color: BC.primary,
      padding: const EdgeInsets.only(top: 32, left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // const ListenerThatRunsFunctionsWithBuildContext(),
        Text('KOZACHOK : ADMIN', style: BS.med20.apply(color: BC.white)),
        Space.h32,
        Container(
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: BC.white, width: 5))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (int i = 0, length = items.length; i < length; i++)
                InkWell(
                    onTap: onTap != null ? () => onTap!(i) : () => {},
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: currentIndex == i
                                        ? BC.white
                                        : Colors.transparent,
                                    width: 1))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(items[i],
                                style: BS.med20.apply(color: BC.white)),
                          ],
                        ))),
              // InkWell(
              //     onTap: () => _request.logout(),
              //     child: Container(
              //         margin: const EdgeInsets.symmetric(vertical: 6),
              //         decoration: const BoxDecoration(
              //             border: Border(
              //                 bottom: BorderSide(
              //                     color: Colors.transparent, width: 1))),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Icon(Icons.logout, color: BC.white),
              //             Space.w8,
              //             Text('Logout',
              //                 style: BS.med20.apply(color: BC.white)),
              //           ],
              //         )))
            ]))
      ]),
    );
  }
}
