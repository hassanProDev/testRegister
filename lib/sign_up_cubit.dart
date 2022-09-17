import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:registration_test/dio_helper.dart';
import 'package:registration_test/end_points.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  Future getAllData(json) async {
    emit(SignUpInitial());
    await DioHelper.postData(url: register, data: json).then((value) {
      // if(value.statusCode==200){
      print(value.data);
      emit(SignUpSuccess());
      print('ana gameeeeeed');
      // }
    }).catchError((e) {
      emit(SignUpError(e.toString()));
      print('bazt 5aleeeeees bazt bazeeeet');
    });
  }
}
