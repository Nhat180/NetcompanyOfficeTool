import 'package:flutter/material.dart';

class ProfileListItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onClickedListener;

  const ProfileListItem({
    required this.icon,
    required this.text,
    this.hasNavigation = true,
    required this.onClickedListener
  });

  @override
  State<StatefulWidget> createState() => ProfileListItemState();
}

class ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClickedListener();
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              size: 25,
            ),
            const SizedBox(width: 15),
            Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"
              ),
            ),
            const Spacer(),
            if (widget.hasNavigation)
              const Icon(
                Icons.arrow_right,
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}
