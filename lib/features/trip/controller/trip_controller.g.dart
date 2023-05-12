// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncTripHash() => r'77efe6cdffb86f14a31bcaf8d1c8d6d223157371';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AsyncTrip extends BuildlessAutoDisposeAsyncNotifier<Trip> {
  late final String tripId;

  FutureOr<Trip> build(
    String tripId,
  );
}

/// See also [TripController].
@ProviderFor(TripController)
const asyncTripProvider = AsyncTripFamily();

/// See also [TripController].
class AsyncTripFamily extends Family<AsyncValue<Trip>> {
  /// See also [TripController].
  const AsyncTripFamily();

  /// See also [TripController].
  AsyncTripProvider call(
    String tripId,
  ) {
    return AsyncTripProvider(
      tripId,
    );
  }

  @override
  AsyncTripProvider getProviderOverride(
    covariant AsyncTripProvider provider,
  ) {
    return call(
      provider.tripId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'asyncTripProvider';
}

/// See also [TripController].
class AsyncTripProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TripController, Trip> {
  /// See also [TripController].
  AsyncTripProvider(
    this.tripId,
  ) : super.internal(
          () => TripController()..tripId = tripId,
          from: asyncTripProvider,
          name: r'asyncTripProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncTripHash,
          dependencies: AsyncTripFamily._dependencies,
          allTransitiveDependencies: AsyncTripFamily._allTransitiveDependencies,
        );

  final String tripId;

  @override
  bool operator ==(Object other) {
    return other is AsyncTripProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Trip> runNotifierBuild(
    covariant TripController notifier,
  ) {
    return notifier.build(
      tripId,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
