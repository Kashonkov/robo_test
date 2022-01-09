import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StateWithBLoc<T extends Bloc, P extends StatefulWidget> extends State<P> {
  late T bloc;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    bloc = BlocProvider.of<T>(context);
  }

  @override
  @mustCallSuper
  void dispose() {
    closeBloc();
    super.dispose();
  }

  closeBloc() {
    bloc.close();
  }
}
