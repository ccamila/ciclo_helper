
import 'package:ciclo_helper/Model/my_bike.dart';
import 'package:ciclo_helper/My_Bike_Bloc/bloc.dart';
import 'package:ciclo_helper/screens/my_bike_edit.dart';
import 'package:ciclo_helper/screens/my_bike_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBikeListPage extends StatefulWidget{
  @override
  _MyBikeListState createState() => _MyBikeListState();
}

class _MyBikeListState extends State<MyBikeListPage>{
  MyBikeBloc _myBikeBloc;

  @override
  void dispose() {
    _myBikeBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _myBikeBloc = BlocProvider.of(context);
    _myBikeBloc.dispatch(LoadMyBike());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyBikeEdit())),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        bloc: _myBikeBloc,
        child: BlocBuilder(
          bloc: _myBikeBloc,
          // ignore: missing_return
          builder: (BuildContext context, MyBikeState state){
            if (state is MyBikeLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is MyBikeLoaded){
              print(state.myBike.length);
              return ListView.builder(
                itemCount: state.myBike.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyBikeRow(state.myBike[index]);
                },
              );
            }
            else{
              
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class MyBikeRow extends StatefulWidget{
  MyBike myBike;
  MyBikeRow(this.myBike);

  @override
  State<StatefulWidget> createState() => _MyBikeRowState(myBike);
}

class _MyBikeRowState extends State<MyBikeRow>{
  MyBike _myBike;
  MyBikeBloc _myBikeBloc;

  @override
  void initState(){
    _myBikeBloc = BlocProvider.of<MyBikeBloc>(context);
  }
  _MyBikeRowState(this._myBike);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _myBikeBloc,
      child: InkWell(
        onTap: (){
          _myBikeBloc.dispatch(ShowMyBike(_myBike));
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyBikeShowPage()));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)
              )
          ),
           child: Text(_myBike.reg
            ),
          ),
      ),
    );
  }


}