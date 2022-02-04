import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(fit: StackFit.expand, children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/smiling-girl-studying-home_329181-18968.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(

                  child: Image(
                      height: 50,
                      width: 100,
                      image: NetworkImage(
                          'https://t3.ftcdn.net/jpg/02/29/72/42/240_F_229724257_PqBsyWDexqoqGlBsfxloizAYLPEd82aO.jpg')),
                ),
              ),
              // ),
            ]),
          )
        ],
      ),
    );
  }
}
