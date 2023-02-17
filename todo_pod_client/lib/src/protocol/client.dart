/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:todo_pod_client/src/protocol/todo_class.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class _EndpointTodo extends _i1.EndpointRef {
  _EndpointTodo(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todo';

  _i2.Future<List<_i3.Todo>> getAllTodos() =>
      caller.callServerEndpoint<List<_i3.Todo>>(
        'todo',
        'getAllTodos',
        {},
      );

  _i2.Future<void> addTodo({required _i3.Todo todo}) =>
      caller.callServerEndpoint<void>(
        'todo',
        'addTodo',
        {'todo': todo},
      );

  _i2.Future<bool> updateTodo({required _i3.Todo todo}) =>
      caller.callServerEndpoint<bool>(
        'todo',
        'updateTodo',
        {'todo': todo},
      );

  _i2.Future<bool> deleteTodo({required int id}) =>
      caller.callServerEndpoint<bool>(
        'todo',
        'deleteTodo',
        {'id': id},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    example = _EndpointExample(this);
    todo = _EndpointTodo(this);
  }

  late final _EndpointExample example;

  late final _EndpointTodo todo;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'todo': todo,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
