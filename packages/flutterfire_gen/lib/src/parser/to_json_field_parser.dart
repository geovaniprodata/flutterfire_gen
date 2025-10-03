import 'package:analyzer/dart/element/type.dart';

import '../configs/json_converter_config.dart';
import '../utils/dart_type_util.dart';

/// A utility class responsible for generating Dart code for serializing a
/// specific class field to a JSON object.
///
/// This class is used to generate the code snippet necessary to serialize
/// a field to JSON, considering any special configurations like default values,
/// allowance of Firestore's `FieldValue`, and custom JSON converters.
class ToJsonFieldParser {
  /// Creates a new [ToJsonFieldParser] instance.
  ///
  /// Parameters:
  ///
  /// - [name] The name of the field in the class.
  /// - [dartType] The Dart type of the field.
  /// - [defaultValueString] The default value of the field, represented as a
  /// string.
  /// - [allowFieldValue] Whether to allow `FieldValue` in the serialized
  /// output.
  /// - [alwaysUseFieldValueServerTimestamp] Whether to always use
  /// `FieldValue.serverTimestamp()` for the field.
  /// - [jsonConverterConfig] Configuration for custom JSON conversion of the
  /// field.
  /// - [skipIfNull] Whether to skip serialization of the field if it's null.
  const ToJsonFieldParser({
    required this.name,
    required this.dartType,
    required this.defaultValueString,
    required this.allowFieldValue,
    required this.alwaysUseFieldValueServerTimestamp,
    required this.jsonConverterConfig,
    required this.skipIfNull,
  });

  /// The name of the field in the class.
  final String name;

  /// The Dart type of the field.
  final DartType dartType;

  /// The default value of the field, represented as a string.
  ///
  /// This value is used as a fallback in the serialization process when the
  /// field's value is absent.
  final String? defaultValueString;

  /// Whether the field allows `FieldValue` in the serialized output.
  ///
  /// Set to `true` to allow usage of `FieldValue` types like
  /// `FieldValue.serverTimestamp()` in the serialized JSON.
  final bool allowFieldValue;

  /// Whether the field always uses `FieldValue.serverTimestamp()` during
  /// serialization.
  ///
  /// When set to `true`, the field's value in the serialized JSON will always
  /// be the server's timestamp.
  final bool alwaysUseFieldValueServerTimestamp;

  /// Configuration for custom JSON conversion of the field.
  ///
  /// If provided, this configuration is used to customize the serialization of
  /// the field to JSON.
  final JsonConverterConfig? jsonConverterConfig;

  /// Whether to skip serialization of the field if it's null.
  ///
  /// Set to `true` to exclude the field from the serialized JSON if its value
  /// is null.
  final bool skipIfNull;

  @override
  String toString() {
    final assertNonNull = skipIfNull && (defaultValueString ?? '').isEmpty && !alwaysUseFieldValueServerTimestamp;
    final result = _generateToJsonCodeSnippet(
      dartType: dartType,
      defaultValueString: defaultValueString,
      isFieldValueAllowed: allowFieldValue,
      isAlwaysUseFieldValueServerTimestamp: alwaysUseFieldValueServerTimestamp,
      jsonConverterConfig: jsonConverterConfig,
      assertNonNull: assertNonNull,
    );
    if (assertNonNull) {
      return "if ($name != null) '$name': $result,";
    } else {
      return "'$name': $result,";
    }
  }

