import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_test/sign_up_cubit.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailConroler = TextEditingController();
  var passwordConroler = TextEditingController();
  var phoneConroler = TextEditingController();
  var nameConroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        lazy: true,
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignUpInitial) {
              print('u have an error');
            }
            if (state is SignUpError) {
              print('u have an logic error');
            }
            if (state is SignUpSuccess) {
              print('we dont know ur error');
            }
          },
          builder: (context, state) {
            SignUpCubit myCubit = SignUpCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        controller: nameConroler,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'mail'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your mail';
                          }
                        },
                        controller: emailConroler,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your password';
                          }
                        },
                        controller: passwordConroler,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'phone'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your phone';
                          }
                        },
                        controller: phoneConroler,
                      ),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            var json = {
                              'name': nameConroler.text,
                              'email': emailConroler.text,
                              'phone': phoneConroler.text,
                              'password': passwordConroler.text,
                            };
                            SignUpCubit.get(context)
                                .getAllData(json)
                                .then((value) {
                              // var x = myCubit.signUpModel.data!.token;
                              // print(x);
                              print('ok');
                            }).catchError((onError) {
                              print(onError.toString());
                            });
                          }
                        },
                        child: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(32),
                          child: Text('Press Here'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
