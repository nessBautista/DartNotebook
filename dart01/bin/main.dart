import 'package:dart01/dart01.dart' as dart01;
import 'dart:async';

//ASYNCHRONOUS STRUCTS
//Study from: https://www.youtube.com/watch?v=kN7X_gWcuv0

main(List<String> arguments) {

  //executeSimpleFutureFunction();
  //executeAsyncFunction();
  //addExample01();
  //addExample02();
  //operationInSeries();
  //asycnFlow();
}


//-- STREAMS

//--SIMPLE FUTURE FUNCTIONS
//These functions exemplify a simple Future type of functions
// the keyword 'then' works as the callback function.
executeSimpleFutureFunction() {
  //The result of the future function is received in a callback
  loadString("Hello from Dart").then( (s) => print(s));
}
Future<String> loadString(String str)  {
  return Future.delayed(Duration(seconds: 1)).then((_) {
    return "String: $str";
  });
}


//--ASYNC AND AWAIT KEYWORDS
executeAsyncFunction () async{
  String str = await loadString2("Hello from dart ASYNC using await");
  print(str);
}

Future<String>loadString2(String str) async {
  await Future.delayed(Duration(seconds: 1));
  return "String: $str";
}

//-- RETURN CLOSURES-FUNCTION TYPES
//Using async functions with 'then' keyword
addExample01(){
  addAsync(30)
      .then(
        //REMEMBER: y_holder is a function requesting for a value (int)
        (y_holder) => y_holder(50),
      )
      .then(
        (result) => print(result),
      );
}
//Using async functions with 'await' keyword
addExample02() async {

  Function addFunc = await addAsync(50);
  int result = await addFunc(40);
  print(result);
}

//This function describes a 2 way flow. When called, it will return a closure
//where the caller will need to introduce a value 'y', then the flow will return
//to this function and perform the sum 'x+y', then will return to the caller with
//the result
Future<Function> addAsync(int x) async {
  return (int y) async => x + y;
}


//--SERIAL EXECUTION
operationInSeries() async{

  //This await will cause the execution to stop, until the method comes backk
  String str = await loadString2("Hello From Dart Async");
  print(str);

  addAsync(30)
  .then(
      (x) => x(50),
  )
  .then(
      (y)=> print(y),
  );

  addAsync(50)
      .then(
        (x) => x(40),
  )
      .then(
        (y)=> print(y),
  );
}

//If we use the 'then' keyword, the execution will be based in the duration
//of the operations rather than in the ORDER of the code
asycnFlow() async{

  //This await will cause the execution to stop, until the method comes backk
  loadString2("Hello From Dart Async").then(
      (s)=> print(s),
  );


  addAsync(30)
      .then(
        (x) => x(50),
  )
      .then(
        (y)=> print(y),
  );

  addAsync(50)
      .then(
        (x) => x(40),
  )
      .then(
        (y)=> print(y),
  );
}