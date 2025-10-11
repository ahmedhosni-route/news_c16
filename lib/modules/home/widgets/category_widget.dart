import 'package:flutter/material.dart';
import 'package:news/core/categories/categories.dart';
import 'package:news/main.dart';
import 'package:news/modules/home/pages/news_screen.dart';

import '../../../core/theme/app_colors.dart';

class CategoryWidget extends StatefulWidget {
  Category category;
  bool isLeft;
  Function(Category value) onNav;
  CategoryWidget({
    super.key,
    required this.category,
    required this.isLeft,
    required this.onNav,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Offset offset = const Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Row(
        textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.category.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.category.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (widget.isLeft) {
                        if (offset.dx <= 0) {
                          offset += details.delta;
                          if (offset.dx <= -70) {
                            offset = const Offset(-70, 0);
                          }
                        }
                      } else {
                        if (offset.dx >= 0) {
                          offset += details.delta;
                          if (offset.dx >= 70) {
                            offset = const Offset(70, 0);
                          }
                        }
                      }
                      setState(() {});
                    },
                    onHorizontalDragEnd: (details) {
                      if(offset.dx > -60 || offset.dx < 60){
                        widget.onNav(widget.category);
                      }
                      offset = const Offset(0, 0);
                      setState(() {});
                    },
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: AppColors.black.withOpacity(0.6)),
                      child: Row(
                        textDirection: widget.isLeft
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "View All",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Transform.translate(
                            offset: offset,
                            child: CircleAvatar(
                              backgroundColor: AppColors.black,
                              radius: 28,
                              child: Icon(
                                widget.isLeft
                                    ? Icons.arrow_back_ios_new
                                    : Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
