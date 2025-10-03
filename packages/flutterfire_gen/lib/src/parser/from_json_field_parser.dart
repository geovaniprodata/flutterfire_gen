import 'package:analyzer/dart/element/type.dart';

import '../configs/json_converter_config.dart';
import '../utils/dart_type_util.dart';

/// A utility class responsible for generating Dart code for deserializing a
/// specific class field from a JSON object.
///
/// This class is used to generate the code snippet necessary to deserialize
/// a field from JSON into its corresponding Dart type, considering any special
/// configurations like default values or custom JSON converters.
class FromJsonFieldParser {
  /// Creates a new [FromJsonFieldParser] instance.
  ///
  /// Parameters:
  ///
  /// - [name] The name of the field in the class.
  /// - [dartType] The Dart type of the field.
  /// - [defaultValueString] The default value of the field, represented as a
  /// string.
  /// - [jsonConverterConfig] Configuration for custom JSON conversion of the
  /// field.
  const FromJsonFieldParser({
    required this.name,
    required this.dartType,
    required this.defaultValueString,
    required this.jsonConverterConfig,
  });

  /// The name of the field in the class.
  final String name;

  /// The Dart type of the field.
  final DartType dartType;

  /// The default value of the field, represented as a string.
  ///
  /// This value is used in the generated code to provide a default when the
  /// JSON object does not contain the field.
  final String? defaultValueString;

  /// Configuration for custom JSON conversion of the field.
  ///
  /// If provided, this configuration is used to customize the deserialization
  /// of the field from JSON.
  final JsonConverterConfig? jsonConverterConfig;

  @override
  String toString() {
    final result = _generateFromJsonCodeSnippet(
      dartType,
      defaultValueString: defaultValueString,
      jsonConverterConfig: jsonConverterConfig,
      isFirstLoop: true,
    );
    return '$name: $result,';
  }

  /// Generates a Dart code snippet for deserializing a field from a JSON
  /// object.
  ///
  /// Parameters:
  ///
  /// - [dartType] The type of the field to be deserialized.
  /// - [defaultValueString] A default value for the field, if any.
  /// - [jsonConverterConfig] Configuration for custom JSON conversion.
  /// - [isFirstLoop] A flag to indicate whether this is the first recursive
  /// call.
  /// - [parsedKey] The key used in parsing, useful in recursion for nested
  /// types.
  String _generateFromJsonCodeSnippet(
    DartType dartType, {
    required bool isFirstLoop,
    String? defaultValueString,
    JsonConverterConfig? jsonConverterConfig,
    String parsedKey = 'e',
  }) {
    final hasDefaultValue = (defaultValueString ?? '').isNotEmpty;

    if (jsonConverterConfig != null) {
      final fromJsonString = '${jsonConverterConfig.jsonConverterString}.'
          "fromJson(extendedJson['$name']"
          ' as ${jsonConverterConfig.firestoreTypeString})';
      if (hasDefaultValue) {
        return "extendedJson['$name'] == null "
            '? $defaultValueString : $fromJsonString';
      } else {
        return fromJsonString;
      }
    }

    final effectiveParsedKey = isFirstLoop ? "extendedJson['$name']" : parsedKey;

    if (dartType.isDartCoreList) {
      if (dartType.firstTypeArgumentOfList != null) {
        final listItemType = dartType.firstTypeArgumentOfList!;
        final parsedListItemType = _generateFromJsonCodeSnippet(
          listItemType,
          defaultValueString: null, // Don't pass default to nested items
          isFirstLoop: false,
        );
        if (dartType.isNullableType || hasDefaultValue) {
          final fallback = hasDefaultValue ? ' ?? $defaultValueString' : '';
          return '($effectiveParsedKey as List<dynamic>?)?.map((e) '
              '=> $parsedListItemType).toList()$fallback';
        } else {
          return '($effectiveParsedKey as List<dynamic>).map((e) '
              '=> $parsedListItemType).toList()';
        }
      }
    }

    if (dartType.isDartCoreMap) {
      final keyValueTypes = dartType.keyValueOfMap;
      if (keyValueTypes != null) {
        final keyType = keyValueTypes.key;
        final valueType = keyValueTypes.value;

        // Check if key is String (required for JSON maps)
        if (keyType.isDartCoreString) {
          // Check if value is dynamic
          if (valueType is DynamicType) {
            if (dartType.isNullableType || hasDefaultValue) {
              final fallback = hasDefaultValue ? ' ?? $defaultValueString' : '';
              return '$effectiveParsedKey '
                  'as Map<String, dynamic>?$fallback';
            } else {
              return '$effectiveParsedKey as Map<String, dynamic>';
            }
          }

          // Value is not dynamic, need to process it recursively
          final parsedMapValueType = _generateFromJsonCodeSnippet(
            valueType,
            defaultValueString: null, // Don't pass default to nested values
            isFirstLoop: false,
            parsedKey: 'v',
          );

          if (dartType.isNullableType || hasDefaultValue) {
            final fallback = hasDefaultValue ? ' ?? $defaultValueString' : '';
            return '($effectiveParsedKey as Map<String, dynamic>?)?.map((k, v) '
                '=> MapEntry(k, $parsedMapValueType))$fallback';
          } else {
            return '($effectiveParsedKey as Map<String, dynamic>).map((k, v) => '
                'MapEntry(k, $parsedMapValueType))';
          }
        }
      }
    }

    if (dartType.isDateTimeType) {
      if (dartType.isNullableType) {
        return '($effectiveParsedKey as Timestamp?)?.toDate()';
      } else {
        return '($effectiveParsedKey as Timestamp).toDate()';
      }
    }

    // Handle Enums
    if (dartType.isEnumType) {
      final typeNameString = dartType.typeName(forceNullable: false);
      final baseTypeName = typeNameString.replaceAll('?', '');

      if (dartType.isNullableType || hasDefaultValue) {
        final fallback = hasDefaultValue ? defaultValueString! : 'null';
        return '$effectiveParsedKey == null ? $fallback : '
            '$baseTypeName.values.byName($effectiveParsedKey as String)';
      } else {
        return '$baseTypeName.values.byName($effectiveParsedKey as String)';
      }
    }

    // Handle non-primitive types with fromJson
    // This mimics json_serializable's explicitToJson behavior
    if (!dartType.isPrimitiveType) {
      final typeNameString = dartType.typeName(forceNullable: false);
      final baseTypeName = typeNameString.replaceAll('?', '');

      if (dartType.isNullableType || hasDefaultValue) {
        final fallback = hasDefaultValue ? defaultValueString! : 'null';
        return '$effectiveParsedKey == null ? $fallback : '
            '$baseTypeName.fromJson($effectiveParsedKey as Map<String, dynamic>)';
      } else {
        return '$baseTypeName.fromJson($effectiveParsedKey as Map<String, dynamic>)';
      }
    }

    final typeNameString = dartType.typeName(
      forceNullable: dartType.isNullableType || hasDefaultValue,
    );

    if (hasDefaultValue) {
      return '$effectiveParsedKey as $typeNameString ?? $defaultValueString';
    } else {
      return '$effectiveParsedKey as $typeNameString';
    }
  }
}
