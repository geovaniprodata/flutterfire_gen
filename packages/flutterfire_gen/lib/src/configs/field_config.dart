import 'package:analyzer/dart/element/type.dart';

import '../utils/dart_type_util.dart';
import 'json_converter_config.dart';
import 'json_post_processor_config.dart';

/// A configuration for a field in `@FirestoreDocument` annotated schema
/// definition classes
///
/// This class holds various configurations for a field in a
/// `@FirestoreDocument` annotated schema definition class, including its Dart
/// type, default values for different operations, and configurations for JSON
/// serialization.
class FieldConfig {
  /// Creates a new [FieldConfig] instance.
  ///
  /// Parameters:
  ///
  /// - [name] The name of the field.
  /// - [dartType] The Dart type of the field.
  /// - [readDefaultValueString] The default value as a string for the field
  /// when reading.
  /// - [createDefaultValueString] The default value as a string for the field
  /// when creating.
  /// - [updateDefaultValueString] The default value as a string for the field
  /// when updating.
  /// - [jsonConverterConfig] The configuration for JSON conversion.
  /// - [jsonPostProcessorConfig] The configuration for JSON post-processing.
  /// - [allowFieldValue] Whether to allow `FieldValue` in write operations.
  /// - [alwaysUseFieldValueServerTimestampWhenCreating] Whether to always use
  /// `FieldValue.serverTimestamp()` when creating.
  /// - [alwaysUseFieldValueServerTimestampWhenUpdating] Whether to always use
  /// `FieldValue.serverTimestamp()` when updating.
  /// - [ignoreJsonSerialization] Whether to completely ignore this field
  /// during code generation (useful for getters and computed properties).
  FieldConfig({
    required this.name,
    required this.dartType,
    this.readDefaultValueString,
    this.createDefaultValueString,
    this.updateDefaultValueString,
    this.jsonConverterConfig,
    this.jsonPostProcessorConfig,
    this.allowFieldValue = false,
    this.alwaysUseFieldValueServerTimestampWhenCreating = false,
    this.alwaysUseFieldValueServerTimestampWhenUpdating = false,
    this.ignoreJsonSerialization = false,
  });

  /// The name of the field.
  final String name;

  /// The Dart type of the field.
  final DartType dartType;

  /// Generates the type name of the field as a String.
  ///
  /// Parameters:
  ///
  /// - [forceNullable] Whether to force the type to be nullable.
  /// - [wrapByFirestoreData] Whether to wrap the type with `FirestoreData` for
  /// `FieldValue` support.
  ///
  /// Returns the type name of the field, potentially modified by the provided
  /// parameters.
  String typeName({
    bool forceNullable = false,
    bool wrapByFirestoreData = false,
  }) =>
      dartType.typeName(
        forceNullable: forceNullable,
        wrapByFirestoreData: wrapByFirestoreData,
      );

  /// The default value as a string for the field when reading from Firestore.
  ///
  /// If specified, this value is used when a field is absent or `null` in
  /// Firestore during read operations.
  final String? readDefaultValueString;

  /// The default value as a string for the field when creating a new document
  /// in Firestore.
  ///
  /// If provided, this value is used as the default when the field is not
  /// explicitly set during document creation.
  final String? createDefaultValueString;

  /// The default value as a string for the field when updating a document in
  /// Firestore.
  ///
  /// If specified, this value is used as the default when the field is not
  /// explicitly set during document update operations.
  final String? updateDefaultValueString;

  /// The configuration for custom JSON serialization of the field.
  ///
  /// If provided, this configuration is used to customize how the field is
  /// serialized and deserialized to and from JSON.
  final JsonConverterConfig? jsonConverterConfig;

  /// The configuration for post-processing of the field's JSON data.
  ///
  /// If specified, this configuration allows for additional processing of the
  /// field's data after JSON serialization or deserialization.
  final JsonPostProcessorConfig? jsonPostProcessorConfig;

  /// Indicates whether the field supports Firestore's `FieldValue` types in
  /// write operations.
  ///
  /// Set to `true` to allow usage of `FieldValue` types like
  /// `FieldValue.serverTimestamp()` in create and update operations.
  final bool allowFieldValue;

  /// Whether to automatically use `FieldValue.serverTimestamp()` as the default
  /// value when creating a document.
  ///
  /// Set to `true` to enforce that the field's value is set to the server's
  /// timestamp during document creation.
  final bool alwaysUseFieldValueServerTimestampWhenCreating;

  /// Whether to automatically use `FieldValue.serverTimestamp()` as the default
  /// value when updating a document.
  ///
  /// Set to `true` to enforce that the field's value is updated to the server's
  /// timestamp during document update operations.
  final bool alwaysUseFieldValueServerTimestampWhenUpdating;

  /// Whether to completely ignore this field during code generation.
  ///
  /// Set to `true` to exclude this field from Create, Update, and Delete classes.
  /// This is useful for:
  /// - Getters that shouldn't be in constructor parameters
  /// - Computed properties
  /// - Fields that only make sense in the Read class
  ///
  /// Note: The field will still appear in the Read class if it's a valid field.
  final bool ignoreJsonSerialization;

  /// Returns true if this field should be included in Create/Update/Delete classes.
  bool get shouldIncludeInWriteClasses => !ignoreJsonSerialization;

  /// Returns true if this field should be included in the Read class.
  /// Currently always returns true as Read class includes all fields.
  bool get shouldIncludeInReadClass => true;
}
