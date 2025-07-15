// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_connection.dart';

// ignore_for_file: type=lint
class $TenantTable extends Tenant with TableInfo<$TenantTable, TenantData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tenantIDMeta = const VerificationMeta(
    'tenantID',
  );
  @override
  late final GeneratedColumn<int> tenantID = GeneratedColumn<int>(
    'tenant_i_d',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mobileNoMeta = const VerificationMeta(
    'mobileNo',
  );
  @override
  late final GeneratedColumn<String> mobileNo = GeneratedColumn<String>(
    'mobile_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aadharNoMeta = const VerificationMeta(
    'aadharNo',
  );
  @override
  late final GeneratedColumn<String> aadharNo = GeneratedColumn<String>(
    'aadhar_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _permanentAddressMeta = const VerificationMeta(
    'permanentAddress',
  );
  @override
  late final GeneratedColumn<String> permanentAddress = GeneratedColumn<String>(
    'permanent_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emergencyContactMeta = const VerificationMeta(
    'emergencyContact',
  );
  @override
  late final GeneratedColumn<String> emergencyContact = GeneratedColumn<String>(
    'emergency_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agreementPeriodMeta = const VerificationMeta(
    'agreementPeriod',
  );
  @override
  late final GeneratedColumn<int> agreementPeriod = GeneratedColumn<int>(
    'agreement_period',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  aadharImages = GeneratedColumn<String>(
    'aadhar_images',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<String>>($TenantTable.$converteraadharImages);
  static const VerificationMeta _agreementDoneMeta = const VerificationMeta(
    'agreementDone',
  );
  @override
  late final GeneratedColumn<bool> agreementDone = GeneratedColumn<bool>(
    'agreement_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("agreement_done" IN (0, 1))',
    ),
  );
  static const VerificationMeta _rentPerMonthMeta = const VerificationMeta(
    'rentPerMonth',
  );
  @override
  late final GeneratedColumn<double> rentPerMonth = GeneratedColumn<double>(
    'rent_per_month',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _advancePaymentMeta = const VerificationMeta(
    'advancePayment',
  );
  @override
  late final GeneratedColumn<double> advancePayment = GeneratedColumn<double>(
    'advance_payment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDueAmountMeta = const VerificationMeta(
    'totalDueAmount',
  );
  @override
  late final GeneratedColumn<double> totalDueAmount = GeneratedColumn<double>(
    'total_due_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthEnteredMeta = const VerificationMeta(
    'monthEntered',
  );
  @override
  late final GeneratedColumn<DateTime> monthEntered = GeneratedColumn<DateTime>(
    'month_entered',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthExitMeta = const VerificationMeta(
    'monthExit',
  );
  @override
  late final GeneratedColumn<DateTime> monthExit = GeneratedColumn<DateTime>(
    'month_exit',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meterReadingInitialMeta =
      const VerificationMeta('meterReadingInitial');
  @override
  late final GeneratedColumn<double> meterReadingInitial =
      GeneratedColumn<double>(
        'meter_reading_initial',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _meterReadingFinalMeta = const VerificationMeta(
    'meterReadingFinal',
  );
  @override
  late final GeneratedColumn<double> meterReadingFinal =
      GeneratedColumn<double>(
        'meter_reading_final',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _electricityRateMeta = const VerificationMeta(
    'electricityRate',
  );
  @override
  late final GeneratedColumn<double> electricityRate = GeneratedColumn<double>(
    'electricity_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterChargesMeta = const VerificationMeta(
    'waterCharges',
  );
  @override
  late final GeneratedColumn<double> waterCharges = GeneratedColumn<double>(
    'water_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perYearIncrementMeta = const VerificationMeta(
    'perYearIncrement',
  );
  @override
  late final GeneratedColumn<double> perYearIncrement = GeneratedColumn<double>(
    'per_year_increment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tenantID,
    name,
    mobileNo,
    aadharNo,
    permanentAddress,
    emergencyContact,
    agreementPeriod,
    aadharImages,
    agreementDone,
    rentPerMonth,
    advancePayment,
    totalDueAmount,
    monthEntered,
    monthExit,
    meterReadingInitial,
    meterReadingFinal,
    electricityRate,
    waterCharges,
    perYearIncrement,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenant';
  @override
  VerificationContext validateIntegrity(
    Insertable<TenantData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tenant_i_d')) {
      context.handle(
        _tenantIDMeta,
        tenantID.isAcceptableOrUnknown(data['tenant_i_d']!, _tenantIDMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('mobile_no')) {
      context.handle(
        _mobileNoMeta,
        mobileNo.isAcceptableOrUnknown(data['mobile_no']!, _mobileNoMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileNoMeta);
    }
    if (data.containsKey('aadhar_no')) {
      context.handle(
        _aadharNoMeta,
        aadharNo.isAcceptableOrUnknown(data['aadhar_no']!, _aadharNoMeta),
      );
    } else if (isInserting) {
      context.missing(_aadharNoMeta);
    }
    if (data.containsKey('permanent_address')) {
      context.handle(
        _permanentAddressMeta,
        permanentAddress.isAcceptableOrUnknown(
          data['permanent_address']!,
          _permanentAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_permanentAddressMeta);
    }
    if (data.containsKey('emergency_contact')) {
      context.handle(
        _emergencyContactMeta,
        emergencyContact.isAcceptableOrUnknown(
          data['emergency_contact']!,
          _emergencyContactMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emergencyContactMeta);
    }
    if (data.containsKey('agreement_period')) {
      context.handle(
        _agreementPeriodMeta,
        agreementPeriod.isAcceptableOrUnknown(
          data['agreement_period']!,
          _agreementPeriodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agreementPeriodMeta);
    }
    if (data.containsKey('agreement_done')) {
      context.handle(
        _agreementDoneMeta,
        agreementDone.isAcceptableOrUnknown(
          data['agreement_done']!,
          _agreementDoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agreementDoneMeta);
    }
    if (data.containsKey('rent_per_month')) {
      context.handle(
        _rentPerMonthMeta,
        rentPerMonth.isAcceptableOrUnknown(
          data['rent_per_month']!,
          _rentPerMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rentPerMonthMeta);
    }
    if (data.containsKey('advance_payment')) {
      context.handle(
        _advancePaymentMeta,
        advancePayment.isAcceptableOrUnknown(
          data['advance_payment']!,
          _advancePaymentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_advancePaymentMeta);
    }
    if (data.containsKey('total_due_amount')) {
      context.handle(
        _totalDueAmountMeta,
        totalDueAmount.isAcceptableOrUnknown(
          data['total_due_amount']!,
          _totalDueAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDueAmountMeta);
    }
    if (data.containsKey('month_entered')) {
      context.handle(
        _monthEnteredMeta,
        monthEntered.isAcceptableOrUnknown(
          data['month_entered']!,
          _monthEnteredMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthEnteredMeta);
    }
    if (data.containsKey('month_exit')) {
      context.handle(
        _monthExitMeta,
        monthExit.isAcceptableOrUnknown(data['month_exit']!, _monthExitMeta),
      );
    }
    if (data.containsKey('meter_reading_initial')) {
      context.handle(
        _meterReadingInitialMeta,
        meterReadingInitial.isAcceptableOrUnknown(
          data['meter_reading_initial']!,
          _meterReadingInitialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meterReadingInitialMeta);
    }
    if (data.containsKey('meter_reading_final')) {
      context.handle(
        _meterReadingFinalMeta,
        meterReadingFinal.isAcceptableOrUnknown(
          data['meter_reading_final']!,
          _meterReadingFinalMeta,
        ),
      );
    }
    if (data.containsKey('electricity_rate')) {
      context.handle(
        _electricityRateMeta,
        electricityRate.isAcceptableOrUnknown(
          data['electricity_rate']!,
          _electricityRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_electricityRateMeta);
    }
    if (data.containsKey('water_charges')) {
      context.handle(
        _waterChargesMeta,
        waterCharges.isAcceptableOrUnknown(
          data['water_charges']!,
          _waterChargesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waterChargesMeta);
    }
    if (data.containsKey('per_year_increment')) {
      context.handle(
        _perYearIncrementMeta,
        perYearIncrement.isAcceptableOrUnknown(
          data['per_year_increment']!,
          _perYearIncrementMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_perYearIncrementMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tenantID};
  @override
  TenantData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantData(
      tenantID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_i_d'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mobileNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile_no'],
      )!,
      aadharNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aadhar_no'],
      )!,
      permanentAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permanent_address'],
      )!,
      emergencyContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact'],
      )!,
      agreementPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agreement_period'],
      )!,
      aadharImages: $TenantTable.$converteraadharImages.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}aadhar_images'],
        )!,
      ),
      agreementDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}agreement_done'],
      )!,
      rentPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rent_per_month'],
      )!,
      advancePayment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}advance_payment'],
      )!,
      totalDueAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_due_amount'],
      )!,
      monthEntered: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}month_entered'],
      )!,
      monthExit: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}month_exit'],
      ),
      meterReadingInitial: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_reading_initial'],
      )!,
      meterReadingFinal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_reading_final'],
      ),
      electricityRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}electricity_rate'],
      )!,
      waterCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_charges'],
      )!,
      perYearIncrement: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}per_year_increment'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TenantTable createAlias(String alias) {
    return $TenantTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converteraadharImages =
      const StringListConverter();
}

