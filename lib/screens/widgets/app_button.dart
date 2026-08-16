import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppButton extends StatelessWidget {
  final String name;
  final String imgPath;
  final String namePage;
  const AppButton({super.key, required this.name, required this.imgPath, required this.namePage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.r,
      height: 200.r,
      child: InkWell(
        onTap: () => context.push(namePage),
        child: Card(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(width: 200.r,height: 200.r,),
              Positioned(
                top: 0.r,
                child: Image.asset(imgPath,cacheHeight: 150,),
              ),
              Positioned(
                bottom: 0.r,
                child: Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
