import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text('Profil'),
                    floating: true,
                    snap: false,
                    expandedHeight: 200.0,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: Image.asset("assets/images/voiture.jpeg", scale: 1.0,),
                    stretch: true,
                  ),
                )
              ];
            },
            body: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                      SliverFillRemaining(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                            ],
                          )
                      )
                    ],
                  );
                }
            )
        )
    );
  }
}
