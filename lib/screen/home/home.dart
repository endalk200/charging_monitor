import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Body(),
        );
    }
}


class Body extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

        return Background(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        SvgPicture.asset(
                            "assets/icons/battery.svg",
                            color: Colors.green,
                            height: size.height * 0.1,
                        ),
                        Text(
                            "CHARGING MONITOR",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                        ),
                        SizedBox(height: size.height * 0.009),
                        Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
                            child: Text(
                                "lorem ipsum this is it which can diversify. lorem ipsum this is it which can diversify lorem ipsum this is it which can diversify",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}

class Background extends StatelessWidget {
    final Widget child;
    const Background({
        Key? key,
        required this.child,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

        return Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                            "assets/images/main_top.png",
                            width: size.width * 0.3,
                        ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Image.asset(
                            "assets/images/main_bottom.png",
                            width: size.width * 0.2,
                        ),
                    ),
                    child,
                ],
            ),
        );
    }
}