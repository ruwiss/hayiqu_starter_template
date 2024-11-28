part of '../widget.dart';

/// Creates a binding between the ViewModel and the UI by providing a builder function that
/// gets called when the viewmodel changes has occured.
abstract class BaseView<T extends ChangeNotifier> extends StatelessWidget {
  const BaseView({super.key});

  /// A function that builds the UI to be shown from the ViewModel - Required
  ///
  /// [viewModel] is the ViewModel passed in and [child] is the [staticChildBuilder] result
  Widget builder(BuildContext context, T viewModel, Widget? child);

  /// A builder that builds the ViewModel for this UI - Required
  T viewModelBuilder(BuildContext context);

  /// Indicates if the [builder] should be rebuilt when notifyListeners is called
  ///
  /// When stateful is false the builder will fire once and the widgets will be used
  /// as a static child. IT WILL NOT BE BUILT AGAIN.
  bool get stateful => true;

  /// When set to true a new ViewModel will be constructed everytime the widget is inserted.
  ///
  /// When setting this to true make sure to handle all disposing of streams if subscribed
  /// to any in the ViewModel. [onViewModelReady] will fire once the ViewModel has been created/set.
  /// This will be used when on re-insert of the widget the ViewModel has to be constructed with
  /// a new value.
  bool get createNewViewModelOnInsert => false;

  /// Indicates if you want Provider to dispose the ViewModel when it's removed from the widget tree.
  ///
  /// default's to true
  bool get disposeViewModel => true;

  /// Indicates if you want to only initialise the [FutureViewModel] or [StreamViewModel] once or
  /// every time it's inserted into the widget tree.
  bool get initialiseSpecialViewModelsOnce => false;

  /// Indicates if you want to fire onViewModelReady only once or everytime this widget is inserted into
  /// the widget tree.
  bool get fireOnViewModelReadyOnce => false;

  /// Fires when the ViewModel is first created or re-created
  ///
  /// This will fire multiple times when [createNewViewModelOnInsert] is set to true
  void onViewModelReady(T viewModel) {}

  /// Fires when the ViewModel is disposed
  ///
  /// Useful when working with a form on the view to dispose the form.
  void onDispose(T viewModel) {}

  /// A Function that builds UI for the static child that builds only once
  ///
  /// When [stateful] is set to false the builder is used as the static child
  /// and is only ever built once.
  Widget? staticChildBuilder(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    if (stateful) {
      return ViewModelBuilder<T>.stateful(
        builder: builder,
        viewModelBuilder: () => viewModelBuilder(context),
        staticChild: staticChildBuilder(context),
        onViewModelReady: onViewModelReady,
        onDispose: onDispose,
        disposeViewModel: disposeViewModel,
        createNewViewModelOnInsert: createNewViewModelOnInsert,
        initialiseSpecialViewModelsOnce: initialiseSpecialViewModelsOnce,
        fireOnViewModelReadyOnce: fireOnViewModelReadyOnce,
      );
    } else {
      return ViewModelBuilder<T>.stateless(
        builder: builder,
        viewModelBuilder: () => viewModelBuilder(context),
        onViewModelReady: onViewModelReady,
        onDispose: onDispose,
        disposeViewModel: disposeViewModel,
        createNewViewModelOnInsert: createNewViewModelOnInsert,
        initialiseSpecialViewModelsOnce: initialiseSpecialViewModelsOnce,
        fireOnViewModelReadyOnce: fireOnViewModelReadyOnce,
      );
    }
  }
}