class TenantData extends DataClass implements Insertable<TenantData> {
  final int tenantID;
  final String name;
  final String mobileNo;
  final String aadharNo;
  final String permanentAddress;
  final String emergencyContact;
  final int agreementPeriod;
  final List<String> aadharImages;
  final bool agreementDone;
  final double rentPerMonth;
  final double advancePayment;
  final double totalDueAmount;
  final DateTime monthEntered;
  final DateTime? monthExit;
  final double meterReadingInitial;
  final double? meterReadingFinal;
  final double electricityRate;
  final double waterCharges;
  final double perYearIncrement;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TenantData({
    required this.tenantID,
    required this.name,
    required this.mobileNo,
    required this.aadharNo,
    required this.permanentAddress,
    required this.emergencyContact,
    required this.agreementPeriod,
    required this.aadharImages,
    required this.agreementDone,
    required this.rentPerMonth,
    required this.advancePayment,
    required this.totalDueAmount,
    required this.monthEntered,
    this.monthExit,
    required this.meterReadingInitial,
    this.meterReadingFinal,
    required this.electricityRate,
    required this.waterCharges,
    required this.perYearIncrement,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tenant_i_d'] = Variable<int>(tenantID);
    map['name'] = Variable<String>(name);
    map['mobile_no'] = Variable<String>(mobileNo);
    map['aadhar_no'] = Variable<String>(aadharNo);
    map['permanent_address'] = Variable<String>(permanentAddress);
    map['emergency_contact'] = Variable<String>(emergencyContact);
    map['agreement_period'] = Variable<int>(agreementPeriod);
    {
      map['aadhar_images'] = Variable<String>(
        $TenantTable.$converteraadharImages.toSql(aadharImages),
      );
    }
    map['agreement_done'] = Variable<bool>(agreementDone);
    map['rent_per_month'] = Variable<double>(rentPerMonth);
    map['advance_payment'] = Variable<double>(advancePayment);
    map['total_due_amount'] = Variable<double>(totalDueAmount);
    map['month_entered'] = Variable<DateTime>(monthEntered);
    if (!nullToAbsent || monthExit != null) {
      map['month_exit'] = Variable<DateTime>(monthExit);
    }
    map['meter_reading_initial'] = Variable<double>(meterReadingInitial);
    if (!nullToAbsent || meterReadingFinal != null) {
      map['meter_reading_final'] = Variable<double>(meterReadingFinal);
    }
    map['electricity_rate'] = Variable<double>(electricityRate);
    map['water_charges'] = Variable<double>(waterCharges);
    map['per_year_increment'] = Variable<double>(perYearIncrement);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenantCompanion toCompanion(bool nullToAbsent) {
    return TenantCompanion(
      tenantID: Value(tenantID),
      name: Value(name),
      mobileNo: Value(mobileNo),
      aadharNo: Value(aadharNo),
      permanentAddress: Value(permanentAddress),
      emergencyContact: Value(emergencyContact),
      agreementPeriod: Value(agreementPeriod),
      aadharImages: Value(aadharImages),
      agreementDone: Value(agreementDone),
      rentPerMonth: Value(rentPerMonth),
      advancePayment: Value(advancePayment),
      totalDueAmount: Value(totalDueAmount),
      monthEntered: Value(monthEntered),
      monthExit: monthExit == null && nullToAbsent
          ? const Value.absent()
          : Value(monthExit),
      meterReadingInitial: Value(meterReadingInitial),
      meterReadingFinal: meterReadingFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(meterReadingFinal),
      electricityRate: Value(electricityRate),
      waterCharges: Value(waterCharges),
      perYearIncrement: Value(perYearIncrement),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TenantData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantData(
      tenantID: serializer.fromJson<int>(json['tenantID']),
      name: serializer.fromJson<String>(json['name']),
      mobileNo: serializer.fromJson<String>(json['mobileNo']),
      aadharNo: serializer.fromJson<String>(json['aadharNo']),
      permanentAddress: serializer.fromJson<String>(json['permanentAddress']),
      emergencyContact: serializer.fromJson<String>(json['emergencyContact']),
      agreementPeriod: serializer.fromJson<int>(json['agreementPeriod']),
      aadharImages: serializer.fromJson<List<String>>(json['aadharImages']),
      agreementDone: serializer.fromJson<bool>(json['agreementDone']),
      rentPerMonth: serializer.fromJson<double>(json['rentPerMonth']),
      advancePayment: serializer.fromJson<double>(json['advancePayment']),
      totalDueAmount: serializer.fromJson<double>(json['totalDueAmount']),
      monthEntered: serializer.fromJson<DateTime>(json['monthEntered']),
      monthExit: serializer.fromJson<DateTime?>(json['monthExit']),
      meterReadingInitial: serializer.fromJson<double>(
        json['meterReadingInitial'],
      ),
      meterReadingFinal: serializer.fromJson<double?>(
        json['meterReadingFinal'],
      ),
      electricityRate: serializer.fromJson<double>(json['electricityRate']),
      waterCharges: serializer.fromJson<double>(json['waterCharges']),
      perYearIncrement: serializer.fromJson<double>(json['perYearIncrement']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tenantID': serializer.toJson<int>(tenantID),
      'name': serializer.toJson<String>(name),
      'mobileNo': serializer.toJson<String>(mobileNo),
      'aadharNo': serializer.toJson<String>(aadharNo),
      'permanentAddress': serializer.toJson<String>(permanentAddress),
      'emergencyContact': serializer.toJson<String>(emergencyContact),
      'agreementPeriod': serializer.toJson<int>(agreementPeriod),
      'aadharImages': serializer.toJson<List<String>>(aadharImages),
      'agreementDone': serializer.toJson<bool>(agreementDone),
      'rentPerMonth': serializer.toJson<double>(rentPerMonth),
      'advancePayment': serializer.toJson<double>(advancePayment),
      'totalDueAmount': serializer.toJson<double>(totalDueAmount),
      'monthEntered': serializer.toJson<DateTime>(monthEntered),
      'monthExit': serializer.toJson<DateTime?>(monthExit),
      'meterReadingInitial': serializer.toJson<double>(meterReadingInitial),
      'meterReadingFinal': serializer.toJson<double?>(meterReadingFinal),
      'electricityRate': serializer.toJson<double>(electricityRate),
      'waterCharges': serializer.toJson<double>(waterCharges),
      'perYearIncrement': serializer.toJson<double>(perYearIncrement),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TenantData copyWith({
    int? tenantID,
    String? name,
    String? mobileNo,
    String? aadharNo,
    String? permanentAddress,
    String? emergencyContact,
    int? agreementPeriod,
    List<String>? aadharImages,
    bool? agreementDone,
    double? rentPerMonth,
    double? advancePayment,
    double? totalDueAmount,
    DateTime? monthEntered,
    Value<DateTime?> monthExit = const Value.absent(),
    double? meterReadingInitial,
    Value<double?> meterReadingFinal = const Value.absent(),
    double? electricityRate,
    double? waterCharges,
    double? perYearIncrement,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TenantData(
    tenantID: tenantID ?? this.tenantID,
    name: name ?? this.name,
    mobileNo: mobileNo ?? this.mobileNo,
    aadharNo: aadharNo ?? this.aadharNo,
    permanentAddress: permanentAddress ?? this.permanentAddress,
    emergencyContact: emergencyContact ?? this.emergencyContact,
    agreementPeriod: agreementPeriod ?? this.agreementPeriod,
    aadharImages: aadharImages ?? this.aadharImages,
    agreementDone: agreementDone ?? this.agreementDone,
    rentPerMonth: rentPerMonth ?? this.rentPerMonth,
    advancePayment: advancePayment ?? this.advancePayment,
    totalDueAmount: totalDueAmount ?? this.totalDueAmount,
    monthEntered: monthEntered ?? this.monthEntered,
    monthExit: monthExit.present ? monthExit.value : this.monthExit,
    meterReadingInitial: meterReadingInitial ?? this.meterReadingInitial,
    meterReadingFinal: meterReadingFinal.present
        ? meterReadingFinal.value
        : this.meterReadingFinal,
    electricityRate: electricityRate ?? this.electricityRate,
    waterCharges: waterCharges ?? this.waterCharges,
    perYearIncrement: perYearIncrement ?? this.perYearIncrement,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TenantData copyWithCompanion(TenantCompanion data) {
    return TenantData(
      tenantID: data.tenantID.present ? data.tenantID.value : this.tenantID,
      name: data.name.present ? data.name.value : this.name,
      mobileNo: data.mobileNo.present ? data.mobileNo.value : this.mobileNo,
      aadharNo: data.aadharNo.present ? data.aadharNo.value : this.aadharNo,
      permanentAddress: data.permanentAddress.present
          ? data.permanentAddress.value
          : this.permanentAddress,
      emergencyContact: data.emergencyContact.present
          ? data.emergencyContact.value
          : this.emergencyContact,
      agreementPeriod: data.agreementPeriod.present
          ? data.agreementPeriod.value
          : this.agreementPeriod,
      aadharImages: data.aadharImages.present
          ? data.aadharImages.value
          : this.aadharImages,
      agreementDone: data.agreementDone.present
          ? data.agreementDone.value
          : this.agreementDone,
      rentPerMonth: data.rentPerMonth.present
          ? data.rentPerMonth.value
          : this.rentPerMonth,
      advancePayment: data.advancePayment.present
          ? data.advancePayment.value
          : this.advancePayment,
      totalDueAmount: data.totalDueAmount.present
          ? data.totalDueAmount.value
          : this.totalDueAmount,
      monthEntered: data.monthEntered.present
          ? data.monthEntered.value
          : this.monthEntered,
      monthExit: data.monthExit.present ? data.monthExit.value : this.monthExit,
      meterReadingInitial: data.meterReadingInitial.present
          ? data.meterReadingInitial.value
          : this.meterReadingInitial,
      meterReadingFinal: data.meterReadingFinal.present
          ? data.meterReadingFinal.value
          : this.meterReadingFinal,
      electricityRate: data.electricityRate.present
          ? data.electricityRate.value
          : this.electricityRate,
      waterCharges: data.waterCharges.present
          ? data.waterCharges.value
          : this.waterCharges,
      perYearIncrement: data.perYearIncrement.present
          ? data.perYearIncrement.value
          : this.perYearIncrement,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantData(')
          ..write('tenantID: $tenantID, ')
          ..write('name: $name, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('aadharNo: $aadharNo, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('agreementPeriod: $agreementPeriod, ')
          ..write('aadharImages: $aadharImages, ')
          ..write('agreementDone: $agreementDone, ')
          ..write('rentPerMonth: $rentPerMonth, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('totalDueAmount: $totalDueAmount, ')
          ..write('monthEntered: $monthEntered, ')
          ..write('monthExit: $monthExit, ')
          ..write('meterReadingInitial: $meterReadingInitial, ')
          ..write('meterReadingFinal: $meterReadingFinal, ')
          ..write('electricityRate: $electricityRate, ')
          ..write('waterCharges: $waterCharges, ')
          ..write('perYearIncrement: $perYearIncrement, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    tenantID,
    name,
    mobileNo,
    aadharNo,
    permanentAddress,
    emergencyContact,
    agreementPeriod,
    aadharImages,
    agreementDone,
    rentPerMonth,
    advancePayment,
    totalDueAmount,
    monthEntered,
    monthExit,
    meterReadingInitial,
    meterReadingFinal,
    electricityRate,
    waterCharges,
    perYearIncrement,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantData &&
          other.tenantID == this.tenantID &&
          other.name == this.name &&
          other.mobileNo == this.mobileNo &&
          other.aadharNo == this.aadharNo &&
          other.permanentAddress == this.permanentAddress &&
          other.emergencyContact == this.emergencyContact &&
          other.agreementPeriod == this.agreementPeriod &&
          other.aadharImages == this.aadharImages &&
          other.agreementDone == this.agreementDone &&
          other.rentPerMonth == this.rentPerMonth &&
          other.advancePayment == this.advancePayment &&
          other.totalDueAmount == this.totalDueAmount &&
          other.monthEntered == this.monthEntered &&
          other.monthExit == this.monthExit &&
          other.meterReadingInitial == this.meterReadingInitial &&
          other.meterReadingFinal == this.meterReadingFinal &&
          other.electricityRate == this.electricityRate &&
          other.waterCharges == this.waterCharges &&
          other.perYearIncrement == this.perYearIncrement &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TenantCompanion extends UpdateCompanion<TenantData> {
  final Value<int> tenantID;
  final Value<String> name;
  final Value<String> mobileNo;
  final Value<String> aadharNo;
  final Value<String> permanentAddress;
  final Value<String> emergencyContact;
  final Value<int> agreementPeriod;
  final Value<List<String>> aadharImages;
  final Value<bool> agreementDone;
  final Value<double> rentPerMonth;
  final Value<double> advancePayment;
  final Value<double> totalDueAmount;
  final Value<DateTime> monthEntered;
  final Value<DateTime?> monthExit;
  final Value<double> meterReadingInitial;
  final Value<double?> meterReadingFinal;
  final Value<double> electricityRate;
  final Value<double> waterCharges;
  final Value<double> perYearIncrement;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TenantCompanion({
    this.tenantID = const Value.absent(),
    this.name = const Value.absent(),
    this.mobileNo = const Value.absent(),
    this.aadharNo = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.agreementPeriod = const Value.absent(),
    this.aadharImages = const Value.absent(),
    this.agreementDone = const Value.absent(),
    this.rentPerMonth = const Value.absent(),
    this.advancePayment = const Value.absent(),
    this.totalDueAmount = const Value.absent(),
    this.monthEntered = const Value.absent(),
    this.monthExit = const Value.absent(),
    this.meterReadingInitial = const Value.absent(),
    this.meterReadingFinal = const Value.absent(),
    this.electricityRate = const Value.absent(),
    this.waterCharges = const Value.absent(),
    this.perYearIncrement = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TenantCompanion.insert({
    this.tenantID = const Value.absent(),
    required String name,
    required String mobileNo,
    required String aadharNo,
    required String permanentAddress,
    required String emergencyContact,
    required int agreementPeriod,
    this.aadharImages = const Value.absent(),
    required bool agreementDone,
    required double rentPerMonth,
    required double advancePayment,
    required double totalDueAmount,
    required DateTime monthEntered,
    this.monthExit = const Value.absent(),
    required double meterReadingInitial,
    this.meterReadingFinal = const Value.absent(),
    required double electricityRate,
    required double waterCharges,
    required double perYearIncrement,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       mobileNo = Value(mobileNo),
       aadharNo = Value(aadharNo),
       permanentAddress = Value(permanentAddress),
       emergencyContact = Value(emergencyContact),
       agreementPeriod = Value(agreementPeriod),
       agreementDone = Value(agreementDone),
       rentPerMonth = Value(rentPerMonth),
       advancePayment = Value(advancePayment),
       totalDueAmount = Value(totalDueAmount),
       monthEntered = Value(monthEntered),
       meterReadingInitial = Value(meterReadingInitial),
       electricityRate = Value(electricityRate),
       waterCharges = Value(waterCharges),
       perYearIncrement = Value(perYearIncrement);
  static Insertable<TenantData> custom({
    Expression<int>? tenantID,
    Expression<String>? name,
    Expression<String>? mobileNo,
    Expression<String>? aadharNo,
    Expression<String>? permanentAddress,
    Expression<String>? emergencyContact,
    Expression<int>? agreementPeriod,
    Expression<String>? aadharImages,
    Expression<bool>? agreementDone,
    Expression<double>? rentPerMonth,
    Expression<double>? advancePayment,
    Expression<double>? totalDueAmount,
    Expression<DateTime>? monthEntered,
    Expression<DateTime>? monthExit,
    Expression<double>? meterReadingInitial,
    Expression<double>? meterReadingFinal,
    Expression<double>? electricityRate,
    Expression<double>? waterCharges,
    Expression<double>? perYearIncrement,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (tenantID != null) 'tenant_i_d': tenantID,
      if (name != null) 'name': name,
      if (mobileNo != null) 'mobile_no': mobileNo,
      if (aadharNo != null) 'aadhar_no': aadharNo,
      if (permanentAddress != null) 'permanent_address': permanentAddress,
      if (emergencyContact != null) 'emergency_contact': emergencyContact,
      if (agreementPeriod != null) 'agreement_period': agreementPeriod,
      if (aadharImages != null) 'aadhar_images': aadharImages,
      if (agreementDone != null) 'agreement_done': agreementDone,
      if (rentPerMonth != null) 'rent_per_month': rentPerMonth,
      if (advancePayment != null) 'advance_payment': advancePayment,
      if (totalDueAmount != null) 'total_due_amount': totalDueAmount,
      if (monthEntered != null) 'month_entered': monthEntered,
      if (monthExit != null) 'month_exit': monthExit,
      if (meterReadingInitial != null)
        'meter_reading_initial': meterReadingInitial,
      if (meterReadingFinal != null) 'meter_reading_final': meterReadingFinal,
      if (electricityRate != null) 'electricity_rate': electricityRate,
      if (waterCharges != null) 'water_charges': waterCharges,
      if (perYearIncrement != null) 'per_year_increment': perYearIncrement,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TenantCompanion copyWith({
    Value<int>? tenantID,
    Value<String>? name,
    Value<String>? mobileNo,
    Value<String>? aadharNo,
    Value<String>? permanentAddress,
    Value<String>? emergencyContact,
    Value<int>? agreementPeriod,
    Value<List<String>>? aadharImages,
    Value<bool>? agreementDone,
    Value<double>? rentPerMonth,
    Value<double>? advancePayment,
    Value<double>? totalDueAmount,
    Value<DateTime>? monthEntered,
    Value<DateTime?>? monthExit,
    Value<double>? meterReadingInitial,
    Value<double?>? meterReadingFinal,
    Value<double>? electricityRate,
    Value<double>? waterCharges,
    Value<double>? perYearIncrement,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TenantCompanion(
      tenantID: tenantID ?? this.tenantID,
      name: name ?? this.name,
      mobileNo: mobileNo ?? this.mobileNo,
      aadharNo: aadharNo ?? this.aadharNo,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      agreementPeriod: agreementPeriod ?? this.agreementPeriod,
      aadharImages: aadharImages ?? this.aadharImages,
      agreementDone: agreementDone ?? this.agreementDone,
      rentPerMonth: rentPerMonth ?? this.rentPerMonth,
      advancePayment: advancePayment ?? this.advancePayment,
      totalDueAmount: totalDueAmount ?? this.totalDueAmount,
      monthEntered: monthEntered ?? this.monthEntered,
      monthExit: monthExit ?? this.monthExit,
      meterReadingInitial: meterReadingInitial ?? this.meterReadingInitial,
      meterReadingFinal: meterReadingFinal ?? this.meterReadingFinal,
      electricityRate: electricityRate ?? this.electricityRate,
      waterCharges: waterCharges ?? this.waterCharges,
      perYearIncrement: perYearIncrement ?? this.perYearIncrement,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tenantID.present) {
      map['tenant_i_d'] = Variable<int>(tenantID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mobileNo.present) {
      map['mobile_no'] = Variable<String>(mobileNo.value);
    }
    if (aadharNo.present) {
      map['aadhar_no'] = Variable<String>(aadharNo.value);
    }
    if (permanentAddress.present) {
      map['permanent_address'] = Variable<String>(permanentAddress.value);
    }
    if (emergencyContact.present) {
      map['emergency_contact'] = Variable<String>(emergencyContact.value);
    }
    if (agreementPeriod.present) {
      map['agreement_period'] = Variable<int>(agreementPeriod.value);
    }
    if (aadharImages.present) {
      map['aadhar_images'] = Variable<String>(
        $TenantTable.$converteraadharImages.toSql(aadharImages.value),
      );
    }
    if (agreementDone.present) {
      map['agreement_done'] = Variable<bool>(agreementDone.value);
    }
    if (rentPerMonth.present) {
      map['rent_per_month'] = Variable<double>(rentPerMonth.value);
    }
    if (advancePayment.present) {
      map['advance_payment'] = Variable<double>(advancePayment.value);
    }
    if (totalDueAmount.present) {
      map['total_due_amount'] = Variable<double>(totalDueAmount.value);
    }
    if (monthEntered.present) {
      map['month_entered'] = Variable<DateTime>(monthEntered.value);
    }
    if (monthExit.present) {
      map['month_exit'] = Variable<DateTime>(monthExit.value);
    }
    if (meterReadingInitial.present) {
      map['meter_reading_initial'] = Variable<double>(
        meterReadingInitial.value,
      );
    }
    if (meterReadingFinal.present) {
      map['meter_reading_final'] = Variable<double>(meterReadingFinal.value);
    }
    if (electricityRate.present) {
      map['electricity_rate'] = Variable<double>(electricityRate.value);
    }
    if (waterCharges.present) {
      map['water_charges'] = Variable<double>(waterCharges.value);
    }
    if (perYearIncrement.present) {
      map['per_year_increment'] = Variable<double>(perYearIncrement.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantCompanion(')
          ..write('tenantID: $tenantID, ')
          ..write('name: $name, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('aadharNo: $aadharNo, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('agreementPeriod: $agreementPeriod, ')
          ..write('aadharImages: $aadharImages, ')
          ..write('agreementDone: $agreementDone, ')
          ..write('rentPerMonth: $rentPerMonth, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('totalDueAmount: $totalDueAmount, ')
          ..write('monthEntered: $monthEntered, ')
          ..write('monthExit: $monthExit, ')
          ..write('meterReadingInitial: $meterReadingInitial, ')
          ..write('meterReadingFinal: $meterReadingFinal, ')
          ..write('electricityRate: $electricityRate, ')
          ..write('waterCharges: $waterCharges, ')
          ..write('perYearIncrement: $perYearIncrement, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RentTable extends Rent with TableInfo<$RentTable, RentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rentIDMeta = const VerificationMeta('rentID');
  @override
  late final GeneratedColumn<int> rentID = GeneratedColumn<int>(
    'rent_i_d',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tenantIDMeta = const VerificationMeta(
    'tenantID',
  );
  @override
  late final GeneratedColumn<int> tenantID = GeneratedColumn<int>(
    'tenant_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenant (tenant_i_d)',
    ),
  );
  static const VerificationMeta _rentPerMonthMeta = const VerificationMeta(
    'rentPerMonth',
  );
  @override
  late final GeneratedColumn<double> rentPerMonth = GeneratedColumn<double>(
    'rent_per_month',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenant (rent_per_month)',
    ),
  );
  static const VerificationMeta _electricityRateMeta = const VerificationMeta(
    'electricityRate',
  );
  @override
  late final GeneratedColumn<double> electricityRate = GeneratedColumn<double>(
    'electricity_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenant (electricity_rate)',
    ),
  );
  static const VerificationMeta _rentPaidMeta = const VerificationMeta(
    'rentPaid',
  );
  @override
  late final GeneratedColumn<bool> rentPaid = GeneratedColumn<bool>(
    'rent_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("rent_paid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currentDueAmountMeta = const VerificationMeta(
    'currentDueAmount',
  );
  @override
  late final GeneratedColumn<double> currentDueAmount = GeneratedColumn<double>(
    'current_due_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalDueAmountMeta = const VerificationMeta(
    'totalDueAmount',
  );
  @override
  late final GeneratedColumn<double> totalDueAmount = GeneratedColumn<double>(
    'total_due_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenant (total_due_amount)',
    ),
  );
  static const VerificationMeta _amountPaidOnMeta = const VerificationMeta(
    'amountPaidOn',
  );
  @override
  late final GeneratedColumn<DateTime> amountPaidOn = GeneratedColumn<DateTime>(
    'amount_paid_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meterReadingLastMonthMeta =
      const VerificationMeta('meterReadingLastMonth');
  @override
  late final GeneratedColumn<double> meterReadingLastMonth =
      GeneratedColumn<double>(
        'meter_reading_last_month',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _meterReadingThisMonthMeta =
      const VerificationMeta('meterReadingThisMonth');
  @override
  late final GeneratedColumn<double> meterReadingThisMonth =
      GeneratedColumn<double>(
        'meter_reading_this_month',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalRentForMonthMeta = const VerificationMeta(
    'totalRentForMonth',
  );
  @override
  late final GeneratedColumn<double> totalRentForMonth =
      GeneratedColumn<double>(
        'total_rent_for_month',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _rentMonthMeta = const VerificationMeta(
    'rentMonth',
  );
  @override
  late final GeneratedColumn<DateTime> rentMonth = GeneratedColumn<DateTime>(
    'rent_month',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rentID,
    tenantID,
    rentPerMonth,
    electricityRate,
    rentPaid,
    currentDueAmount,
    totalDueAmount,
    amountPaidOn,
    meterReadingLastMonth,
    meterReadingThisMonth,
    paymentMode,
    totalRentForMonth,
    rentMonth,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rent';
  @override
  VerificationContext validateIntegrity(
    Insertable<RentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('rent_i_d')) {
      context.handle(
        _rentIDMeta,
        rentID.isAcceptableOrUnknown(data['rent_i_d']!, _rentIDMeta),
      );
    }
    if (data.containsKey('tenant_i_d')) {
      context.handle(
        _tenantIDMeta,
        tenantID.isAcceptableOrUnknown(data['tenant_i_d']!, _tenantIDMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIDMeta);
    }
    if (data.containsKey('rent_per_month')) {
      context.handle(
        _rentPerMonthMeta,
        rentPerMonth.isAcceptableOrUnknown(
          data['rent_per_month']!,
          _rentPerMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rentPerMonthMeta);
    }
    if (data.containsKey('electricity_rate')) {
      context.handle(
        _electricityRateMeta,
        electricityRate.isAcceptableOrUnknown(
          data['electricity_rate']!,
          _electricityRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_electricityRateMeta);
    }
    if (data.containsKey('rent_paid')) {
      context.handle(
        _rentPaidMeta,
        rentPaid.isAcceptableOrUnknown(data['rent_paid']!, _rentPaidMeta),
      );
    }
    if (data.containsKey('current_due_amount')) {
      context.handle(
        _currentDueAmountMeta,
        currentDueAmount.isAcceptableOrUnknown(
          data['current_due_amount']!,
          _currentDueAmountMeta,
        ),
      );
    }
    if (data.containsKey('total_due_amount')) {
      context.handle(
        _totalDueAmountMeta,
        totalDueAmount.isAcceptableOrUnknown(
          data['total_due_amount']!,
          _totalDueAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDueAmountMeta);
    }
    if (data.containsKey('amount_paid_on')) {
      context.handle(
        _amountPaidOnMeta,
        amountPaidOn.isAcceptableOrUnknown(
          data['amount_paid_on']!,
          _amountPaidOnMeta,
        ),
      );
    }
    if (data.containsKey('meter_reading_last_month')) {
      context.handle(
        _meterReadingLastMonthMeta,
        meterReadingLastMonth.isAcceptableOrUnknown(
          data['meter_reading_last_month']!,
          _meterReadingLastMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meterReadingLastMonthMeta);
    }
    if (data.containsKey('meter_reading_this_month')) {
      context.handle(
        _meterReadingThisMonthMeta,
        meterReadingThisMonth.isAcceptableOrUnknown(
          data['meter_reading_this_month']!,
          _meterReadingThisMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meterReadingThisMonthMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('total_rent_for_month')) {
      context.handle(
        _totalRentForMonthMeta,
        totalRentForMonth.isAcceptableOrUnknown(
          data['total_rent_for_month']!,
          _totalRentForMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalRentForMonthMeta);
    }
    if (data.containsKey('rent_month')) {
      context.handle(
        _rentMonthMeta,
        rentMonth.isAcceptableOrUnknown(data['rent_month']!, _rentMonthMeta),
      );
    } else if (isInserting) {
      context.missing(_rentMonthMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rentID};
  @override
  RentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RentData(
      rentID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rent_i_d'],
      )!,
      tenantID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_i_d'],
      )!,
      rentPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rent_per_month'],
      )!,
      electricityRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}electricity_rate'],
      )!,
      rentPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}rent_paid'],
      )!,
      currentDueAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_due_amount'],
      )!,
      totalDueAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_due_amount'],
      )!,
      amountPaidOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}amount_paid_on'],
      ),
      meterReadingLastMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_reading_last_month'],
      )!,
      meterReadingThisMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meter_reading_this_month'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      ),
      totalRentForMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_rent_for_month'],
      )!,
      rentMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}rent_month'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RentTable createAlias(String alias) {
    return $RentTable(attachedDatabase, alias);
  }
}

class RentData extends DataClass implements Insertable<RentData> {
  final int rentID;
  final int tenantID;
  final double rentPerMonth;
  final double electricityRate;
  final bool rentPaid;
  final double currentDueAmount;
  final double totalDueAmount;
  final DateTime? amountPaidOn;
  final double meterReadingLastMonth;
  final double meterReadingThisMonth;
  final String? paymentMode;
  final double totalRentForMonth;
  final DateTime rentMonth;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RentData({
    required this.rentID,
    required this.tenantID,
    required this.rentPerMonth,
    required this.electricityRate,
    required this.rentPaid,
    required this.currentDueAmount,
    required this.totalDueAmount,
    this.amountPaidOn,
    required this.meterReadingLastMonth,
    required this.meterReadingThisMonth,
    this.paymentMode,
    required this.totalRentForMonth,
    required this.rentMonth,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['rent_i_d'] = Variable<int>(rentID);
    map['tenant_i_d'] = Variable<int>(tenantID);
    map['rent_per_month'] = Variable<double>(rentPerMonth);
    map['electricity_rate'] = Variable<double>(electricityRate);
    map['rent_paid'] = Variable<bool>(rentPaid);
    map['current_due_amount'] = Variable<double>(currentDueAmount);
    map['total_due_amount'] = Variable<double>(totalDueAmount);
    if (!nullToAbsent || amountPaidOn != null) {
      map['amount_paid_on'] = Variable<DateTime>(amountPaidOn);
    }
    map['meter_reading_last_month'] = Variable<double>(meterReadingLastMonth);
    map['meter_reading_this_month'] = Variable<double>(meterReadingThisMonth);
    if (!nullToAbsent || paymentMode != null) {
      map['payment_mode'] = Variable<String>(paymentMode);
    }
    map['total_rent_for_month'] = Variable<double>(totalRentForMonth);
    map['rent_month'] = Variable<DateTime>(rentMonth);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RentCompanion toCompanion(bool nullToAbsent) {
    return RentCompanion(
      rentID: Value(rentID),
      tenantID: Value(tenantID),
      rentPerMonth: Value(rentPerMonth),
      electricityRate: Value(electricityRate),
      rentPaid: Value(rentPaid),
      currentDueAmount: Value(currentDueAmount),
      totalDueAmount: Value(totalDueAmount),
      amountPaidOn: amountPaidOn == null && nullToAbsent
          ? const Value.absent()
          : Value(amountPaidOn),
      meterReadingLastMonth: Value(meterReadingLastMonth),
      meterReadingThisMonth: Value(meterReadingThisMonth),
      paymentMode: paymentMode == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMode),
      totalRentForMonth: Value(totalRentForMonth),
      rentMonth: Value(rentMonth),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RentData(
      rentID: serializer.fromJson<int>(json['rentID']),
      tenantID: serializer.fromJson<int>(json['tenantID']),
      rentPerMonth: serializer.fromJson<double>(json['rentPerMonth']),
      electricityRate: serializer.fromJson<double>(json['electricityRate']),
      rentPaid: serializer.fromJson<bool>(json['rentPaid']),
      currentDueAmount: serializer.fromJson<double>(json['currentDueAmount']),
      totalDueAmount: serializer.fromJson<double>(json['totalDueAmount']),
      amountPaidOn: serializer.fromJson<DateTime?>(json['amountPaidOn']),
      meterReadingLastMonth: serializer.fromJson<double>(
        json['meterReadingLastMonth'],
      ),
      meterReadingThisMonth: serializer.fromJson<double>(
        json['meterReadingThisMonth'],
      ),
      paymentMode: serializer.fromJson<String?>(json['paymentMode']),
      totalRentForMonth: serializer.fromJson<double>(json['totalRentForMonth']),
      rentMonth: serializer.fromJson<DateTime>(json['rentMonth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rentID': serializer.toJson<int>(rentID),
      'tenantID': serializer.toJson<int>(tenantID),
      'rentPerMonth': serializer.toJson<double>(rentPerMonth),
      'electricityRate': serializer.toJson<double>(electricityRate),
      'rentPaid': serializer.toJson<bool>(rentPaid),
      'currentDueAmount': serializer.toJson<double>(currentDueAmount),
      'totalDueAmount': serializer.toJson<double>(totalDueAmount),
      'amountPaidOn': serializer.toJson<DateTime?>(amountPaidOn),
      'meterReadingLastMonth': serializer.toJson<double>(meterReadingLastMonth),
      'meterReadingThisMonth': serializer.toJson<double>(meterReadingThisMonth),
      'paymentMode': serializer.toJson<String?>(paymentMode),
      'totalRentForMonth': serializer.toJson<double>(totalRentForMonth),
      'rentMonth': serializer.toJson<DateTime>(rentMonth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RentData copyWith({
    int? rentID,
    int? tenantID,
    double? rentPerMonth,
    double? electricityRate,
    bool? rentPaid,
    double? currentDueAmount,
    double? totalDueAmount,
    Value<DateTime?> amountPaidOn = const Value.absent(),
    double? meterReadingLastMonth,
    double? meterReadingThisMonth,
    Value<String?> paymentMode = const Value.absent(),
    double? totalRentForMonth,
    DateTime? rentMonth,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RentData(
    rentID: rentID ?? this.rentID,
    tenantID: tenantID ?? this.tenantID,
    rentPerMonth: rentPerMonth ?? this.rentPerMonth,
    electricityRate: electricityRate ?? this.electricityRate,
    rentPaid: rentPaid ?? this.rentPaid,
    currentDueAmount: currentDueAmount ?? this.currentDueAmount,
    totalDueAmount: totalDueAmount ?? this.totalDueAmount,
    amountPaidOn: amountPaidOn.present ? amountPaidOn.value : this.amountPaidOn,
    meterReadingLastMonth: meterReadingLastMonth ?? this.meterReadingLastMonth,
    meterReadingThisMonth: meterReadingThisMonth ?? this.meterReadingThisMonth,
    paymentMode: paymentMode.present ? paymentMode.value : this.paymentMode,
    totalRentForMonth: totalRentForMonth ?? this.totalRentForMonth,
    rentMonth: rentMonth ?? this.rentMonth,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RentData copyWithCompanion(RentCompanion data) {
    return RentData(
      rentID: data.rentID.present ? data.rentID.value : this.rentID,
      tenantID: data.tenantID.present ? data.tenantID.value : this.tenantID,
      rentPerMonth: data.rentPerMonth.present
          ? data.rentPerMonth.value
          : this.rentPerMonth,
      electricityRate: data.electricityRate.present
          ? data.electricityRate.value
          : this.electricityRate,
      rentPaid: data.rentPaid.present ? data.rentPaid.value : this.rentPaid,
      currentDueAmount: data.currentDueAmount.present
          ? data.currentDueAmount.value
          : this.currentDueAmount,
      totalDueAmount: data.totalDueAmount.present
          ? data.totalDueAmount.value
          : this.totalDueAmount,
      amountPaidOn: data.amountPaidOn.present
          ? data.amountPaidOn.value
          : this.amountPaidOn,
      meterReadingLastMonth: data.meterReadingLastMonth.present
          ? data.meterReadingLastMonth.value
          : this.meterReadingLastMonth,
      meterReadingThisMonth: data.meterReadingThisMonth.present
          ? data.meterReadingThisMonth.value
          : this.meterReadingThisMonth,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      totalRentForMonth: data.totalRentForMonth.present
          ? data.totalRentForMonth.value
          : this.totalRentForMonth,
      rentMonth: data.rentMonth.present ? data.rentMonth.value : this.rentMonth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RentData(')
          ..write('rentID: $rentID, ')
          ..write('tenantID: $tenantID, ')
          ..write('rentPerMonth: $rentPerMonth, ')
          ..write('electricityRate: $electricityRate, ')
          ..write('rentPaid: $rentPaid, ')
          ..write('currentDueAmount: $currentDueAmount, ')
          ..write('totalDueAmount: $totalDueAmount, ')
          ..write('amountPaidOn: $amountPaidOn, ')
          ..write('meterReadingLastMonth: $meterReadingLastMonth, ')
          ..write('meterReadingThisMonth: $meterReadingThisMonth, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('totalRentForMonth: $totalRentForMonth, ')
          ..write('rentMonth: $rentMonth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rentID,
    tenantID,
    rentPerMonth,
    electricityRate,
    rentPaid,
    currentDueAmount,
    totalDueAmount,
    amountPaidOn,
    meterReadingLastMonth,
    meterReadingThisMonth,
    paymentMode,
    totalRentForMonth,
    rentMonth,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RentData &&
          other.rentID == this.rentID &&
          other.tenantID == this.tenantID &&
          other.rentPerMonth == this.rentPerMonth &&
          other.electricityRate == this.electricityRate &&
          other.rentPaid == this.rentPaid &&
          other.currentDueAmount == this.currentDueAmount &&
          other.totalDueAmount == this.totalDueAmount &&
          other.amountPaidOn == this.amountPaidOn &&
          other.meterReadingLastMonth == this.meterReadingLastMonth &&
          other.meterReadingThisMonth == this.meterReadingThisMonth &&
          other.paymentMode == this.paymentMode &&
          other.totalRentForMonth == this.totalRentForMonth &&
          other.rentMonth == this.rentMonth &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RentCompanion extends UpdateCompanion<RentData> {
  final Value<int> rentID;
  final Value<int> tenantID;
  final Value<double> rentPerMonth;
  final Value<double> electricityRate;
  final Value<bool> rentPaid;
  final Value<double> currentDueAmount;
  final Value<double> totalDueAmount;
  final Value<DateTime?> amountPaidOn;
  final Value<double> meterReadingLastMonth;
  final Value<double> meterReadingThisMonth;
  final Value<String?> paymentMode;
  final Value<double> totalRentForMonth;
  final Value<DateTime> rentMonth;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RentCompanion({
    this.rentID = const Value.absent(),
    this.tenantID = const Value.absent(),
    this.rentPerMonth = const Value.absent(),
    this.electricityRate = const Value.absent(),
    this.rentPaid = const Value.absent(),
    this.currentDueAmount = const Value.absent(),
    this.totalDueAmount = const Value.absent(),
    this.amountPaidOn = const Value.absent(),
    this.meterReadingLastMonth = const Value.absent(),
    this.meterReadingThisMonth = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.totalRentForMonth = const Value.absent(),
    this.rentMonth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RentCompanion.insert({
    this.rentID = const Value.absent(),
    required int tenantID,
    required double rentPerMonth,
    required double electricityRate,
    this.rentPaid = const Value.absent(),
    this.currentDueAmount = const Value.absent(),
    required double totalDueAmount,
    this.amountPaidOn = const Value.absent(),
    required double meterReadingLastMonth,
    required double meterReadingThisMonth,
    this.paymentMode = const Value.absent(),
    required double totalRentForMonth,
    required DateTime rentMonth,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : tenantID = Value(tenantID),
       rentPerMonth = Value(rentPerMonth),
       electricityRate = Value(electricityRate),
       totalDueAmount = Value(totalDueAmount),
       meterReadingLastMonth = Value(meterReadingLastMonth),
       meterReadingThisMonth = Value(meterReadingThisMonth),
       totalRentForMonth = Value(totalRentForMonth),
       rentMonth = Value(rentMonth);
  static Insertable<RentData> custom({
    Expression<int>? rentID,
    Expression<int>? tenantID,
    Expression<double>? rentPerMonth,
    Expression<double>? electricityRate,
    Expression<bool>? rentPaid,
    Expression<double>? currentDueAmount,
    Expression<double>? totalDueAmount,
    Expression<DateTime>? amountPaidOn,
    Expression<double>? meterReadingLastMonth,
    Expression<double>? meterReadingThisMonth,
    Expression<String>? paymentMode,
    Expression<double>? totalRentForMonth,
    Expression<DateTime>? rentMonth,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rentID != null) 'rent_i_d': rentID,
      if (tenantID != null) 'tenant_i_d': tenantID,
      if (rentPerMonth != null) 'rent_per_month': rentPerMonth,
      if (electricityRate != null) 'electricity_rate': electricityRate,
      if (rentPaid != null) 'rent_paid': rentPaid,
      if (currentDueAmount != null) 'current_due_amount': currentDueAmount,
      if (totalDueAmount != null) 'total_due_amount': totalDueAmount,
      if (amountPaidOn != null) 'amount_paid_on': amountPaidOn,
      if (meterReadingLastMonth != null)
        'meter_reading_last_month': meterReadingLastMonth,
      if (meterReadingThisMonth != null)
        'meter_reading_this_month': meterReadingThisMonth,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (totalRentForMonth != null) 'total_rent_for_month': totalRentForMonth,
      if (rentMonth != null) 'rent_month': rentMonth,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RentCompanion copyWith({
    Value<int>? rentID,
    Value<int>? tenantID,
    Value<double>? rentPerMonth,
    Value<double>? electricityRate,
    Value<bool>? rentPaid,
    Value<double>? currentDueAmount,
    Value<double>? totalDueAmount,
    Value<DateTime?>? amountPaidOn,
    Value<double>? meterReadingLastMonth,
    Value<double>? meterReadingThisMonth,
    Value<String?>? paymentMode,
    Value<double>? totalRentForMonth,
    Value<DateTime>? rentMonth,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RentCompanion(
      rentID: rentID ?? this.rentID,
      tenantID: tenantID ?? this.tenantID,
      rentPerMonth: rentPerMonth ?? this.rentPerMonth,
      electricityRate: electricityRate ?? this.electricityRate,
      rentPaid: rentPaid ?? this.rentPaid,
      currentDueAmount: currentDueAmount ?? this.currentDueAmount,
      totalDueAmount: totalDueAmount ?? this.totalDueAmount,
      amountPaidOn: amountPaidOn ?? this.amountPaidOn,
      meterReadingLastMonth:
          meterReadingLastMonth ?? this.meterReadingLastMonth,
      meterReadingThisMonth:
          meterReadingThisMonth ?? this.meterReadingThisMonth,
      paymentMode: paymentMode ?? this.paymentMode,
      totalRentForMonth: totalRentForMonth ?? this.totalRentForMonth,
      rentMonth: rentMonth ?? this.rentMonth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rentID.present) {
      map['rent_i_d'] = Variable<int>(rentID.value);
    }
    if (tenantID.present) {
      map['tenant_i_d'] = Variable<int>(tenantID.value);
    }
    if (rentPerMonth.present) {
      map['rent_per_month'] = Variable<double>(rentPerMonth.value);
    }
    if (electricityRate.present) {
      map['electricity_rate'] = Variable<double>(electricityRate.value);
    }
    if (rentPaid.present) {
      map['rent_paid'] = Variable<bool>(rentPaid.value);
    }
    if (currentDueAmount.present) {
      map['current_due_amount'] = Variable<double>(currentDueAmount.value);
    }
    if (totalDueAmount.present) {
      map['total_due_amount'] = Variable<double>(totalDueAmount.value);
    }
    if (amountPaidOn.present) {
      map['amount_paid_on'] = Variable<DateTime>(amountPaidOn.value);
    }
    if (meterReadingLastMonth.present) {
      map['meter_reading_last_month'] = Variable<double>(
        meterReadingLastMonth.value,
      );
    }
    if (meterReadingThisMonth.present) {
      map['meter_reading_this_month'] = Variable<double>(
        meterReadingThisMonth.value,
      );
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (totalRentForMonth.present) {
      map['total_rent_for_month'] = Variable<double>(totalRentForMonth.value);
    }
    if (rentMonth.present) {
      map['rent_month'] = Variable<DateTime>(rentMonth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RentCompanion(')
          ..write('rentID: $rentID, ')
          ..write('tenantID: $tenantID, ')
          ..write('rentPerMonth: $rentPerMonth, ')
          ..write('electricityRate: $electricityRate, ')
          ..write('rentPaid: $rentPaid, ')
          ..write('currentDueAmount: $currentDueAmount, ')
          ..write('totalDueAmount: $totalDueAmount, ')
          ..write('amountPaidOn: $amountPaidOn, ')
          ..write('meterReadingLastMonth: $meterReadingLastMonth, ')
          ..write('meterReadingThisMonth: $meterReadingThisMonth, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('totalRentForMonth: $totalRentForMonth, ')
          ..write('rentMonth: $rentMonth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $OwnerTable extends Owner with TableInfo<$OwnerTable, OwnerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OwnerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerIDMeta = const VerificationMeta(
    'ownerID',
  );
  @override
  late final GeneratedColumn<int> ownerID = GeneratedColumn<int>(
    'owner_i_d',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyNameMeta = const VerificationMeta(
    'propertyName',
  );
  @override
  late final GeneratedColumn<String> propertyName = GeneratedColumn<String>(
    'property_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinCodeMeta = const VerificationMeta(
    'pinCode',
  );
  @override
  late final GeneratedColumn<String> pinCode = GeneratedColumn<String>(
    'pin_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _upiIDMeta = const VerificationMeta('upiID');
  @override
  late final GeneratedColumn<String> upiID = GeneratedColumn<String>(
    'upi_i_d',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerID,
    name,
    phone,
    propertyName,
    address,
    city,
    state,
    pinCode,
    upiID,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'owner';
  @override
  VerificationContext validateIntegrity(
    Insertable<OwnerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_i_d')) {
      context.handle(
        _ownerIDMeta,
        ownerID.isAcceptableOrUnknown(data['owner_i_d']!, _ownerIDMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('property_name')) {
      context.handle(
        _propertyNameMeta,
        propertyName.isAcceptableOrUnknown(
          data['property_name']!,
          _propertyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_propertyNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('pin_code')) {
      context.handle(
        _pinCodeMeta,
        pinCode.isAcceptableOrUnknown(data['pin_code']!, _pinCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (data.containsKey('upi_i_d')) {
      context.handle(
        _upiIDMeta,
        upiID.isAcceptableOrUnknown(data['upi_i_d']!, _upiIDMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerID};
  @override
  OwnerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OwnerData(
      ownerID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_i_d'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      propertyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      pinCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_code'],
      )!,
      upiID: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upi_i_d'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OwnerTable createAlias(String alias) {
    return $OwnerTable(attachedDatabase, alias);
  }
}

class OwnerData extends DataClass implements Insertable<OwnerData> {
  final int ownerID;
  final String name;
  final String phone;
  final String propertyName;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String? upiID;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OwnerData({
    required this.ownerID,
    required this.name,
    required this.phone,
    required this.propertyName,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    this.upiID,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_i_d'] = Variable<int>(ownerID);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['property_name'] = Variable<String>(propertyName);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['pin_code'] = Variable<String>(pinCode);
    if (!nullToAbsent || upiID != null) {
      map['upi_i_d'] = Variable<String>(upiID);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OwnerCompanion toCompanion(bool nullToAbsent) {
    return OwnerCompanion(
      ownerID: Value(ownerID),
      name: Value(name),
      phone: Value(phone),
      propertyName: Value(propertyName),
      address: Value(address),
      city: Value(city),
      state: Value(state),
      pinCode: Value(pinCode),
      upiID: upiID == null && nullToAbsent
          ? const Value.absent()
          : Value(upiID),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OwnerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OwnerData(
      ownerID: serializer.fromJson<int>(json['ownerID']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      propertyName: serializer.fromJson<String>(json['propertyName']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      upiID: serializer.fromJson<String?>(json['upiID']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerID': serializer.toJson<int>(ownerID),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'propertyName': serializer.toJson<String>(propertyName),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'pinCode': serializer.toJson<String>(pinCode),
      'upiID': serializer.toJson<String?>(upiID),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OwnerData copyWith({
    int? ownerID,
    String? name,
    String? phone,
    String? propertyName,
    String? address,
    String? city,
    String? state,
    String? pinCode,
    Value<String?> upiID = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OwnerData(
    ownerID: ownerID ?? this.ownerID,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    propertyName: propertyName ?? this.propertyName,
    address: address ?? this.address,
    city: city ?? this.city,
    state: state ?? this.state,
    pinCode: pinCode ?? this.pinCode,
    upiID: upiID.present ? upiID.value : this.upiID,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OwnerData copyWithCompanion(OwnerCompanion data) {
    return OwnerData(
      ownerID: data.ownerID.present ? data.ownerID.value : this.ownerID,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      propertyName: data.propertyName.present
          ? data.propertyName.value
          : this.propertyName,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      pinCode: data.pinCode.present ? data.pinCode.value : this.pinCode,
      upiID: data.upiID.present ? data.upiID.value : this.upiID,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OwnerData(')
          ..write('ownerID: $ownerID, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('propertyName: $propertyName, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pinCode: $pinCode, ')
          ..write('upiID: $upiID, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ownerID,
    name,
    phone,
    propertyName,
    address,
    city,
    state,
    pinCode,
    upiID,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OwnerData &&
          other.ownerID == this.ownerID &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.propertyName == this.propertyName &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.pinCode == this.pinCode &&
          other.upiID == this.upiID &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OwnerCompanion extends UpdateCompanion<OwnerData> {
  final Value<int> ownerID;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> propertyName;
  final Value<String> address;
  final Value<String> city;
  final Value<String> state;
  final Value<String> pinCode;
  final Value<String?> upiID;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OwnerCompanion({
    this.ownerID = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.propertyName = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.upiID = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OwnerCompanion.insert({
    this.ownerID = const Value.absent(),
    required String name,
    required String phone,
    required String propertyName,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    this.upiID = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone),
       propertyName = Value(propertyName),
       address = Value(address),
       city = Value(city),
       state = Value(state),
       pinCode = Value(pinCode);
  static Insertable<OwnerData> custom({
    Expression<int>? ownerID,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? propertyName,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? pinCode,
    Expression<String>? upiID,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (ownerID != null) 'owner_i_d': ownerID,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (propertyName != null) 'property_name': propertyName,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (pinCode != null) 'pin_code': pinCode,
      if (upiID != null) 'upi_i_d': upiID,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OwnerCompanion copyWith({
    Value<int>? ownerID,
    Value<String>? name,
    Value<String>? phone,
    Value<String>? propertyName,
    Value<String>? address,
    Value<String>? city,
    Value<String>? state,
    Value<String>? pinCode,
    Value<String?>? upiID,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return OwnerCompanion(
      ownerID: ownerID ?? this.ownerID,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      propertyName: propertyName ?? this.propertyName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      upiID: upiID ?? this.upiID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerID.present) {
      map['owner_i_d'] = Variable<int>(ownerID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (propertyName.present) {
      map['property_name'] = Variable<String>(propertyName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (pinCode.present) {
      map['pin_code'] = Variable<String>(pinCode.value);
    }
    if (upiID.present) {
      map['upi_i_d'] = Variable<String>(upiID.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OwnerCompanion(')
          ..write('ownerID: $ownerID, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('propertyName: $propertyName, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pinCode: $pinCode, ')
          ..write('upiID: $upiID, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TenantTable tenant = $TenantTable(this);
  late final $RentTable rent = $RentTable(this);
  late final $OwnerTable owner = $OwnerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tenant, rent, owner];
}

typedef $$TenantTableCreateCompanionBuilder =
    TenantCompanion Function({
      Value<int> tenantID,
      required String name,
      required String mobileNo,
      required String aadharNo,
      required String permanentAddress,
      required String emergencyContact,
      required int agreementPeriod,
      Value<List<String>> aadharImages,
      required bool agreementDone,
      required double rentPerMonth,
      required double advancePayment,
      required double totalDueAmount,
      required DateTime monthEntered,
      Value<DateTime?> monthExit,
      required double meterReadingInitial,
      Value<double?> meterReadingFinal,
      required double electricityRate,
      required double waterCharges,
      required double perYearIncrement,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TenantTableUpdateCompanionBuilder =
    TenantCompanion Function({
      Value<int> tenantID,
      Value<String> name,
      Value<String> mobileNo,
      Value<String> aadharNo,
      Value<String> permanentAddress,
      Value<String> emergencyContact,
      Value<int> agreementPeriod,
      Value<List<String>> aadharImages,
      Value<bool> agreementDone,
      Value<double> rentPerMonth,
      Value<double> advancePayment,
      Value<double> totalDueAmount,
      Value<DateTime> monthEntered,
      Value<DateTime?> monthExit,
      Value<double> meterReadingInitial,
      Value<double?> meterReadingFinal,
      Value<double> electricityRate,
      Value<double> waterCharges,
      Value<double> perYearIncrement,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$TenantTableFilterComposer
    extends Composer<_$AppDatabase, $TenantTable> {
  $$TenantTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get tenantID => $composableBuilder(
    column: $table.tenantID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobileNo => $composableBuilder(
    column: $table.mobileNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aadharNo => $composableBuilder(
    column: $table.aadharNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agreementPeriod => $composableBuilder(
    column: $table.agreementPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get aadharImages => $composableBuilder(
    column: $table.aadharImages,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get agreementDone => $composableBuilder(
    column: $table.agreementDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rentPerMonth => $composableBuilder(
    column: $table.rentPerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDueAmount => $composableBuilder(
    column: $table.totalDueAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get monthEntered => $composableBuilder(
    column: $table.monthEntered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get monthExit => $composableBuilder(
    column: $table.monthExit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterReadingInitial => $composableBuilder(
    column: $table.meterReadingInitial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterReadingFinal => $composableBuilder(
    column: $table.meterReadingFinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get electricityRate => $composableBuilder(
    column: $table.electricityRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterCharges => $composableBuilder(
    column: $table.waterCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get perYearIncrement => $composableBuilder(
    column: $table.perYearIncrement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TenantTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantTable> {
  $$TenantTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get tenantID => $composableBuilder(
    column: $table.tenantID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobileNo => $composableBuilder(
    column: $table.mobileNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aadharNo => $composableBuilder(
    column: $table.aadharNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agreementPeriod => $composableBuilder(
    column: $table.agreementPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aadharImages => $composableBuilder(
    column: $table.aadharImages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get agreementDone => $composableBuilder(
    column: $table.agreementDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rentPerMonth => $composableBuilder(
    column: $table.rentPerMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDueAmount => $composableBuilder(
    column: $table.totalDueAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get monthEntered => $composableBuilder(
    column: $table.monthEntered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get monthExit => $composableBuilder(
    column: $table.monthExit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterReadingInitial => $composableBuilder(
    column: $table.meterReadingInitial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterReadingFinal => $composableBuilder(
    column: $table.meterReadingFinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get electricityRate => $composableBuilder(
    column: $table.electricityRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterCharges => $composableBuilder(
    column: $table.waterCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get perYearIncrement => $composableBuilder(
    column: $table.perYearIncrement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TenantTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantTable> {
  $$TenantTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get tenantID =>
      $composableBuilder(column: $table.tenantID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mobileNo =>
      $composableBuilder(column: $table.mobileNo, builder: (column) => column);

  GeneratedColumn<String> get aadharNo =>
      $composableBuilder(column: $table.aadharNo, builder: (column) => column);

  GeneratedColumn<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => column,
  );

  GeneratedColumn<int> get agreementPeriod => $composableBuilder(
    column: $table.agreementPeriod,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get aadharImages =>
      $composableBuilder(
        column: $table.aadharImages,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get agreementDone => $composableBuilder(
    column: $table.agreementDone,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rentPerMonth => $composableBuilder(
    column: $table.rentPerMonth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalDueAmount => $composableBuilder(
    column: $table.totalDueAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get monthEntered => $composableBuilder(
    column: $table.monthEntered,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get monthExit =>
      $composableBuilder(column: $table.monthExit, builder: (column) => column);

  GeneratedColumn<double> get meterReadingInitial => $composableBuilder(
    column: $table.meterReadingInitial,
    builder: (column) => column,
  );

  GeneratedColumn<double> get meterReadingFinal => $composableBuilder(
    column: $table.meterReadingFinal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get electricityRate => $composableBuilder(
    column: $table.electricityRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterCharges => $composableBuilder(
    column: $table.waterCharges,
    builder: (column) => column,
  );

  GeneratedColumn<double> get perYearIncrement => $composableBuilder(
    column: $table.perYearIncrement,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TenantTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantTable,
          TenantData,
          $$TenantTableFilterComposer,
          $$TenantTableOrderingComposer,
          $$TenantTableAnnotationComposer,
          $$TenantTableCreateCompanionBuilder,
          $$TenantTableUpdateCompanionBuilder,
          (TenantData, BaseReferences<_$AppDatabase, $TenantTable, TenantData>),
          TenantData,
          PrefetchHooks Function()
        > {
  $$TenantTableTableManager(_$AppDatabase db, $TenantTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> tenantID = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> mobileNo = const Value.absent(),
                Value<String> aadharNo = const Value.absent(),
                Value<String> permanentAddress = const Value.absent(),
                Value<String> emergencyContact = const Value.absent(),
                Value<int> agreementPeriod = const Value.absent(),
                Value<List<String>> aadharImages = const Value.absent(),
                Value<bool> agreementDone = const Value.absent(),
                Value<double> rentPerMonth = const Value.absent(),
                Value<double> advancePayment = const Value.absent(),
                Value<double> totalDueAmount = const Value.absent(),
                Value<DateTime> monthEntered = const Value.absent(),
                Value<DateTime?> monthExit = const Value.absent(),
                Value<double> meterReadingInitial = const Value.absent(),
                Value<double?> meterReadingFinal = const Value.absent(),
                Value<double> electricityRate = const Value.absent(),
                Value<double> waterCharges = const Value.absent(),
                Value<double> perYearIncrement = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TenantCompanion(
                tenantID: tenantID,
                name: name,
                mobileNo: mobileNo,
                aadharNo: aadharNo,
                permanentAddress: permanentAddress,
                emergencyContact: emergencyContact,
                agreementPeriod: agreementPeriod,
                aadharImages: aadharImages,
                agreementDone: agreementDone,
                rentPerMonth: rentPerMonth,
                advancePayment: advancePayment,
                totalDueAmount: totalDueAmount,
                monthEntered: monthEntered,
                monthExit: monthExit,
                meterReadingInitial: meterReadingInitial,
                meterReadingFinal: meterReadingFinal,
                electricityRate: electricityRate,
                waterCharges: waterCharges,
                perYearIncrement: perYearIncrement,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> tenantID = const Value.absent(),
                required String name,
                required String mobileNo,
                required String aadharNo,
                required String permanentAddress,
                required String emergencyContact,
                required int agreementPeriod,
                Value<List<String>> aadharImages = const Value.absent(),
                required bool agreementDone,
                required double rentPerMonth,
                required double advancePayment,
                required double totalDueAmount,
                required DateTime monthEntered,
                Value<DateTime?> monthExit = const Value.absent(),
                required double meterReadingInitial,
                Value<double?> meterReadingFinal = const Value.absent(),
                required double electricityRate,
                required double waterCharges,
                required double perYearIncrement,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TenantCompanion.insert(
                tenantID: tenantID,
                name: name,
                mobileNo: mobileNo,
                aadharNo: aadharNo,
                permanentAddress: permanentAddress,
                emergencyContact: emergencyContact,
                agreementPeriod: agreementPeriod,
                aadharImages: aadharImages,
                agreementDone: agreementDone,
                rentPerMonth: rentPerMonth,
                advancePayment: advancePayment,
                totalDueAmount: totalDueAmount,
                monthEntered: monthEntered,
                monthExit: monthExit,
                meterReadingInitial: meterReadingInitial,
                meterReadingFinal: meterReadingFinal,
                electricityRate: electricityRate,
                waterCharges: waterCharges,
                perYearIncrement: perYearIncrement,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TenantTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantTable,
      TenantData,
      $$TenantTableFilterComposer,
      $$TenantTableOrderingComposer,
      $$TenantTableAnnotationComposer,
      $$TenantTableCreateCompanionBuilder,
      $$TenantTableUpdateCompanionBuilder,
      (TenantData, BaseReferences<_$AppDatabase, $TenantTable, TenantData>),
      TenantData,
      PrefetchHooks Function()
    >;
typedef $$RentTableCreateCompanionBuilder =
    RentCompanion Function({
      Value<int> rentID,
      required int tenantID,
      required double rentPerMonth,
      required double electricityRate,
      Value<bool> rentPaid,
      Value<double> currentDueAmount,
      required double totalDueAmount,
      Value<DateTime?> amountPaidOn,
      required double meterReadingLastMonth,
      required double meterReadingThisMonth,
      Value<String?> paymentMode,
      required double totalRentForMonth,
      required DateTime rentMonth,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RentTableUpdateCompanionBuilder =
    RentCompanion Function({
      Value<int> rentID,
      Value<int> tenantID,
      Value<double> rentPerMonth,
      Value<double> electricityRate,
      Value<bool> rentPaid,
      Value<double> currentDueAmount,
      Value<double> totalDueAmount,
      Value<DateTime?> amountPaidOn,
      Value<double> meterReadingLastMonth,
      Value<double> meterReadingThisMonth,
      Value<String?> paymentMode,
      Value<double> totalRentForMonth,
      Value<DateTime> rentMonth,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RentTableReferences
    extends BaseReferences<_$AppDatabase, $RentTable, RentData> {
  $$RentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TenantTable _tenantIDTable(_$AppDatabase db) => db.tenant.createAlias(
    $_aliasNameGenerator(db.rent.tenantID, db.tenant.tenantID),
  );

  $$TenantTableProcessedTableManager get tenantID {
    final $_column = $_itemColumn<int>('tenant_i_d')!;

    final manager = $$TenantTableTableManager(
      $_db,
      $_db.tenant,
    ).filter((f) => f.tenantID.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenantIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantTable _rentPerMonthTable(_$AppDatabase db) =>
      db.tenant.createAlias(
        $_aliasNameGenerator(db.rent.rentPerMonth, db.tenant.rentPerMonth),
      );

  $$TenantTableProcessedTableManager get rentPerMonth {
    final $_column = $_itemColumn<double>('rent_per_month')!;

    final manager = $$TenantTableTableManager(
      $_db,
      $_db.tenant,
    ).filter((f) => f.rentPerMonth.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rentPerMonthTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantTable _electricityRateTable(_$AppDatabase db) =>
      db.tenant.createAlias(
        $_aliasNameGenerator(
          db.rent.electricityRate,
          db.tenant.electricityRate,
        ),
      );

  $$TenantTableProcessedTableManager get electricityRate {
    final $_column = $_itemColumn<double>('electricity_rate')!;

    final manager = $$TenantTableTableManager(
      $_db,
      $_db.tenant,
    ).filter((f) => f.electricityRate.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_electricityRateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenantTable _totalDueAmountTable(_$AppDatabase db) =>
      db.tenant.createAlias(
        $_aliasNameGenerator(db.rent.totalDueAmount, db.tenant.totalDueAmount),
      );

  $$TenantTableProcessedTableManager get totalDueAmount {
    final $_column = $_itemColumn<double>('total_due_amount')!;

    final manager = $$TenantTableTableManager(
      $_db,
      $_db.tenant,
    ).filter((f) => f.totalDueAmount.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_totalDueAmountTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RentTableFilterComposer extends Composer<_$AppDatabase, $RentTable> {
  $$RentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rentID => $composableBuilder(
    column: $table.rentID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get rentPaid => $composableBuilder(
    column: $table.rentPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentDueAmount => $composableBuilder(
    column: $table.currentDueAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get amountPaidOn => $composableBuilder(
    column: $table.amountPaidOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterReadingLastMonth => $composableBuilder(
    column: $table.meterReadingLastMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get meterReadingThisMonth => $composableBuilder(
    column: $table.meterReadingThisMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalRentForMonth => $composableBuilder(
    column: $table.totalRentForMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get rentMonth => $composableBuilder(
    column: $table.rentMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenantTableFilterComposer get tenantID {
    final $$TenantTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantID,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.tenantID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableFilterComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableFilterComposer get rentPerMonth {
    final $$TenantTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentPerMonth,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.rentPerMonth,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableFilterComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableFilterComposer get electricityRate {
    final $$TenantTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.electricityRate,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.electricityRate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableFilterComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableFilterComposer get totalDueAmount {
    final $$TenantTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.totalDueAmount,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.totalDueAmount,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableFilterComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RentTableOrderingComposer extends Composer<_$AppDatabase, $RentTable> {
  $$RentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rentID => $composableBuilder(
    column: $table.rentID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get rentPaid => $composableBuilder(
    column: $table.rentPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentDueAmount => $composableBuilder(
    column: $table.currentDueAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get amountPaidOn => $composableBuilder(
    column: $table.amountPaidOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterReadingLastMonth => $composableBuilder(
    column: $table.meterReadingLastMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get meterReadingThisMonth => $composableBuilder(
    column: $table.meterReadingThisMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalRentForMonth => $composableBuilder(
    column: $table.totalRentForMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get rentMonth => $composableBuilder(
    column: $table.rentMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenantTableOrderingComposer get tenantID {
    final $$TenantTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantID,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.tenantID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableOrderingComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableOrderingComposer get rentPerMonth {
    final $$TenantTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentPerMonth,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.rentPerMonth,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableOrderingComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableOrderingComposer get electricityRate {
    final $$TenantTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.electricityRate,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.electricityRate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableOrderingComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableOrderingComposer get totalDueAmount {
    final $$TenantTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.totalDueAmount,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.totalDueAmount,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableOrderingComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RentTableAnnotationComposer
    extends Composer<_$AppDatabase, $RentTable> {
  $$RentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rentID =>
      $composableBuilder(column: $table.rentID, builder: (column) => column);

  GeneratedColumn<bool> get rentPaid =>
      $composableBuilder(column: $table.rentPaid, builder: (column) => column);

  GeneratedColumn<double> get currentDueAmount => $composableBuilder(
    column: $table.currentDueAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get amountPaidOn => $composableBuilder(
    column: $table.amountPaidOn,
    builder: (column) => column,
  );

  GeneratedColumn<double> get meterReadingLastMonth => $composableBuilder(
    column: $table.meterReadingLastMonth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get meterReadingThisMonth => $composableBuilder(
    column: $table.meterReadingThisMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalRentForMonth => $composableBuilder(
    column: $table.totalRentForMonth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get rentMonth =>
      $composableBuilder(column: $table.rentMonth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenantTableAnnotationComposer get tenantID {
    final $$TenantTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantID,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.tenantID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableAnnotationComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableAnnotationComposer get rentPerMonth {
    final $$TenantTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentPerMonth,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.rentPerMonth,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableAnnotationComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableAnnotationComposer get electricityRate {
    final $$TenantTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.electricityRate,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.electricityRate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableAnnotationComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenantTableAnnotationComposer get totalDueAmount {
    final $$TenantTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.totalDueAmount,
      referencedTable: $db.tenant,
      getReferencedColumn: (t) => t.totalDueAmount,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantTableAnnotationComposer(
            $db: $db,
            $table: $db.tenant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RentTable,
          RentData,
          $$RentTableFilterComposer,
          $$RentTableOrderingComposer,
          $$RentTableAnnotationComposer,
          $$RentTableCreateCompanionBuilder,
          $$RentTableUpdateCompanionBuilder,
          (RentData, $$RentTableReferences),
          RentData,
          PrefetchHooks Function({
            bool tenantID,
            bool rentPerMonth,
            bool electricityRate,
            bool totalDueAmount,
          })
        > {
  $$RentTableTableManager(_$AppDatabase db, $RentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rentID = const Value.absent(),
                Value<int> tenantID = const Value.absent(),
                Value<double> rentPerMonth = const Value.absent(),
                Value<double> electricityRate = const Value.absent(),
                Value<bool> rentPaid = const Value.absent(),
                Value<double> currentDueAmount = const Value.absent(),
                Value<double> totalDueAmount = const Value.absent(),
                Value<DateTime?> amountPaidOn = const Value.absent(),
                Value<double> meterReadingLastMonth = const Value.absent(),
                Value<double> meterReadingThisMonth = const Value.absent(),
                Value<String?> paymentMode = const Value.absent(),
                Value<double> totalRentForMonth = const Value.absent(),
                Value<DateTime> rentMonth = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RentCompanion(
                rentID: rentID,
                tenantID: tenantID,
                rentPerMonth: rentPerMonth,
                electricityRate: electricityRate,
                rentPaid: rentPaid,
                currentDueAmount: currentDueAmount,
                totalDueAmount: totalDueAmount,
                amountPaidOn: amountPaidOn,
                meterReadingLastMonth: meterReadingLastMonth,
                meterReadingThisMonth: meterReadingThisMonth,
                paymentMode: paymentMode,
                totalRentForMonth: totalRentForMonth,
                rentMonth: rentMonth,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> rentID = const Value.absent(),
                required int tenantID,
                required double rentPerMonth,
                required double electricityRate,
                Value<bool> rentPaid = const Value.absent(),
                Value<double> currentDueAmount = const Value.absent(),
                required double totalDueAmount,
                Value<DateTime?> amountPaidOn = const Value.absent(),
                required double meterReadingLastMonth,
                required double meterReadingThisMonth,
                Value<String?> paymentMode = const Value.absent(),
                required double totalRentForMonth,
                required DateTime rentMonth,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RentCompanion.insert(
                rentID: rentID,
                tenantID: tenantID,
                rentPerMonth: rentPerMonth,
                electricityRate: electricityRate,
                rentPaid: rentPaid,
                currentDueAmount: currentDueAmount,
                totalDueAmount: totalDueAmount,
                amountPaidOn: amountPaidOn,
                meterReadingLastMonth: meterReadingLastMonth,
                meterReadingThisMonth: meterReadingThisMonth,
                paymentMode: paymentMode,
                totalRentForMonth: totalRentForMonth,
                rentMonth: rentMonth,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RentTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tenantID = false,
                rentPerMonth = false,
                electricityRate = false,
                totalDueAmount = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tenantID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tenantID,
                                    referencedTable: $$RentTableReferences
                                        ._tenantIDTable(db),
                                    referencedColumn: $$RentTableReferences
                                        ._tenantIDTable(db)
                                        .tenantID,
                                  )
                                  as T;
                        }
                        if (rentPerMonth) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rentPerMonth,
                                    referencedTable: $$RentTableReferences
                                        ._rentPerMonthTable(db),
                                    referencedColumn: $$RentTableReferences
                                        ._rentPerMonthTable(db)
                                        .rentPerMonth,
                                  )
                                  as T;
                        }
                        if (electricityRate) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.electricityRate,
                                    referencedTable: $$RentTableReferences
                                        ._electricityRateTable(db),
                                    referencedColumn: $$RentTableReferences
                                        ._electricityRateTable(db)
                                        .electricityRate,
                                  )
                                  as T;
                        }
                        if (totalDueAmount) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.totalDueAmount,
                                    referencedTable: $$RentTableReferences
                                        ._totalDueAmountTable(db),
                                    referencedColumn: $$RentTableReferences
                                        ._totalDueAmountTable(db)
                                        .totalDueAmount,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$RentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RentTable,
      RentData,
      $$RentTableFilterComposer,
      $$RentTableOrderingComposer,
      $$RentTableAnnotationComposer,
      $$RentTableCreateCompanionBuilder,
      $$RentTableUpdateCompanionBuilder,
      (RentData, $$RentTableReferences),
      RentData,
      PrefetchHooks Function({
        bool tenantID,
        bool rentPerMonth,
        bool electricityRate,
        bool totalDueAmount,
      })
    >;
typedef $$OwnerTableCreateCompanionBuilder =
    OwnerCompanion Function({
      Value<int> ownerID,
      required String name,
      required String phone,
      required String propertyName,
      required String address,
      required String city,
      required String state,
      required String pinCode,
      Value<String?> upiID,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$OwnerTableUpdateCompanionBuilder =
    OwnerCompanion Function({
      Value<int> ownerID,
      Value<String> name,
      Value<String> phone,
      Value<String> propertyName,
      Value<String> address,
      Value<String> city,
      Value<String> state,
      Value<String> pinCode,
      Value<String?> upiID,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$OwnerTableFilterComposer extends Composer<_$AppDatabase, $OwnerTable> {
  $$OwnerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerID => $composableBuilder(
    column: $table.ownerID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get propertyName => $composableBuilder(
    column: $table.propertyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinCode => $composableBuilder(
    column: $table.pinCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upiID => $composableBuilder(
    column: $table.upiID,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OwnerTableOrderingComposer
    extends Composer<_$AppDatabase, $OwnerTable> {
  $$OwnerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerID => $composableBuilder(
    column: $table.ownerID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get propertyName => $composableBuilder(
    column: $table.propertyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinCode => $composableBuilder(
    column: $table.pinCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upiID => $composableBuilder(
    column: $table.upiID,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OwnerTableAnnotationComposer
    extends Composer<_$AppDatabase, $OwnerTable> {
  $$OwnerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerID =>
      $composableBuilder(column: $table.ownerID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get propertyName => $composableBuilder(
    column: $table.propertyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get pinCode =>
      $composableBuilder(column: $table.pinCode, builder: (column) => column);

  GeneratedColumn<String> get upiID =>
      $composableBuilder(column: $table.upiID, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OwnerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OwnerTable,
          OwnerData,
          $$OwnerTableFilterComposer,
          $$OwnerTableOrderingComposer,
          $$OwnerTableAnnotationComposer,
          $$OwnerTableCreateCompanionBuilder,
          $$OwnerTableUpdateCompanionBuilder,
          (OwnerData, BaseReferences<_$AppDatabase, $OwnerTable, OwnerData>),
          OwnerData,
          PrefetchHooks Function()
        > {
  $$OwnerTableTableManager(_$AppDatabase db, $OwnerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OwnerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OwnerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OwnerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerID = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> propertyName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> pinCode = const Value.absent(),
                Value<String?> upiID = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OwnerCompanion(
                ownerID: ownerID,
                name: name,
                phone: phone,
                propertyName: propertyName,
                address: address,
                city: city,
                state: state,
                pinCode: pinCode,
                upiID: upiID,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> ownerID = const Value.absent(),
                required String name,
                required String phone,
                required String propertyName,
                required String address,
                required String city,
                required String state,
                required String pinCode,
                Value<String?> upiID = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OwnerCompanion.insert(
                ownerID: ownerID,
                name: name,
                phone: phone,
                propertyName: propertyName,
                address: address,
                city: city,
                state: state,
                pinCode: pinCode,
                upiID: upiID,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OwnerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OwnerTable,
      OwnerData,
      $$OwnerTableFilterComposer,
      $$OwnerTableOrderingComposer,
      $$OwnerTableAnnotationComposer,
      $$OwnerTableCreateCompanionBuilder,
      $$OwnerTableUpdateCompanionBuilder,
      (OwnerData, BaseReferences<_$AppDatabase, $OwnerTable, OwnerData>),
      OwnerData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TenantTableTableManager get tenant =>
      $$TenantTableTableManager(_db, _db.tenant);
  $$RentTableTableManager get rent => $$RentTableTableManager(_db, _db.rent);
  $$OwnerTableTableManager get owner =>
      $$OwnerTableTableManager(_db, _db.owner);
}
