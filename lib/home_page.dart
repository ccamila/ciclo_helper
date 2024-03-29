import 'package:ciclo_helper/authentication_bloc/bloc.dart';
import 'package:ciclo_helper/maintenance/maintenance_page.dart';
import 'package:ciclo_helper/my_bike/my_bike.dart';
import 'package:ciclo_helper/screens/infos.dart';
import 'package:ciclo_helper/maps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_bike/my_bike_list_page.dart';

class HomePage extends StatelessWidget {
  final String name;

  HomePage({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          StatusBar(name: name),
          SizedBox(height: 16),
          Menu(),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              title: Text("Mapa"),
              subtitle: Text("Ver meus percursos"),
              trailing: ClipOval(
                child: Container(
                    color: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.map),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => Maps()));
                      },
                    )),
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: Text("Minha Bike"),
              subtitle: Text("Informações da minha Bike"),
              trailing: ClipOval(
                child: Container(
                    color: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.directions_bike),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => MyBikeListPage()));
                      },
                    )),
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: Text("Manutenções"),
              subtitle: Text("Cuidados e Reparos com a Bike"),
              trailing: ClipOval(
                child: Container(
                  color: Colors.green,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage()));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: Text("Manuais e Dicas"),
              subtitle: Text("Precisa de Ajuda? :)"),
              trailing: ClipOval(
                child: Container(
                    color: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.book),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => InfoScreen()));
                      },
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatusBar extends StatelessWidget {
  final String name;
  const StatusBar({
    Key key, @required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.blueGrey,
                    onPressed:() {
                      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                    }
                  ),
                ],
              ),
              CircleAvatar(backgroundColor: Colors.pink),
              SizedBox(height: 16.0),
              Text(
                name.substring(0, name.indexOf('@')),
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 8.0),
              BlocBuilder<MyBikeBloc, MyBikeState>(
                builder: (context, state){
                  if (state is MyBikeLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is MyBikeLoaded && state.myBikes.isNotEmpty){
                    return Text(
                      (state.myBikes[0].brand + ' ' + state.myBikes[0].model),
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    );
                  }
                  return Container();
                  },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 6.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.lightGreen, Colors.lightGreenAccent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