  /// Generates a Dart code snippet for serializing a field to a JSON object.
  ///
  /// Parameters:
  ///
  /// - [dartType] The type of the field to be serialized.
  /// - [defaultValueString] A default value for the field, if any.
  /// - [isFieldValueAllowed] Whether `FieldValue` is allowed for the field.
  /// - [isAlwaysUseFieldValueServerTimestamp] Whether to always use
  /// `FieldValue.serverTimestamp()` for the field.
  /// - [jsonConverterConfig] Configuration for custom JSON conversion.
  /// - [assertNonNull] A flag to enforce non-null assertion in the
  /// serialization process.
  String _generateToJsonCodeSnippet({
    required DartType dartType,
    required String? defaultValueString,
    required bool isFieldValueAllowed,
    required bool isAlwaysUseFieldValueServerTimestamp,
    required JsonConverterConfig? jsonConverterConfig,
    required bool assertNonNull,
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;
    final defaultValueExpression = hasDefaultValue ? ' ?? $defaultValueString' : '';

    if (isAlwaysUseFieldValueServerTimestamp) {
      return 'FieldValue.serverTimestamp()';
    }

    if (jsonConverterConfig != null) {
      if (hasDefaultValue && dartType.isNullableType) {
        if (isFieldValueAllowed) {
          return '$name == null '
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}'
              '.toJson($name!.actualValue)';
        } else {
          return '$name == null '
              '? $defaultValueString '
              ': ${jsonConverterConfig.jsonConverterString}.toJson($name!)';
        }
      }
      if (isFieldValueAllowed) {
        if (assertNonNull) {
          return '${jsonConverterConfig.jsonConverterString}'
              '.toJson($name!.actualValue)';
        } else {
          return '${jsonConverterConfig.jsonConverterString}'
              '.toJson($name.actualValue)';
        }
      } else {
        if (assertNonNull) {
          return '${jsonConverterConfig.jsonConverterString}'
              '.toJson($name!)';
        } else {
          return '${jsonConverterConfig.jsonConverterString}'
              '.toJson($name)';
        }
      }
    }

    if (isFieldValueAllowed) {
      if (dartType.isNullableType || hasDefaultValue) {
        if (assertNonNull) {
          return '$name!.value$defaultValueExpression';
        } else {
          return '$name?.value$defaultValueExpression';
        }
      } else {
        if (assertNonNull) {
          return '$name!.value';
        } else {
          return '$name.value';
        }
      }
    }

    if (dartType.isDateTimeType) {
      if (dartType.isNullableType) {
        return '$name == null ? null : Timestamp.fromDate($name!)';
      } else {
        if (assertNonNull) {
          return 'Timestamp.fromDate($name!)';
        } else {
          return 'Timestamp.fromDate($name)';
        }
      }
    }

    // Handle Enums - they serialize to their name string
    if (dartType.isEnumType) {
      if (dartType.isNullableType) {
        if (assertNonNull) {
          return '$name!.name';
        } else {
          return '$name?.name';
        }
      } else {
        return '$name.name';
      }
    }

    // Handle Lists with non-primitive types
    // This mimics json_serializable's explicitToJson behavior
    if (dartType.isDartCoreList) {
      final listItemType = dartType.firstTypeArgumentOfList;
      if (listItemType != null && !listItemType.isPrimitiveType && !listItemType.isEnumType) {
        if (dartType.isNullableType) {
          if (assertNonNull) {
            return '$name!.map((e) => e.toJson()).toList()';
          } else {
            return '$name?.map((e) => e.toJson()).toList()';
          }
        } else {
          return '$name.map((e) => e.toJson()).toList()';
        }
      }
    }

    // Handle Maps with non-primitive values or enum keys
    // This mimics json_serializable's explicitToJson behavior
    if (dartType.isDartCoreMap) {
      final keyValueTypes = dartType.keyValueOfMap;
      if (keyValueTypes != null) {
        final keyType = keyValueTypes.key;
        final valueType = keyValueTypes.value;

        // Handle Map with Enum keys (e.g., Map<MarketplacesEnum, bool>)
        if (keyType.isEnumType) {
          // Serialize enum keys to their name (String)
          if (valueType.isPrimitiveType || valueType is DynamicType) {
            // Map<EnumType, primitive> - just convert keys to names
            if (dartType.isNullableType) {
              if (assertNonNull) {
                return '$name!.map((k, v) => MapEntry(k.name, v))';
              } else {
                return '$name?.map((k, v) => MapEntry(k.name, v))';
              }
            } else {
              return '$name.map((k, v) => MapEntry(k.name, v))';
            }
          } else {
            // Map<EnumType, ComplexType> - convert keys to names and values to JSON
            if (dartType.isNullableType) {
              if (assertNonNull) {
                return '$name!.map((k, v) => MapEntry(k.name, v.toJson()))';
              } else {
                return '$name?.map((k, v) => MapEntry(k.name, v.toJson()))';
              }
            } else {
              return '$name.map((k, v) => MapEntry(k.name, v.toJson()))';
            }
          }
        }

        // Handle Map with String keys and non-primitive values
        if (keyType.isDartCoreString) {
          // If value is not primitive, not dynamic, and not enum, need to call toJson on values
          if (!valueType.isPrimitiveType && valueType is! DynamicType && !valueType.isEnumType) {
            if (dartType.isNullableType) {
              if (assertNonNull) {
                return '$name!.map((k, v) => MapEntry(k, v.toJson()))';
              } else {
                return '$name?.map((k, v) => MapEntry(k, v.toJson()))';
              }
            } else {
              return '$name.map((k, v) => MapEntry(k, v.toJson()))';
            }
          }

          // If value is enum, convert to name
          if (valueType.isEnumType) {
            if (dartType.isNullableType) {
              if (assertNonNull) {
                return '$name!.map((k, v) => MapEntry(k, v.name))';
              } else {
                return '$name?.map((k, v) => MapEntry(k, v.name))';
              }
            } else {
              return '$name.map((k, v) => MapEntry(k, v.name))';
            }
          }
        }
      }
    }

    // Handle non-primitive types with implicit toJson()
    // This mimics json_serializable's explicitToJson behavior
    if (!dartType.isPrimitiveType) {
      if (dartType.isNullableType) {
        if (assertNonNull) {
          return '$name!.toJson()';
        } else {
          return '$name?.toJson()';
        }
      } else {
        return '$name.toJson()';
      }
    }

    return '$name$defaultValueExpression';
  }
}
