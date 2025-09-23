// ignore_for_file: lines_longer_than_80_chars, unused_import, directives_ordering, avoid_classes_with_only_static_members, public_member_api_docs

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'configs/build_yaml_config.dart';
import 'configs/code_generation_config.dart';
import 'parser/field_element_parser.dart';
import 'templates/create/create_class_template.dart';
import 'templates/delete/delete_class_template.dart';
import 'templates/query/query_class_template.dart';
import 'templates/read/read_class_template.dart';
import 'templates/references/references_template.dart';
import 'templates/update/update_class_template.dart';
import 'utils/dart_object_util.dart';
import 'utils/string.dart';

/// A generator for [FirestoreDocument] annotation.
///
/// This class is responsible for generating Dart code for classes annotated
/// with [FirestoreDocument]. It produces the necessary classes and methods
/// for interacting with Firestore, based on the provided configuration and
/// annotations. This includes generating classes for CRUD operations, query
/// handling, and Firestore references.
class FlutterFireGen extends GeneratorForAnnotation<FirestoreDocument> {
  /// Creates a new instance of [FlutterFireGen].
  ///
  /// Parameters:
  ///
  /// - [_buildYamlConfig] Configuration for code generation provided in
  /// `build.yaml`.
  FlutterFireGen(this._buildYamlConfig);

  /// A [BuildYamlConfig] instance containing configuration from `build.yaml`.
  final BuildYamlConfig _buildYamlConfig;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.name ?? element.displayName;

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@FirestoreDocument can only be applied on classes. '
        'Failing element: ${element.name}',
        element: element,
      );
    }

    if (!name.startsWith(_buildYamlConfig.schemaDefinitionClassPrefix)) {
      throw InvalidGenerationSourceError(
        '$name must start with '
        "'${_buildYamlConfig.schemaDefinitionClassPrefix}'. "
        'Because you set schema_definition_class_prefix to '
        "'${_buildYamlConfig.schemaDefinitionClassPrefix}' in build.yaml. "
        'Failing element: $name',
        element: element,
      );
    }

    final baseClassName = name.replaceFirst(_buildYamlConfig.schemaDefinitionClassPrefix, '');

    final annotation = const TypeChecker.typeNamed(FirestoreDocument).firstAnnotationOf(element, throwOnUnresolved: false)!;

    final config = CodeGenerationConfig(
      baseClassName: baseClassName,
      path: annotation.decodeField(
        'path',
        decode: (obj) => obj.toStringValue()!,
        orElse: () => throw InvalidGenerationSourceError(
          'path field is required. '
          'Failing element: ${element.name}',
          element: element,
        ),
      ),
      readClassPrefix: annotation.decodeField(
        'readClassPrefix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.readClassPrefix.capitalize,
      ),
      readClassSuffix: annotation.decodeField(
        'readClassSuffix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.readClassSuffix.capitalize,
      ),
      createClassPrefix: annotation.decodeField(
        'createClassPrefix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.createClassPrefix.capitalize,
      ),
      createClassSuffix: annotation.decodeField(
        'createClassSuffix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.createClassSuffix.capitalize,
      ),
      updateClassPrefix: annotation.decodeField(
        'updateClassPrefix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.updateClassPrefix.capitalize,
      ),
      updateClassSuffix: annotation.decodeField(
        'updateClassSuffix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.updateClassSuffix.capitalize,
      ),
      deleteClassPrefix: annotation.decodeField(
        'deleteClassPrefix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.deleteClassPrefix.capitalize,
      ),
      deleteClassSuffix: annotation.decodeField(
        'deleteClassSuffix',
        decode: (obj) => obj.toStringValue()!.capitalize(),
        orElse: _buildYamlConfig.deleteClassSuffix.capitalize,
      ),
      includePathField: annotation.decodeField(
        'includePathField',
        decode: (obj) => obj.toBoolValue() ?? false,
        orElse: () => _buildYamlConfig.includePathField,
      ),
      includeDocumentReferenceField: annotation.decodeField(
        'includeDocumentReferenceField',
        decode: (obj) => obj.toBoolValue() ?? false,
        orElse: () => _buildYamlConfig.includeDocumentReferenceField,
      ),
      generateCopyWith: annotation.decodeField(
        'generateCopyWith',
        decode: (obj) => obj.toBoolValue() ?? false,
        orElse: () => _buildYamlConfig.generateCopyWith,
      ),
      fieldConfigs: element.fields
          .map(
            FieldElementParser(
              readDefaultTypeChecker: TypeCheckerHelper.readDefault,
              createDefaultTypeChecker: TypeCheckerHelper.createDefault,
              updateDefaultTypeChecker: TypeCheckerHelper.updateDefault,
              jsonConverterTypeChecker: TypeCheckerHelper.jsonConverter,
              jsonPostProcessorTypeChecker: TypeCheckerHelper.jsonPostProcessor,
              allowFieldValueTypeChecker: TypeCheckerHelper.allowFieldValue,
              alwaysUseFieldValueServerTimestampWhenCreatingTypeChecker: TypeCheckerHelper.alwaysUseFieldValueServerTimestampWhenCreating,
              alwaysUseFieldValueServerTimestampWhenUpdatingTypeChecker: TypeCheckerHelper.alwaysUseFieldValueServerTimestampWhenUpdating,
            ).parse,
          )
          .toList(),
    );

    final buffer = StringBuffer()
      ..writeln(ReadClassTemplate(config))
      ..writeln(CreateClassTemplate(config))
      ..writeln(UpdateClassTemplate(config))
      ..writeln(DeleteClassTemplate(config))
      ..writeln(ReferencesTemplate(config))
      ..writeln(QueryClassTemplate(config));

    return buffer.toString();
  }
}

// Adicione esta classe helper no seu arquivo
class TypeCheckerHelper {
  static TypeChecker createChecker(Type className, String package) {
    try {
      // Tenta métodos alternativos baseados no nome da classe
      // Se você tiver acesso às classes runtime, pode tentar reflection
      return TypeChecker.typeNamed(className, inPackage: package);
    } catch (e) {
      // Fallback seguro
      throw StateError('Cannot create TypeChecker for $className from $package: $e');
    }
  }

  // Métodos específicos para suas anotações
  static TypeChecker get readDefault => createChecker(ReadDefault, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get createDefault => createChecker(CreateDefault, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get updateDefault => createChecker(UpdateDefault, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get jsonConverter => createChecker(JsonConverter, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get jsonPostProcessor => createChecker(JsonPostProcessor, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get allowFieldValue => createChecker(AllowFieldValue, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get alwaysUseFieldValueServerTimestampWhenCreating =>
      createChecker(AlwaysUseFieldValueServerTimestampWhenCreating, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');

  static TypeChecker get alwaysUseFieldValueServerTimestampWhenUpdating =>
      createChecker(AlwaysUseFieldValueServerTimestampWhenUpdating, 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart');
}
