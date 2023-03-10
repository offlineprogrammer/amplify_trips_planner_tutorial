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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Activity type in your schema. */
@immutable
class Activity extends Model {
  static const classType = const _ActivityModelType();
  final String id;
  final String? _activityName;
  final Trip? _trip;
  final String? _activityImageUrl;
  final String? _activityImageKey;
  final TemporalDate? _activityDate;
  final TemporalTime? _activityTime;
  final ActivityCategory? _category;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ActivityModelIdentifier get modelIdentifier {
      return ActivityModelIdentifier(
        id: id
      );
  }
  
  String get activityName {
    try {
      return _activityName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Trip get trip {
    try {
      return _trip!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get activityImageUrl {
    return _activityImageUrl;
  }
  
  String? get activityImageKey {
    return _activityImageKey;
  }
  
  TemporalDate get activityDate {
    try {
      return _activityDate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalTime? get activityTime {
    return _activityTime;
  }
  
  ActivityCategory get category {
    try {
      return _category!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Activity._internal({required this.id, required activityName, required trip, activityImageUrl, activityImageKey, required activityDate, activityTime, required category, createdAt, updatedAt}): _activityName = activityName, _trip = trip, _activityImageUrl = activityImageUrl, _activityImageKey = activityImageKey, _activityDate = activityDate, _activityTime = activityTime, _category = category, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Activity({String? id, required String activityName, required Trip trip, String? activityImageUrl, String? activityImageKey, required TemporalDate activityDate, TemporalTime? activityTime, required ActivityCategory category}) {
    return Activity._internal(
      id: id == null ? UUID.getUUID() : id,
      activityName: activityName,
      trip: trip,
      activityImageUrl: activityImageUrl,
      activityImageKey: activityImageKey,
      activityDate: activityDate,
      activityTime: activityTime,
      category: category);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Activity &&
      id == other.id &&
      _activityName == other._activityName &&
      _trip == other._trip &&
      _activityImageUrl == other._activityImageUrl &&
      _activityImageKey == other._activityImageKey &&
      _activityDate == other._activityDate &&
      _activityTime == other._activityTime &&
      _category == other._category;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Activity {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("activityName=" + "$_activityName" + ", ");
    buffer.write("trip=" + (_trip != null ? _trip!.toString() : "null") + ", ");
    buffer.write("activityImageUrl=" + "$_activityImageUrl" + ", ");
    buffer.write("activityImageKey=" + "$_activityImageKey" + ", ");
    buffer.write("activityDate=" + (_activityDate != null ? _activityDate!.format() : "null") + ", ");
    buffer.write("activityTime=" + (_activityTime != null ? _activityTime!.format() : "null") + ", ");
    buffer.write("category=" + (_category != null ? enumToString(_category)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Activity copyWith({String? activityName, Trip? trip, String? activityImageUrl, String? activityImageKey, TemporalDate? activityDate, TemporalTime? activityTime, ActivityCategory? category}) {
    return Activity._internal(
      id: id,
      activityName: activityName ?? this.activityName,
      trip: trip ?? this.trip,
      activityImageUrl: activityImageUrl ?? this.activityImageUrl,
      activityImageKey: activityImageKey ?? this.activityImageKey,
      activityDate: activityDate ?? this.activityDate,
      activityTime: activityTime ?? this.activityTime,
      category: category ?? this.category);
  }
  
  Activity.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _activityName = json['activityName'],
      _trip = json['trip']?['serializedData'] != null
        ? Trip.fromJson(new Map<String, dynamic>.from(json['trip']['serializedData']))
        : null,
      _activityImageUrl = json['activityImageUrl'],
      _activityImageKey = json['activityImageKey'],
      _activityDate = json['activityDate'] != null ? TemporalDate.fromString(json['activityDate']) : null,
      _activityTime = json['activityTime'] != null ? TemporalTime.fromString(json['activityTime']) : null,
      _category = enumFromString<ActivityCategory>(json['category'], ActivityCategory.values),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'activityName': _activityName, 'trip': _trip?.toJson(), 'activityImageUrl': _activityImageUrl, 'activityImageKey': _activityImageKey, 'activityDate': _activityDate?.format(), 'activityTime': _activityTime?.format(), 'category': enumToString(_category), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'activityName': _activityName, 'trip': _trip, 'activityImageUrl': _activityImageUrl, 'activityImageKey': _activityImageKey, 'activityDate': _activityDate, 'activityTime': _activityTime, 'category': _category, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ActivityModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ActivityModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ACTIVITYNAME = QueryField(fieldName: "activityName");
  static final QueryField TRIP = QueryField(
    fieldName: "trip",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Trip'));
  static final QueryField ACTIVITYIMAGEURL = QueryField(fieldName: "activityImageUrl");
  static final QueryField ACTIVITYIMAGEKEY = QueryField(fieldName: "activityImageKey");
  static final QueryField ACTIVITYDATE = QueryField(fieldName: "activityDate");
  static final QueryField ACTIVITYTIME = QueryField(fieldName: "activityTime");
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Activity";
    modelSchemaDefinition.pluralName = "Activities";
    
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
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["tripID", "activityName"], name: "byTrip")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Activity.TRIP,
      isRequired: true,
      targetNames: ['tripID'],
      ofModelName: 'Trip'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYIMAGEURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYIMAGEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.time)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.CATEGORY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
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

class _ActivityModelType extends ModelType<Activity> {
  const _ActivityModelType();
  
  @override
  Activity fromJson(Map<String, dynamic> jsonData) {
    return Activity.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Activity';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Activity] in your schema.
 */
@immutable
class ActivityModelIdentifier implements ModelIdentifier<Activity> {
  final String id;

  /** Create an instance of ActivityModelIdentifier using [id] the primary key. */
  const ActivityModelIdentifier({
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
  String toString() => 'ActivityModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ActivityModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}