import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class TodoEndpoint extends Endpoint {
  Future<List<Todo>> getAllTodos(Session session) async {
    return Todo.find(session);
  }

  Future<void> addTodo(Session session, {required Todo todo}) async {
    await Todo.insert(session, todo);
  }

  Future<bool> updateTodo(Session session, {required Todo todo}) async {
    return Todo.update(session, todo);
  }

  Future<bool> deleteTodo(Session session, {required int id}) async {
    final result = await Todo.delete(session, where: (t) => t.id.equals(id));
    return result == 1;
  }
}
