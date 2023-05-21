import 'package:flutter/material.dart';
import 'package:fluttertwo/app_theme.dart';
import 'package:provider/provider.dart';

class PromtPage extends StatefulWidget {
  const PromtPage({Key? key}) : super(key: key);

  @override
  State<PromtPage> createState() => _PromtPageState();
}

class _PromtPageState extends State<PromtPage> {

  @override

  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/assets/wp.jpeg'),fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 40,height: 40,padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,size: 18,color: Colors.black,
                      ),
                    ),
                    ),
                    Text('     ',style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),

                    Container(width: 40,height: 40,padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.favorite,size: 18,color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
              Align(alignment: Alignment.bottomCenter,child: Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),padding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),width:
                MediaQuery.of(context).size.width,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3),borderRadius: BorderRadius.circular(6),boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    offset: Offset(2,0),
                    blurRadius: 16,
                  ),
              ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Panda',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                      Icon(Icons.favorite,color: Colors.redAccent,size: 24,),
                      SizedBox(height: 18,),
                      Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),
                      Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),   Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),   Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),   Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),   Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),   Text('PPASDASDASDASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD'
                          'ASDASDASDASDASDASD ',style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 18,)


                    ],
                  ),
                ],
              ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
