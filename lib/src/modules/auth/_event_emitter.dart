// export let createNanoEvents = () => ({
//   events: {},
//   emit(event, ...args) {
//     ;(this.events[event] || []).forEach(i => i(...args))
//   },
//   on(event, cb) {
//     ;(this.events[event] = this.events[event] || []).push(cb)
//     return () =>
//       (this.events[event] = (this.events[event] || []).filter(i => i !== cb))
//   }
// })

import 'dart:async';

typedef Func<T> = FutureOr<void> Function(String type, T);
typedef RemoveFunc = void Function();

/// Small event emitter
///
/// Based on https://github.com/ai/nanoevents
/// Added emit async for simple async support, based on `EventEmitter2` API.
class EventEmitter<T> {
  final Map<String, List<Func<T>>> _events = {
    '_always': [],
  };

  List<Func<T>> _getEvents(String type) {
    final events = _events[type] ?? [];
    final alwaysEvents = _events['_always'] ?? [];
    return List.from(events)..addAll(alwaysEvents);
  }

  void emit(String type, T data) {
    for (var event in _getEvents(type)) {
      event(type, data);
    }
  }

  Future<void> emitAsync(String type, T data) async {
    for (var event in _getEvents(type)) {
      await event(type, data);
    }
  }

  /// If [type] is null, event will be always called
  RemoveFunc on(String? type, Func<T> cb) {
    _events[type ?? '_always'] ??= [];
    _events[type ?? '_always']!.add(cb);

    return () => _events[type]?.where((listener) => listener != cb);
  }
}
