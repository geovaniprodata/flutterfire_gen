import 'package:analyzer/dart/element/element2.dart';

/// Analyzes constructor parameters to extract default values.
class ConstructorDefaultAnalyzer {
  /// Extracts the default value expression from a constructor parameter.
  ///
  /// Returns the default value as a String if it exists, otherwise null.
  ///
  /// Examples:
  /// - `this.sistema = Sistema.web` → returns "Sistema.web"
  /// - `this.marketplacesAtivos = const []` → returns "const []"
  /// - `required this.cnpj` → returns null
  static String? getConstructorDefaultValue(
    ClassElement2 classElement,
    String fieldName,
  ) {
    // Get the unnamed (default) constructor
    final constructor = classElement.constructors2.firstWhere(
      (c) => c.name3 == null || c.name3!.isEmpty,
      orElse: () => throw StateError('No default constructor found'),
    );

    // Find the parameter for this field
    for (final param in constructor.formalParameters) {
      // Check if this parameter corresponds to the field
      if (param.name3 == fieldName) {
        // Get the default value from the source code
        final defaultValueCode = param.defaultValueCode;

        if (defaultValueCode != null && defaultValueCode.isNotEmpty) {
          return defaultValueCode;
        }

        return null;
      }
    }

    return null;
  }

  /// Checks if a constructor parameter has a default value.
  static bool hasConstructorDefaultValue(
    ClassElement2 classElement,
    String fieldName,
  ) {
    return getConstructorDefaultValue(classElement, fieldName) != null;
  }

  /// Gets all fields with their constructor default values.
  static Map<String, String> getAllConstructorDefaults(
    ClassElement2 classElement,
  ) {
    final defaults = <String, String>{};

    try {
      final constructor = classElement.constructors2.firstWhere(
        (c) => c.name3 == null || c.name3!.isEmpty,
        orElse: () => throw StateError('No default constructor found'),
      );

      for (final param in constructor.formalParameters) {
        final paramName = param.name3;
        final defaultValueCode = param.defaultValueCode;

        if (paramName != null && defaultValueCode != null && defaultValueCode.isNotEmpty) {
          defaults[paramName] = defaultValueCode;
        }
      }
    } catch (e) {
      // If no constructor found or error, return empty map
    }

    return defaults;
  }
}
