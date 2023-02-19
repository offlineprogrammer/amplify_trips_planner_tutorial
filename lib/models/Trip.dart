/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Trip type in your schema. */
@immutable
class Trip extends Model {
  static const classType = const _TripModelType();
  final String id;
  final String? _tripName;
  final String? _destination;
  final TemporalDate? _startDate;
  final TemporalDate? _endDate;
  final String? _tripImageUrl;
  final String? _tripImageKey;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TripModelIdentifier get modelIdentifier {
      return TripModelIdentifier(
        id: id
      );
  }
  
  String get tripName {
    try {
      return _tripName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get destination {
    try {
      return _destination!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDate get startDate {
    try {
      return _startDate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDate get endDate {
    try {
      return _endDate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get tripImageUrl {
    return _tripImageUrl;
  }
  
  String? get tripImageKey {
    return _tripImageKey;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Trip._internal({required this.id, required tripName, required destination, required startDate, required endDate, tripImageUrl, tripImageKey, createdAt, updatedAt}): _tripName = tripName, _destination = destination, _startDate = startDate, _endDate = endDate, _tripImageUrl = tripImageUrl, _tripImageKey = tripImageKey, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Trip({String? id, required String tripName, required String destination, required TemporalDate startDate, required TemporalDate endDate, String? tripImageUrl, String? tripImageKey}) {
    return Trip._internal(
      id: id == null ? UUID.getUUID() : id,
      tripName: tripName,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      tripImageUrl: tripImageUrl,
      tripImageKey: tripImageKey);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Trip &&
      id == other.id &&
      _tripName == other._tripName &&
      _destination == other._destination &&
      _startDate == other._startDate &&
      _endDate == other._endDate &&
      _tripImageUrl == other._tripImageUrl &&
      _tripImageKey == other._tripImageKey;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Trip {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("tripName=" + "$_tripName" + ", ");
    buffer.write("destination=" + "$_destination" + ", ");
    buffer.write("startDate=" + (_startDate != null ? _startDate!.format() : "null") + ", ");
    buffer.write("endDate=" + (_endDate != null ? _endDate!.format() : "null") + ", ");
    buffer.write("tripImageUrl=" + "$_tripImageUrl" + ", ");
    buffer.write("tripImageKey=" + "$_tripImageKey" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Trip copyWith({String? tripName, String? destination, TemporalDate? startDate, TemporalDate? endDate, String? tripImageUrl, String? tripImageKey}) {
    return Trip._internal(
      id: id,
      tripName: tripName ?? this.tripName,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tripImageUrl: tripImageUrl ?? this.tripImageUrl,
      tripImageKey: tripImageKey ?? this.tripImageKey);
  }
  
  Trip.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _tripName = json['tripName'],
      _destination = json['destination'],
      _startDate = json['startDate'] != null ? TemporalDate.fromString(json['startDate']) : null,
      _endDate = json['endDate'] != null ? TemporalDate.fromString(json['endDate']) : null,
      _tripImageUrl = json['tripImageUrl'],
      _tripImageKey = json['tripImageKey'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'tripName': _tripName, 'destination': _destination, 'startDate': _startDate?.format(), 'endDate': _endDate?.format(), 'tripImageUrl': _tripImageUrl, 'tripImageKey': _tripImageKey, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'tripName': _tripName, 'destination': _destination, 'startDate': _startDate, 'endDate': _endDate, 'tripImageUrl': _tripImageUrl, 'tripImageKey': _tripImageKey, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<TripModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<TripModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TRIPNAME = QueryField(fieldName: "tripName");
  static final QueryField DESTINATION = QueryField(fieldName: "destination");
  static final QueryField STARTDATE = QueryField(fieldName: "startDate");
  static final QueryField ENDDATE = QueryField(fieldName: "endDate");
  static final QueryField TRIPIMAGEURL = QueryField(fieldName: "tripImageUrl");
  static final QueryField TRIPIMAGEKEY = QueryField(fieldName: "tripImageKey");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Trip";
    modelSchemaDefinition.pluralName = "Trips";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.TRIPNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.DESTINATION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.STARTDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.ENDDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.TRIPIMAGEURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Trip.TRIPIMAGEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TripModelType extends ModelType<Trip> {
  const _TripModelType();
  
  @override
  Trip fromJson(Map<String, dynamic> jsonData) {
    return Trip.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Trip';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Trip] in your schema.
 */
@immutable
class TripModelIdentifier implements ModelIdentifier<Trip> {
  final String id;

  /** Create an instance of TripModelIdentifier using [id] the primary key. */
  const TripModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TripModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TripModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}