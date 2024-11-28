part of '../viewmodel.dart';

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Stream]
/// This class is mixed with mixins:
/// - [MessageStateHelper]
/// - [DataStateHelper]
abstract class StreamViewModel<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper<T>
    implements Initialisable {
  /// Stream to listen to
  Stream<T> get stream;

  StreamSubscription? get streamSubscription => _streamSubscription;

  StreamSubscription? _streamSubscription;

  @override
  void notifySourceChanged({bool clearOldData = false}) {
    changeSource = true;
    _streamSubscription?.cancel();
    _streamSubscription = null;

    if (clearOldData) {
      data = null;
    }

    notifyListeners();
  }

  @override
  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        setError(null);
        setMessage(null);
        // Extra security in case transformData isnt sent
        var interceptedData = transformData(incomingData);

        if (interceptedData != null) {
          data = interceptedData;
        } else {
          data = incomingData;
        }

        onData(data);
        notifyListeners();
      },
      onError: (error) {
        setError(error);
        data = null;
        onError(error);
        notifyListeners();
      },
    );

    onSubscribed();
    changeSource = false;
  }

  /// Called before the notifyListeners is called when data has been set
  void onData(T? data) {}

  /// Called when the stream is listened too
  void onSubscribed() {}

  /// Called when an error is fired in the stream
  void onError(error) {}

  void onCancel() {}

  /// Called before the data is set for the ViewModel
  T transformData(T data) {
    return data;
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    onCancel();

    super.dispose();
  }
}
