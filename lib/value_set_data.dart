import 'dart:convert';
import 'package:fhir/r4.dart' as r4;

import 'package:flutter/services.dart';

class ValueSetData {
  final r4.ValueSet? documentClass;
  final r4.ValueSet? documentType;
  final r4.ValueSet? practiceSetting;
  final r4.ValueSet? facilityType;
  final r4.ValueSet? securityLabel;
  final r4.ValueSet? eventCode;
  final r4.ValueSet? attachmentFormat;
  final r4.ValueSet? attachmentContentType;

  const ValueSetData({
    this.documentClass,
    this.documentType,
    this.practiceSetting,
    this.facilityType,
    this.securityLabel,
    this.eventCode,
    this.attachmentFormat,
    this.attachmentContentType,
  });

  static Future<ValueSetData> loadFromAssets({
    String? documentClassPath,
    String? documentTypePath,
    String? practiceSettingPath,
    String? facilityTypePath,
    String? securityLabelPath,
    String? eventCodePath,
    String? attachmentFormatPath,
    String? attachmentContentTypePath,
  }) async {
    r4.ValueSet? documentClass;
    r4.ValueSet? documentType;
    r4.ValueSet? practiceSetting;
    r4.ValueSet? facilityType;
    r4.ValueSet? securityLabel;
    r4.ValueSet? eventCode;
    r4.ValueSet? attachmentFormat;
    r4.ValueSet? attachmentContentType;

    if (documentClassPath != null) {
      final json = jsonDecode(await rootBundle.loadString(documentClassPath));
      documentClass = r4.ValueSet.fromJson(json);
    }

    if (documentTypePath != null) {
      final json = jsonDecode(await rootBundle.loadString(documentTypePath));
      documentType = r4.ValueSet.fromJson(json);
    }

    if (practiceSettingPath != null) {
      final json = jsonDecode(await rootBundle.loadString(practiceSettingPath));
      practiceSetting = r4.ValueSet.fromJson(json);
    }

    if (facilityTypePath != null) {
      final json = jsonDecode(await rootBundle.loadString(facilityTypePath));
      facilityType = r4.ValueSet.fromJson(json);
    }

    if (securityLabelPath != null) {
      final json = jsonDecode(await rootBundle.loadString(securityLabelPath));
      securityLabel = r4.ValueSet.fromJson(json);
    }

    if (eventCodePath != null) {
      final json = jsonDecode(await rootBundle.loadString(eventCodePath));
      eventCode = r4.ValueSet.fromJson(json);
    }

    if (attachmentFormatPath != null) {
      final json =
          jsonDecode(await rootBundle.loadString(attachmentFormatPath));
      attachmentFormat = r4.ValueSet.fromJson(json);
    }

    if (attachmentContentTypePath != null) {
      final json =
          jsonDecode(await rootBundle.loadString(attachmentContentTypePath));
      attachmentContentType = r4.ValueSet.fromJson(json);
    }

    return ValueSetData(
      documentClass: documentClass,
      documentType: documentType,
      practiceSetting: practiceSetting,
      facilityType: facilityType,
      securityLabel: securityLabel,
      eventCode: eventCode,
      attachmentFormat: attachmentFormat,
      attachmentContentType: attachmentContentType,
    );
  }
}
