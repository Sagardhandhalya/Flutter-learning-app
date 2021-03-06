import 'package:flutter/material.dart';
import '../../../constant.dart';

class CategoryList extends StatefulWidget {
  final Function changeCategory;
  const CategoryList({Key? key, required this.changeCategory})
      : super(key: key);
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<String> category = [
    'bags',
    'phone',
    'jewellery',
    'shoes',
    'clothes'
  ];

  int _selected = 0;

  Function changeCategory = () {};
  @override
  void initState() {
    super.initState();
    changeCategory = widget.changeCategory;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: buildCategory,
      ),
    );
  }

  Widget buildCategory(context, index) => GestureDetector(
        onTap: () {
          setState(() {
            _selected = index;
            changeCategory(category[index]);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(
              top: kDefaultPaddin, right: kDefaultPaddin, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category[index],
                style: const TextStyle(fontSize: 17, color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 40,
                color: index == _selected ? Colors.black87 : Colors.transparent,
              )
            ],
          ),
        ),
      );
}
