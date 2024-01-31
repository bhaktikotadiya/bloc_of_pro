import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'demo1_bloc.dart';
import 'demo1_event.dart';
import 'demo1_state.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Demo1Page(),
  ));
}

class Demo1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Demo1Bloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Demo1Bloc>(context);

    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();
    TextEditingController t3 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC DEMO"),
        centerTitle: true,
      ),
      body: Column(children: [
        TextField(
          controller: t1,
        ),
        TextField(
          controller: t2,
        ),
        TextField(
          controller: t3,
            onChanged: (value) {
              bloc.add(str_event(t3.text));
            },
        ),
        ElevatedButton(onPressed: ()
        {
          bloc.add(sum_event(t1.text, t2.text));
        }, child: Text("SUM")),

        ElevatedButton(onPressed: ()
        {
          bloc.add(sub_event(t1.text, t2.text));
        }, child: Text("SUB")),

        BlocBuilder<Demo1Bloc, Demo1State>(
          buildWhen: (previous, current) =>
            previous != current && current is sum_state,

          builder: (context, state)
        {
           if(state is sum_state)
            {
              return RichText(text: TextSpan(text: "SUM : ${state.sum}"));
            }
           else
             {
               return Text("SUM : 0");
             }
        },),
        BlocBuilder<Demo1Bloc, Demo1State>(
          buildWhen: (previous, current) =>
          previous != current && current is sub_state,
          builder: (context, state)
        {
          if(state is sub_state)
          {
            return RichText(text: TextSpan(text: "sub : ${state.sub}"));
          }
          else
          {
            return Text("SUB : 0");
          }
        },),
        BlocBuilder<Demo1Bloc, Demo1State>(
          buildWhen: (previous, current) =>
          previous != current && current is str_state,
          builder: (context, state)
        {
          if(state is str_state)
          {
            return Text("Str : ${state.str}");
          }
          else
          {
            return Text("Str : 0");
          }
        },),
      ]),
    );
  }
}

