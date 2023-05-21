import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: Column(
          children: [
            SizedBox(height: 32,),
            InfoCard(name: 'Ali Tas',profession: 'Ogrenci',),
            ListTile(
              leading: SizedBox(
                height: 33,
                width: 33,
                child: Icon(Icons.assignment_ind_rounded),

              ),
              title: Text("Signup",style: TextStyle(color: Colors.white
              ),),
            ),
            ListTile(
              leading: SizedBox(
                height: 33,
                width: 33,
                child: Icon(Icons.assignment_ind_rounded),

              ),
              title: Text("Signup",style: TextStyle(color: Colors.white
              ),),
            ),

          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,required this.name,required this.profession,
  });

final String name,profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person,
          color: Colors.white,

        ),
      ),
      title: Text(name,style: TextStyle(
        color: Colors.white
      ),),
      subtitle: Text(profession,style: TextStyle(color: Colors.white),),

    );
  }
}
