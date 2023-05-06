// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activitiesListHash() => r'0b349799d1c5c0e05fb283da18f1af0d8e0ee993';

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

abstract class _$ActivitiesList
    extends BuildlessAutoDisposeAsyncNotifier<List<Activity>> {
  late final String tripId;

  FutureOr<List<Activity>> build(
    String tripId,
  );
}

/// See also [ActivitiesList].
@ProviderFor(ActivitiesList)
const activitiesListProvider = ActivitiesListFamily();

/// See also [ActivitiesList].
class ActivitiesListFamily extends Family<AsyncValue<List<Activity>>> {
  /// See also [ActivitiesList].
  const ActivitiesListFamily();

  /// See also [ActivitiesList].
  ActivitiesListProvider call(
    String tripId,
  ) {
    return ActivitiesListProvider(
      tripId,
    );
  }

  @override
  ActivitiesListProvider getProviderOverride(
    covariant ActivitiesListProvider provider,
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
  String? get name => r'activitiesListProvider';
}

/// See also [ActivitiesList].
class ActivitiesListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ActivitiesList, List<Activity>> {
  /// See also [ActivitiesList].
  ActivitiesListProvider(
    this.tripId,
  ) : super.internal(
          () => ActivitiesList()..tripId = tripId,
          from: activitiesListProvider,
          name: r'activitiesListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activitiesListHash,
          dependencies: ActivitiesListFamily._dependencies,
          allTransitiveDependencies:
              ActivitiesListFamily._allTransitiveDependencies,
        );

  final String tripId;

  @override
  bool operator ==(Object other) {
    return other is ActivitiesListProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Activity>> runNotifierBuild(
    covariant ActivitiesList notifier,
  ) {
    return notifier.build(
      tripId,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
