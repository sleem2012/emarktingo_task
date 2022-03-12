import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/screen_utility.dart';
import '../themes/themes.dart';
import '../utlis/helper.dart';
import '../utlis/size_config.dart';

class ModalBottomSheet extends ConsumerStatefulWidget {
  final String name;
  final List list;

  final ValueChanged? onChange;

  const ModalBottomSheet({
    Key? key,
    required this.name,
    required this.list,
    this.onChange,
  }) : super(key: key);

  @override
  CustomBottomSheetState createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends ConsumerState<ModalBottomSheet> {
  String? selectedLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            builder: (_) {
              return ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            pop();
                            setState(() {
                              selectedLabel = widget.list[i].name;
                            });
                            if (widget.onChange != null) {
                              widget.onChange!(widget.list[i].id);
                            }
                          },
                          child: Center(
                            child: Text(
                              widget.list[i].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: MainTheme.productTextFont),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  });
            });
      },
      child:
      Container(
        height: SizeConfig.screenHeight * 0.07,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(width: 1, color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                selectedLabel ?? widget.name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontFamily: MainTheme.productTextFont,
                ),
              ),
            ),
            if (selectedLabel == null)
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.screenWidth * .67),
                child: const Icon(Icons.keyboard_arrow_down),
              )
          ],
        ),
      ),
    );
  }
}
