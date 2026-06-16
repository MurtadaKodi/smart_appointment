import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  State<ServiceCard> createState() =>
      _ServiceCardState();
}

class _ServiceCardState
    extends State<ServiceCard> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        transform:
            Matrix4.identity()
              // ignore: deprecated_member_use
              ..scale(
                isHovered
                    ? 1.03
                    : 1.0,
              ),

        child: Card(

          shadowColor:
              Colors.black26,

          elevation:
              isHovered
                  ? 14
                  : 6,

          clipBehavior:
              Clip.antiAlias,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),

          child: InkWell(
            onTap: widget.onTap,

            child: Column(
              children: [

                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage:
                          AssetImage(
                        widget.image,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(
                    12,
                  ),

                  child: Text(
                    widget.name,

                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}