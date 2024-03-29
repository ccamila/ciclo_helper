import 'package:ciclo_helper/my_bike/my_bike.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBikeAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBikeEditForm(
      isEditable: false,
      isShowing: false,
      onSave: (myBike) {
        BlocProvider.of<MyBikeBloc>(context).add(AddedMyBike(myBike));
      },
    );
  }
}
