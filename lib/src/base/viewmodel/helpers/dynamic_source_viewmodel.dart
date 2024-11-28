part of '../viewmodel.dart';

@protected
class DynamicSourceViewModel<T> extends StatefulViewModel {
  bool changeSource = false;
  void notifySourceChanged() {
    changeSource = true;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [];
}

/// Interface: Additional actions that should be implemented by spcialised ViewModels
abstract class Initialisable {
  void initialise();
}

class StreamData<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper<T> {
  Stream<T> stream;

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  Function? onData;

  /// Called after the stream has been listened too
  Function? onSubscribed;

  /// Called when an error is placed on the stream
  Function? onError;

  /// Called when the stream is cancelled
  Function? onCancel;

  /// Allows you to modify the data before it's set as the new data for the ViewModel
  ///
  /// This can be used to modify the data if required. If nothhing is returned the data
  /// won't be set.
  Function? transformData;
  StreamData(
    this.stream, {
    this.onData,
    this.onSubscribed,
    this.onError,
    this.onCancel,
    this.transformData,
  });
  late StreamSubscription _streamSubscription;

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        setError(null);
        setMessage(null);
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData!(incomingData);

        if (interceptedData != null) {
          data = interceptedData;
        } else {
          data = incomingData;
        }

        notifyListeners();
        onData!(data);
      },
      onError: (error) {
        setError(error);
        data = null;
        onError!(error);
        notifyListeners();
      },
    );

    onSubscribed!();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    onCancel!();

    super.dispose();
  }
}
