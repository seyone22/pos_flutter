// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductTable extends Product with TableInfo<$ProductTable, products> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      check: () => ComparableExpr(stock).isBiggerThanValue(-1),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, price, stock, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  VerificationContext validateIntegrity(Insertable<products> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  products map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return products(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(attachedDatabase, alias);
  }
}

class products extends DataClass implements Insertable<products> {
  final int id;
  final String name;
  final double price;
  final int stock;
  final String description;
  const products(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['stock'] = Variable<int>(stock);
    map['description'] = Variable<String>(description);
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      id: Value(id),
      name: Value(name),
      price: Value(price),
      stock: Value(stock),
      description: Value(description),
    );
  }

  factory products.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return products(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      stock: serializer.fromJson<int>(json['stock']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'stock': serializer.toJson<int>(stock),
      'description': serializer.toJson<String>(description),
    };
  }

  products copyWith(
          {int? id,
          String? name,
          double? price,
          int? stock,
          String? description}) =>
      products(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        stock: stock ?? this.stock,
        description: description ?? this.description,
      );
  products copyWithCompanion(ProductCompanion data) {
    return products(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      stock: data.stock.present ? data.stock.value : this.stock,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('products(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, price, stock, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is products &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.stock == this.stock &&
          other.description == this.description);
}

class ProductCompanion extends UpdateCompanion<products> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> price;
  final Value<int> stock;
  final Value<String> description;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.stock = const Value.absent(),
    this.description = const Value.absent(),
  });
  ProductCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double price,
    required int stock,
    required String description,
  })  : name = Value(name),
        price = Value(price),
        stock = Value(stock),
        description = Value(description);
  static Insertable<products> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? price,
    Expression<int>? stock,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (stock != null) 'stock': stock,
      if (description != null) 'description': description,
    });
  }

  ProductCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? price,
      Value<int>? stock,
      Value<String>? description}) {
    return ProductCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $InvoiceTable extends Invoice with TableInfo<$InvoiceTable, invoices> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customer_idMeta =
      const VerificationMeta('customer_id');
  @override
  late final GeneratedColumn<int> customer_id = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      check: () => customer_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discount_typeMeta =
      const VerificationMeta('discount_type');
  @override
  late final GeneratedColumn<String> discount_type = GeneratedColumn<String>(
      'discount_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _discount_amountMeta =
      const VerificationMeta('discount_amount');
  @override
  late final GeneratedColumn<double> discount_amount = GeneratedColumn<double>(
      'discount_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tenderedMeta =
      const VerificationMeta('tendered');
  @override
  late final GeneratedColumn<double> tendered = GeneratedColumn<double>(
      'tendered', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _payment_methodMeta =
      const VerificationMeta('payment_method');
  @override
  late final GeneratedColumn<String> payment_method = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goods_statusMeta =
      const VerificationMeta('goods_status');
  @override
  late final GeneratedColumn<String> goods_status = GeneratedColumn<String>(
      'goods_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customer_id,
        timestamp,
        subtotal,
        discount_type,
        discount_amount,
        tendered,
        currency,
        payment_method,
        status,
        goods_status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice';
  @override
  VerificationContext validateIntegrity(Insertable<invoices> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customer_idMeta,
          customer_id.isAcceptableOrUnknown(
              data['customer_id']!, _customer_idMeta));
    } else if (isInserting) {
      context.missing(_customer_idMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount_type')) {
      context.handle(
          _discount_typeMeta,
          discount_type.isAcceptableOrUnknown(
              data['discount_type']!, _discount_typeMeta));
    } else if (isInserting) {
      context.missing(_discount_typeMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discount_amountMeta,
          discount_amount.isAcceptableOrUnknown(
              data['discount_amount']!, _discount_amountMeta));
    } else if (isInserting) {
      context.missing(_discount_amountMeta);
    }
    if (data.containsKey('tendered')) {
      context.handle(_tenderedMeta,
          tendered.isAcceptableOrUnknown(data['tendered']!, _tenderedMeta));
    } else if (isInserting) {
      context.missing(_tenderedMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _payment_methodMeta,
          payment_method.isAcceptableOrUnknown(
              data['payment_method']!, _payment_methodMeta));
    } else if (isInserting) {
      context.missing(_payment_methodMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('goods_status')) {
      context.handle(
          _goods_statusMeta,
          goods_status.isAcceptableOrUnknown(
              data['goods_status']!, _goods_statusMeta));
    } else if (isInserting) {
      context.missing(_goods_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  invoices map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return invoices(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customer_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      discount_type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}discount_type'])!,
      discount_amount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_amount'])!,
      tendered: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tendered'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      payment_method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      goods_status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goods_status'])!,
    );
  }

  @override
  $InvoiceTable createAlias(String alias) {
    return $InvoiceTable(attachedDatabase, alias);
  }
}

class invoices extends DataClass implements Insertable<invoices> {
  final int id;
  final int customer_id;
  final DateTime timestamp;
  final double subtotal;
  final String discount_type;
  final double discount_amount;
  final double tendered;
  final String currency;
  final String payment_method;
  final String status;
  final String goods_status;
  const invoices(
      {required this.id,
      required this.customer_id,
      required this.timestamp,
      required this.subtotal,
      required this.discount_type,
      required this.discount_amount,
      required this.tendered,
      required this.currency,
      required this.payment_method,
      required this.status,
      required this.goods_status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customer_id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount_type'] = Variable<String>(discount_type);
    map['discount_amount'] = Variable<double>(discount_amount);
    map['tendered'] = Variable<double>(tendered);
    map['currency'] = Variable<String>(currency);
    map['payment_method'] = Variable<String>(payment_method);
    map['status'] = Variable<String>(status);
    map['goods_status'] = Variable<String>(goods_status);
    return map;
  }

  InvoiceCompanion toCompanion(bool nullToAbsent) {
    return InvoiceCompanion(
      id: Value(id),
      customer_id: Value(customer_id),
      timestamp: Value(timestamp),
      subtotal: Value(subtotal),
      discount_type: Value(discount_type),
      discount_amount: Value(discount_amount),
      tendered: Value(tendered),
      currency: Value(currency),
      payment_method: Value(payment_method),
      status: Value(status),
      goods_status: Value(goods_status),
    );
  }

  factory invoices.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return invoices(
      id: serializer.fromJson<int>(json['id']),
      customer_id: serializer.fromJson<int>(json['customer_id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount_type: serializer.fromJson<String>(json['discount_type']),
      discount_amount: serializer.fromJson<double>(json['discount_amount']),
      tendered: serializer.fromJson<double>(json['tendered']),
      currency: serializer.fromJson<String>(json['currency']),
      payment_method: serializer.fromJson<String>(json['payment_method']),
      status: serializer.fromJson<String>(json['status']),
      goods_status: serializer.fromJson<String>(json['goods_status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customer_id': serializer.toJson<int>(customer_id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount_type': serializer.toJson<String>(discount_type),
      'discount_amount': serializer.toJson<double>(discount_amount),
      'tendered': serializer.toJson<double>(tendered),
      'currency': serializer.toJson<String>(currency),
      'payment_method': serializer.toJson<String>(payment_method),
      'status': serializer.toJson<String>(status),
      'goods_status': serializer.toJson<String>(goods_status),
    };
  }

  invoices copyWith(
          {int? id,
          int? customer_id,
          DateTime? timestamp,
          double? subtotal,
          String? discount_type,
          double? discount_amount,
          double? tendered,
          String? currency,
          String? payment_method,
          String? status,
          String? goods_status}) =>
      invoices(
        id: id ?? this.id,
        customer_id: customer_id ?? this.customer_id,
        timestamp: timestamp ?? this.timestamp,
        subtotal: subtotal ?? this.subtotal,
        discount_type: discount_type ?? this.discount_type,
        discount_amount: discount_amount ?? this.discount_amount,
        tendered: tendered ?? this.tendered,
        currency: currency ?? this.currency,
        payment_method: payment_method ?? this.payment_method,
        status: status ?? this.status,
        goods_status: goods_status ?? this.goods_status,
      );
  invoices copyWithCompanion(InvoiceCompanion data) {
    return invoices(
      id: data.id.present ? data.id.value : this.id,
      customer_id:
          data.customer_id.present ? data.customer_id.value : this.customer_id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount_type: data.discount_type.present
          ? data.discount_type.value
          : this.discount_type,
      discount_amount: data.discount_amount.present
          ? data.discount_amount.value
          : this.discount_amount,
      tendered: data.tendered.present ? data.tendered.value : this.tendered,
      currency: data.currency.present ? data.currency.value : this.currency,
      payment_method: data.payment_method.present
          ? data.payment_method.value
          : this.payment_method,
      status: data.status.present ? data.status.value : this.status,
      goods_status: data.goods_status.present
          ? data.goods_status.value
          : this.goods_status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('invoices(')
          ..write('id: $id, ')
          ..write('customer_id: $customer_id, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount_type: $discount_type, ')
          ..write('discount_amount: $discount_amount, ')
          ..write('tendered: $tendered, ')
          ..write('currency: $currency, ')
          ..write('payment_method: $payment_method, ')
          ..write('status: $status, ')
          ..write('goods_status: $goods_status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      customer_id,
      timestamp,
      subtotal,
      discount_type,
      discount_amount,
      tendered,
      currency,
      payment_method,
      status,
      goods_status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is invoices &&
          other.id == this.id &&
          other.customer_id == this.customer_id &&
          other.timestamp == this.timestamp &&
          other.subtotal == this.subtotal &&
          other.discount_type == this.discount_type &&
          other.discount_amount == this.discount_amount &&
          other.tendered == this.tendered &&
          other.currency == this.currency &&
          other.payment_method == this.payment_method &&
          other.status == this.status &&
          other.goods_status == this.goods_status);
}

class InvoiceCompanion extends UpdateCompanion<invoices> {
  final Value<int> id;
  final Value<int> customer_id;
  final Value<DateTime> timestamp;
  final Value<double> subtotal;
  final Value<String> discount_type;
  final Value<double> discount_amount;
  final Value<double> tendered;
  final Value<String> currency;
  final Value<String> payment_method;
  final Value<String> status;
  final Value<String> goods_status;
  const InvoiceCompanion({
    this.id = const Value.absent(),
    this.customer_id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount_type = const Value.absent(),
    this.discount_amount = const Value.absent(),
    this.tendered = const Value.absent(),
    this.currency = const Value.absent(),
    this.payment_method = const Value.absent(),
    this.status = const Value.absent(),
    this.goods_status = const Value.absent(),
  });
  InvoiceCompanion.insert({
    this.id = const Value.absent(),
    required int customer_id,
    required DateTime timestamp,
    required double subtotal,
    required String discount_type,
    required double discount_amount,
    required double tendered,
    required String currency,
    required String payment_method,
    required String status,
    required String goods_status,
  })  : customer_id = Value(customer_id),
        timestamp = Value(timestamp),
        subtotal = Value(subtotal),
        discount_type = Value(discount_type),
        discount_amount = Value(discount_amount),
        tendered = Value(tendered),
        currency = Value(currency),
        payment_method = Value(payment_method),
        status = Value(status),
        goods_status = Value(goods_status);
  static Insertable<invoices> custom({
    Expression<int>? id,
    Expression<int>? customer_id,
    Expression<DateTime>? timestamp,
    Expression<double>? subtotal,
    Expression<String>? discount_type,
    Expression<double>? discount_amount,
    Expression<double>? tendered,
    Expression<String>? currency,
    Expression<String>? payment_method,
    Expression<String>? status,
    Expression<String>? goods_status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customer_id != null) 'customer_id': customer_id,
      if (timestamp != null) 'timestamp': timestamp,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount_type != null) 'discount_type': discount_type,
      if (discount_amount != null) 'discount_amount': discount_amount,
      if (tendered != null) 'tendered': tendered,
      if (currency != null) 'currency': currency,
      if (payment_method != null) 'payment_method': payment_method,
      if (status != null) 'status': status,
      if (goods_status != null) 'goods_status': goods_status,
    });
  }

  InvoiceCompanion copyWith(
      {Value<int>? id,
      Value<int>? customer_id,
      Value<DateTime>? timestamp,
      Value<double>? subtotal,
      Value<String>? discount_type,
      Value<double>? discount_amount,
      Value<double>? tendered,
      Value<String>? currency,
      Value<String>? payment_method,
      Value<String>? status,
      Value<String>? goods_status}) {
    return InvoiceCompanion(
      id: id ?? this.id,
      customer_id: customer_id ?? this.customer_id,
      timestamp: timestamp ?? this.timestamp,
      subtotal: subtotal ?? this.subtotal,
      discount_type: discount_type ?? this.discount_type,
      discount_amount: discount_amount ?? this.discount_amount,
      tendered: tendered ?? this.tendered,
      currency: currency ?? this.currency,
      payment_method: payment_method ?? this.payment_method,
      status: status ?? this.status,
      goods_status: goods_status ?? this.goods_status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customer_id.present) {
      map['customer_id'] = Variable<int>(customer_id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount_type.present) {
      map['discount_type'] = Variable<String>(discount_type.value);
    }
    if (discount_amount.present) {
      map['discount_amount'] = Variable<double>(discount_amount.value);
    }
    if (tendered.present) {
      map['tendered'] = Variable<double>(tendered.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (payment_method.present) {
      map['payment_method'] = Variable<String>(payment_method.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (goods_status.present) {
      map['goods_status'] = Variable<String>(goods_status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceCompanion(')
          ..write('id: $id, ')
          ..write('customer_id: $customer_id, ')
          ..write('timestamp: $timestamp, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount_type: $discount_type, ')
          ..write('discount_amount: $discount_amount, ')
          ..write('tendered: $tendered, ')
          ..write('currency: $currency, ')
          ..write('payment_method: $payment_method, ')
          ..write('status: $status, ')
          ..write('goods_status: $goods_status')
          ..write(')'))
        .toString();
  }
}

class $InvoiceProductTable extends InvoiceProduct
    with TableInfo<$InvoiceProductTable, invoice_products> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceProductTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _invoice_idMeta =
      const VerificationMeta('invoice_id');
  @override
  late final GeneratedColumn<int> invoice_id = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      check: () => invoice_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _product_idMeta =
      const VerificationMeta('product_id');
  @override
  late final GeneratedColumn<int> product_id = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      check: () => product_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, invoice_id, product_id, quantity, price];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_product';
  @override
  VerificationContext validateIntegrity(Insertable<invoice_products> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
          _invoice_idMeta,
          invoice_id.isAcceptableOrUnknown(
              data['invoice_id']!, _invoice_idMeta));
    } else if (isInserting) {
      context.missing(_invoice_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
          _product_idMeta,
          product_id.isAcceptableOrUnknown(
              data['product_id']!, _product_idMeta));
    } else if (isInserting) {
      context.missing(_product_idMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  invoice_products map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return invoice_products(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoice_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      product_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
    );
  }

  @override
  $InvoiceProductTable createAlias(String alias) {
    return $InvoiceProductTable(attachedDatabase, alias);
  }
}

class invoice_products extends DataClass
    implements Insertable<invoice_products> {
  final int id;
  final int invoice_id;
  final int product_id;
  final int quantity;
  final double price;
  const invoice_products(
      {required this.id,
      required this.invoice_id,
      required this.product_id,
      required this.quantity,
      required this.price});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoice_id);
    map['product_id'] = Variable<int>(product_id);
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    return map;
  }

  InvoiceProductCompanion toCompanion(bool nullToAbsent) {
    return InvoiceProductCompanion(
      id: Value(id),
      invoice_id: Value(invoice_id),
      product_id: Value(product_id),
      quantity: Value(quantity),
      price: Value(price),
    );
  }

  factory invoice_products.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return invoice_products(
      id: serializer.fromJson<int>(json['id']),
      invoice_id: serializer.fromJson<int>(json['invoice_id']),
      product_id: serializer.fromJson<int>(json['product_id']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoice_id': serializer.toJson<int>(invoice_id),
      'product_id': serializer.toJson<int>(product_id),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
    };
  }

  invoice_products copyWith(
          {int? id,
          int? invoice_id,
          int? product_id,
          int? quantity,
          double? price}) =>
      invoice_products(
        id: id ?? this.id,
        invoice_id: invoice_id ?? this.invoice_id,
        product_id: product_id ?? this.product_id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );
  invoice_products copyWithCompanion(InvoiceProductCompanion data) {
    return invoice_products(
      id: data.id.present ? data.id.value : this.id,
      invoice_id:
          data.invoice_id.present ? data.invoice_id.value : this.invoice_id,
      product_id:
          data.product_id.present ? data.product_id.value : this.product_id,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('invoice_products(')
          ..write('id: $id, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('product_id: $product_id, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoice_id, product_id, quantity, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is invoice_products &&
          other.id == this.id &&
          other.invoice_id == this.invoice_id &&
          other.product_id == this.product_id &&
          other.quantity == this.quantity &&
          other.price == this.price);
}

class InvoiceProductCompanion extends UpdateCompanion<invoice_products> {
  final Value<int> id;
  final Value<int> invoice_id;
  final Value<int> product_id;
  final Value<int> quantity;
  final Value<double> price;
  const InvoiceProductCompanion({
    this.id = const Value.absent(),
    this.invoice_id = const Value.absent(),
    this.product_id = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
  });
  InvoiceProductCompanion.insert({
    this.id = const Value.absent(),
    required int invoice_id,
    required int product_id,
    required int quantity,
    required double price,
  })  : invoice_id = Value(invoice_id),
        product_id = Value(product_id),
        quantity = Value(quantity),
        price = Value(price);
  static Insertable<invoice_products> custom({
    Expression<int>? id,
    Expression<int>? invoice_id,
    Expression<int>? product_id,
    Expression<int>? quantity,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoice_id != null) 'invoice_id': invoice_id,
      if (product_id != null) 'product_id': product_id,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
    });
  }

  InvoiceProductCompanion copyWith(
      {Value<int>? id,
      Value<int>? invoice_id,
      Value<int>? product_id,
      Value<int>? quantity,
      Value<double>? price}) {
    return InvoiceProductCompanion(
      id: id ?? this.id,
      invoice_id: invoice_id ?? this.invoice_id,
      product_id: product_id ?? this.product_id,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoice_id.present) {
      map['invoice_id'] = Variable<int>(invoice_id.value);
    }
    if (product_id.present) {
      map['product_id'] = Variable<int>(product_id.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceProductCompanion(')
          ..write('id: $id, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('product_id: $product_id, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $RestockTable extends Restock with TableInfo<$RestockTable, restocks> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestockTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _product_idMeta =
      const VerificationMeta('product_id');
  @override
  late final GeneratedColumn<int> product_id = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      check: () => product_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _supplier_idMeta =
      const VerificationMeta('supplier_id');
  @override
  late final GeneratedColumn<int> supplier_id = GeneratedColumn<int>(
      'supplier_id', aliasedName, false,
      check: () => supplier_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, product_id, supplier_id, quantity, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restock';
  @override
  VerificationContext validateIntegrity(Insertable<restocks> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
          _product_idMeta,
          product_id.isAcceptableOrUnknown(
              data['product_id']!, _product_idMeta));
    } else if (isInserting) {
      context.missing(_product_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplier_idMeta,
          supplier_id.isAcceptableOrUnknown(
              data['supplier_id']!, _supplier_idMeta));
    } else if (isInserting) {
      context.missing(_supplier_idMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  restocks map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return restocks(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      product_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      supplier_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $RestockTable createAlias(String alias) {
    return $RestockTable(attachedDatabase, alias);
  }
}

class restocks extends DataClass implements Insertable<restocks> {
  final int id;
  final int product_id;
  final int supplier_id;
  final int quantity;
  final DateTime timestamp;
  const restocks(
      {required this.id,
      required this.product_id,
      required this.supplier_id,
      required this.quantity,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(product_id);
    map['supplier_id'] = Variable<int>(supplier_id);
    map['quantity'] = Variable<int>(quantity);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  RestockCompanion toCompanion(bool nullToAbsent) {
    return RestockCompanion(
      id: Value(id),
      product_id: Value(product_id),
      supplier_id: Value(supplier_id),
      quantity: Value(quantity),
      timestamp: Value(timestamp),
    );
  }

  factory restocks.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return restocks(
      id: serializer.fromJson<int>(json['id']),
      product_id: serializer.fromJson<int>(json['product_id']),
      supplier_id: serializer.fromJson<int>(json['supplier_id']),
      quantity: serializer.fromJson<int>(json['quantity']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'product_id': serializer.toJson<int>(product_id),
      'supplier_id': serializer.toJson<int>(supplier_id),
      'quantity': serializer.toJson<int>(quantity),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  restocks copyWith(
          {int? id,
          int? product_id,
          int? supplier_id,
          int? quantity,
          DateTime? timestamp}) =>
      restocks(
        id: id ?? this.id,
        product_id: product_id ?? this.product_id,
        supplier_id: supplier_id ?? this.supplier_id,
        quantity: quantity ?? this.quantity,
        timestamp: timestamp ?? this.timestamp,
      );
  restocks copyWithCompanion(RestockCompanion data) {
    return restocks(
      id: data.id.present ? data.id.value : this.id,
      product_id:
          data.product_id.present ? data.product_id.value : this.product_id,
      supplier_id:
          data.supplier_id.present ? data.supplier_id.value : this.supplier_id,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('restocks(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('supplier_id: $supplier_id, ')
          ..write('quantity: $quantity, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, product_id, supplier_id, quantity, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is restocks &&
          other.id == this.id &&
          other.product_id == this.product_id &&
          other.supplier_id == this.supplier_id &&
          other.quantity == this.quantity &&
          other.timestamp == this.timestamp);
}

class RestockCompanion extends UpdateCompanion<restocks> {
  final Value<int> id;
  final Value<int> product_id;
  final Value<int> supplier_id;
  final Value<int> quantity;
  final Value<DateTime> timestamp;
  const RestockCompanion({
    this.id = const Value.absent(),
    this.product_id = const Value.absent(),
    this.supplier_id = const Value.absent(),
    this.quantity = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  RestockCompanion.insert({
    this.id = const Value.absent(),
    required int product_id,
    required int supplier_id,
    required int quantity,
    required DateTime timestamp,
  })  : product_id = Value(product_id),
        supplier_id = Value(supplier_id),
        quantity = Value(quantity),
        timestamp = Value(timestamp);
  static Insertable<restocks> custom({
    Expression<int>? id,
    Expression<int>? product_id,
    Expression<int>? supplier_id,
    Expression<int>? quantity,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (product_id != null) 'product_id': product_id,
      if (supplier_id != null) 'supplier_id': supplier_id,
      if (quantity != null) 'quantity': quantity,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  RestockCompanion copyWith(
      {Value<int>? id,
      Value<int>? product_id,
      Value<int>? supplier_id,
      Value<int>? quantity,
      Value<DateTime>? timestamp}) {
    return RestockCompanion(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      supplier_id: supplier_id ?? this.supplier_id,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (product_id.present) {
      map['product_id'] = Variable<int>(product_id.value);
    }
    if (supplier_id.present) {
      map['supplier_id'] = Variable<int>(supplier_id.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestockCompanion(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('supplier_id: $supplier_id, ')
          ..write('quantity: $quantity, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $CustomerTable extends Customer
    with TableInfo<$CustomerTable, customers> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phone_numberMeta =
      const VerificationMeta('phone_number');
  @override
  late final GeneratedColumn<String> phone_number = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, phone_number, address];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer';
  @override
  VerificationContext validateIntegrity(Insertable<customers> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phone_numberMeta,
          phone_number.isAcceptableOrUnknown(
              data['phone_number']!, _phone_numberMeta));
    } else if (isInserting) {
      context.missing(_phone_numberMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  customers map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return customers(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phone_number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
    );
  }

  @override
  $CustomerTable createAlias(String alias) {
    return $CustomerTable(attachedDatabase, alias);
  }
}

class customers extends DataClass implements Insertable<customers> {
  final int id;
  final String name;
  final String email;
  final String phone_number;
  final String address;
  const customers(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone_number,
      required this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['phone_number'] = Variable<String>(phone_number);
    map['address'] = Variable<String>(address);
    return map;
  }

  CustomerCompanion toCompanion(bool nullToAbsent) {
    return CustomerCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      phone_number: Value(phone_number),
      address: Value(address),
    );
  }

  factory customers.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return customers(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      phone_number: serializer.fromJson<String>(json['phone_number']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'phone_number': serializer.toJson<String>(phone_number),
      'address': serializer.toJson<String>(address),
    };
  }

  customers copyWith(
          {int? id,
          String? name,
          String? email,
          String? phone_number,
          String? address}) =>
      customers(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone_number: phone_number ?? this.phone_number,
        address: address ?? this.address,
      );
  customers copyWithCompanion(CustomerCompanion data) {
    return customers(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone_number: data.phone_number.present
          ? data.phone_number.value
          : this.phone_number,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('customers(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone_number: $phone_number, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, phone_number, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is customers &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone_number == this.phone_number &&
          other.address == this.address);
}

class CustomerCompanion extends UpdateCompanion<customers> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> phone_number;
  final Value<String> address;
  const CustomerCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone_number = const Value.absent(),
    this.address = const Value.absent(),
  });
  CustomerCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String phone_number,
    required String address,
  })  : name = Value(name),
        email = Value(email),
        phone_number = Value(phone_number),
        address = Value(address);
  static Insertable<customers> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone_number,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone_number != null) 'phone_number': phone_number,
      if (address != null) 'address': address,
    });
  }

  CustomerCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? phone_number,
      Value<String>? address}) {
    return CustomerCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone_number.present) {
      map['phone_number'] = Variable<String>(phone_number.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone_number: $phone_number, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $SupplierTable extends Supplier
    with TableInfo<$SupplierTable, suppliers> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier';
  @override
  VerificationContext validateIntegrity(Insertable<suppliers> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  suppliers map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return suppliers(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SupplierTable createAlias(String alias) {
    return $SupplierTable(attachedDatabase, alias);
  }
}

class suppliers extends DataClass implements Insertable<suppliers> {
  final int id;
  final String name;
  const suppliers({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SupplierCompanion toCompanion(bool nullToAbsent) {
    return SupplierCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory suppliers.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return suppliers(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  suppliers copyWith({int? id, String? name}) => suppliers(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  suppliers copyWithCompanion(SupplierCompanion data) {
    return suppliers(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('suppliers(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is suppliers && other.id == this.id && other.name == this.name);
}

class SupplierCompanion extends UpdateCompanion<suppliers> {
  final Value<int> id;
  final Value<String> name;
  const SupplierCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SupplierCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<suppliers> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SupplierCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return SupplierCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $InventoryAdjustmentTable extends InventoryAdjustment
    with TableInfo<$InventoryAdjustmentTable, inventory_adjustments> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryAdjustmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _product_idMeta =
      const VerificationMeta('product_id');
  @override
  late final GeneratedColumn<int> product_id = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      check: () => product_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, product_id, type, quantity, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_adjustment';
  @override
  VerificationContext validateIntegrity(
      Insertable<inventory_adjustments> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
          _product_idMeta,
          product_id.isAcceptableOrUnknown(
              data['product_id']!, _product_idMeta));
    } else if (isInserting) {
      context.missing(_product_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  inventory_adjustments map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return inventory_adjustments(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      product_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $InventoryAdjustmentTable createAlias(String alias) {
    return $InventoryAdjustmentTable(attachedDatabase, alias);
  }
}

class inventory_adjustments extends DataClass
    implements Insertable<inventory_adjustments> {
  final int id;
  final int product_id;
  final String type;
  final int quantity;
  final DateTime timestamp;
  const inventory_adjustments(
      {required this.id,
      required this.product_id,
      required this.type,
      required this.quantity,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(product_id);
    map['type'] = Variable<String>(type);
    map['quantity'] = Variable<int>(quantity);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  InventoryAdjustmentCompanion toCompanion(bool nullToAbsent) {
    return InventoryAdjustmentCompanion(
      id: Value(id),
      product_id: Value(product_id),
      type: Value(type),
      quantity: Value(quantity),
      timestamp: Value(timestamp),
    );
  }

  factory inventory_adjustments.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return inventory_adjustments(
      id: serializer.fromJson<int>(json['id']),
      product_id: serializer.fromJson<int>(json['product_id']),
      type: serializer.fromJson<String>(json['type']),
      quantity: serializer.fromJson<int>(json['quantity']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'product_id': serializer.toJson<int>(product_id),
      'type': serializer.toJson<String>(type),
      'quantity': serializer.toJson<int>(quantity),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  inventory_adjustments copyWith(
          {int? id,
          int? product_id,
          String? type,
          int? quantity,
          DateTime? timestamp}) =>
      inventory_adjustments(
        id: id ?? this.id,
        product_id: product_id ?? this.product_id,
        type: type ?? this.type,
        quantity: quantity ?? this.quantity,
        timestamp: timestamp ?? this.timestamp,
      );
  inventory_adjustments copyWithCompanion(InventoryAdjustmentCompanion data) {
    return inventory_adjustments(
      id: data.id.present ? data.id.value : this.id,
      product_id:
          data.product_id.present ? data.product_id.value : this.product_id,
      type: data.type.present ? data.type.value : this.type,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('inventory_adjustments(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, product_id, type, quantity, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is inventory_adjustments &&
          other.id == this.id &&
          other.product_id == this.product_id &&
          other.type == this.type &&
          other.quantity == this.quantity &&
          other.timestamp == this.timestamp);
}

class InventoryAdjustmentCompanion
    extends UpdateCompanion<inventory_adjustments> {
  final Value<int> id;
  final Value<int> product_id;
  final Value<String> type;
  final Value<int> quantity;
  final Value<DateTime> timestamp;
  const InventoryAdjustmentCompanion({
    this.id = const Value.absent(),
    this.product_id = const Value.absent(),
    this.type = const Value.absent(),
    this.quantity = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  InventoryAdjustmentCompanion.insert({
    this.id = const Value.absent(),
    required int product_id,
    required String type,
    required int quantity,
    required DateTime timestamp,
  })  : product_id = Value(product_id),
        type = Value(type),
        quantity = Value(quantity),
        timestamp = Value(timestamp);
  static Insertable<inventory_adjustments> custom({
    Expression<int>? id,
    Expression<int>? product_id,
    Expression<String>? type,
    Expression<int>? quantity,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (product_id != null) 'product_id': product_id,
      if (type != null) 'type': type,
      if (quantity != null) 'quantity': quantity,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  InventoryAdjustmentCompanion copyWith(
      {Value<int>? id,
      Value<int>? product_id,
      Value<String>? type,
      Value<int>? quantity,
      Value<DateTime>? timestamp}) {
    return InventoryAdjustmentCompanion(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (product_id.present) {
      map['product_id'] = Variable<int>(product_id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryAdjustmentCompanion(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantTable extends ProductVariant
    with TableInfo<$ProductVariantTable, product_variants> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductVariantTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _product_idMeta =
      const VerificationMeta('product_id');
  @override
  late final GeneratedColumn<int> product_id = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      check: () => product_id.isNotNull(),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _variant_typeMeta =
      const VerificationMeta('variant_type');
  @override
  late final GeneratedColumn<String> variant_type = GeneratedColumn<String>(
      'variant_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _price_adjustmentMeta =
      const VerificationMeta('price_adjustment');
  @override
  late final GeneratedColumn<double> price_adjustment = GeneratedColumn<double>(
      'price_adjustment', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, product_id, variant_type, name, price_adjustment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_variant';
  @override
  VerificationContext validateIntegrity(Insertable<product_variants> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
          _product_idMeta,
          product_id.isAcceptableOrUnknown(
              data['product_id']!, _product_idMeta));
    } else if (isInserting) {
      context.missing(_product_idMeta);
    }
    if (data.containsKey('variant_type')) {
      context.handle(
          _variant_typeMeta,
          variant_type.isAcceptableOrUnknown(
              data['variant_type']!, _variant_typeMeta));
    } else if (isInserting) {
      context.missing(_variant_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_adjustment')) {
      context.handle(
          _price_adjustmentMeta,
          price_adjustment.isAcceptableOrUnknown(
              data['price_adjustment']!, _price_adjustmentMeta));
    } else if (isInserting) {
      context.missing(_price_adjustmentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  product_variants map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return product_variants(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      product_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      variant_type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price_adjustment: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}price_adjustment'])!,
    );
  }

  @override
  $ProductVariantTable createAlias(String alias) {
    return $ProductVariantTable(attachedDatabase, alias);
  }
}

class product_variants extends DataClass
    implements Insertable<product_variants> {
  final int id;
  final int product_id;
  final String variant_type;
  final String name;
  final double price_adjustment;
  const product_variants(
      {required this.id,
      required this.product_id,
      required this.variant_type,
      required this.name,
      required this.price_adjustment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(product_id);
    map['variant_type'] = Variable<String>(variant_type);
    map['name'] = Variable<String>(name);
    map['price_adjustment'] = Variable<double>(price_adjustment);
    return map;
  }

  ProductVariantCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantCompanion(
      id: Value(id),
      product_id: Value(product_id),
      variant_type: Value(variant_type),
      name: Value(name),
      price_adjustment: Value(price_adjustment),
    );
  }

  factory product_variants.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return product_variants(
      id: serializer.fromJson<int>(json['id']),
      product_id: serializer.fromJson<int>(json['product_id']),
      variant_type: serializer.fromJson<String>(json['variant_type']),
      name: serializer.fromJson<String>(json['name']),
      price_adjustment: serializer.fromJson<double>(json['price_adjustment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'product_id': serializer.toJson<int>(product_id),
      'variant_type': serializer.toJson<String>(variant_type),
      'name': serializer.toJson<String>(name),
      'price_adjustment': serializer.toJson<double>(price_adjustment),
    };
  }

  product_variants copyWith(
          {int? id,
          int? product_id,
          String? variant_type,
          String? name,
          double? price_adjustment}) =>
      product_variants(
        id: id ?? this.id,
        product_id: product_id ?? this.product_id,
        variant_type: variant_type ?? this.variant_type,
        name: name ?? this.name,
        price_adjustment: price_adjustment ?? this.price_adjustment,
      );
  product_variants copyWithCompanion(ProductVariantCompanion data) {
    return product_variants(
      id: data.id.present ? data.id.value : this.id,
      product_id:
          data.product_id.present ? data.product_id.value : this.product_id,
      variant_type: data.variant_type.present
          ? data.variant_type.value
          : this.variant_type,
      name: data.name.present ? data.name.value : this.name,
      price_adjustment: data.price_adjustment.present
          ? data.price_adjustment.value
          : this.price_adjustment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('product_variants(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('variant_type: $variant_type, ')
          ..write('name: $name, ')
          ..write('price_adjustment: $price_adjustment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, product_id, variant_type, name, price_adjustment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is product_variants &&
          other.id == this.id &&
          other.product_id == this.product_id &&
          other.variant_type == this.variant_type &&
          other.name == this.name &&
          other.price_adjustment == this.price_adjustment);
}

class ProductVariantCompanion extends UpdateCompanion<product_variants> {
  final Value<int> id;
  final Value<int> product_id;
  final Value<String> variant_type;
  final Value<String> name;
  final Value<double> price_adjustment;
  const ProductVariantCompanion({
    this.id = const Value.absent(),
    this.product_id = const Value.absent(),
    this.variant_type = const Value.absent(),
    this.name = const Value.absent(),
    this.price_adjustment = const Value.absent(),
  });
  ProductVariantCompanion.insert({
    this.id = const Value.absent(),
    required int product_id,
    required String variant_type,
    required String name,
    required double price_adjustment,
  })  : product_id = Value(product_id),
        variant_type = Value(variant_type),
        name = Value(name),
        price_adjustment = Value(price_adjustment);
  static Insertable<product_variants> custom({
    Expression<int>? id,
    Expression<int>? product_id,
    Expression<String>? variant_type,
    Expression<String>? name,
    Expression<double>? price_adjustment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (product_id != null) 'product_id': product_id,
      if (variant_type != null) 'variant_type': variant_type,
      if (name != null) 'name': name,
      if (price_adjustment != null) 'price_adjustment': price_adjustment,
    });
  }

  ProductVariantCompanion copyWith(
      {Value<int>? id,
      Value<int>? product_id,
      Value<String>? variant_type,
      Value<String>? name,
      Value<double>? price_adjustment}) {
    return ProductVariantCompanion(
      id: id ?? this.id,
      product_id: product_id ?? this.product_id,
      variant_type: variant_type ?? this.variant_type,
      name: name ?? this.name,
      price_adjustment: price_adjustment ?? this.price_adjustment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (product_id.present) {
      map['product_id'] = Variable<int>(product_id.value);
    }
    if (variant_type.present) {
      map['variant_type'] = Variable<String>(variant_type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price_adjustment.present) {
      map['price_adjustment'] = Variable<double>(price_adjustment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantCompanion(')
          ..write('id: $id, ')
          ..write('product_id: $product_id, ')
          ..write('variant_type: $variant_type, ')
          ..write('name: $name, ')
          ..write('price_adjustment: $price_adjustment')
          ..write(')'))
        .toString();
  }
}

class $AuditLogTable extends AuditLog
    with TableInfo<$AuditLogTable, audit_logs> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _action_typeMeta =
      const VerificationMeta('action_type');
  @override
  late final GeneratedColumn<String> action_type = GeneratedColumn<String>(
      'action_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, action_type, user, timestamp, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log';
  @override
  VerificationContext validateIntegrity(Insertable<audit_logs> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action_type')) {
      context.handle(
          _action_typeMeta,
          action_type.isAcceptableOrUnknown(
              data['action_type']!, _action_typeMeta));
    } else if (isInserting) {
      context.missing(_action_typeMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  audit_logs map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return audit_logs(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      action_type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_type'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $AuditLogTable createAlias(String alias) {
    return $AuditLogTable(attachedDatabase, alias);
  }
}

class audit_logs extends DataClass implements Insertable<audit_logs> {
  final int id;
  final String action_type;
  final String user;
  final DateTime timestamp;
  final String description;
  const audit_logs(
      {required this.id,
      required this.action_type,
      required this.user,
      required this.timestamp,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action_type'] = Variable<String>(action_type);
    map['user'] = Variable<String>(user);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['description'] = Variable<String>(description);
    return map;
  }

  AuditLogCompanion toCompanion(bool nullToAbsent) {
    return AuditLogCompanion(
      id: Value(id),
      action_type: Value(action_type),
      user: Value(user),
      timestamp: Value(timestamp),
      description: Value(description),
    );
  }

  factory audit_logs.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return audit_logs(
      id: serializer.fromJson<int>(json['id']),
      action_type: serializer.fromJson<String>(json['action_type']),
      user: serializer.fromJson<String>(json['user']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action_type': serializer.toJson<String>(action_type),
      'user': serializer.toJson<String>(user),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'description': serializer.toJson<String>(description),
    };
  }

  audit_logs copyWith(
          {int? id,
          String? action_type,
          String? user,
          DateTime? timestamp,
          String? description}) =>
      audit_logs(
        id: id ?? this.id,
        action_type: action_type ?? this.action_type,
        user: user ?? this.user,
        timestamp: timestamp ?? this.timestamp,
        description: description ?? this.description,
      );
  audit_logs copyWithCompanion(AuditLogCompanion data) {
    return audit_logs(
      id: data.id.present ? data.id.value : this.id,
      action_type:
          data.action_type.present ? data.action_type.value : this.action_type,
      user: data.user.present ? data.user.value : this.user,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('audit_logs(')
          ..write('id: $id, ')
          ..write('action_type: $action_type, ')
          ..write('user: $user, ')
          ..write('timestamp: $timestamp, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action_type, user, timestamp, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is audit_logs &&
          other.id == this.id &&
          other.action_type == this.action_type &&
          other.user == this.user &&
          other.timestamp == this.timestamp &&
          other.description == this.description);
}

class AuditLogCompanion extends UpdateCompanion<audit_logs> {
  final Value<int> id;
  final Value<String> action_type;
  final Value<String> user;
  final Value<DateTime> timestamp;
  final Value<String> description;
  const AuditLogCompanion({
    this.id = const Value.absent(),
    this.action_type = const Value.absent(),
    this.user = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.description = const Value.absent(),
  });
  AuditLogCompanion.insert({
    this.id = const Value.absent(),
    required String action_type,
    required String user,
    required DateTime timestamp,
    required String description,
  })  : action_type = Value(action_type),
        user = Value(user),
        timestamp = Value(timestamp),
        description = Value(description);
  static Insertable<audit_logs> custom({
    Expression<int>? id,
    Expression<String>? action_type,
    Expression<String>? user,
    Expression<DateTime>? timestamp,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action_type != null) 'action_type': action_type,
      if (user != null) 'user': user,
      if (timestamp != null) 'timestamp': timestamp,
      if (description != null) 'description': description,
    });
  }

  AuditLogCompanion copyWith(
      {Value<int>? id,
      Value<String>? action_type,
      Value<String>? user,
      Value<DateTime>? timestamp,
      Value<String>? description}) {
    return AuditLogCompanion(
      id: id ?? this.id,
      action_type: action_type ?? this.action_type,
      user: user ?? this.user,
      timestamp: timestamp ?? this.timestamp,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action_type.present) {
      map['action_type'] = Variable<String>(action_type.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogCompanion(')
          ..write('id: $id, ')
          ..write('action_type: $action_type, ')
          ..write('user: $user, ')
          ..write('timestamp: $timestamp, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductTable product = $ProductTable(this);
  late final $InvoiceTable invoice = $InvoiceTable(this);
  late final $InvoiceProductTable invoiceProduct = $InvoiceProductTable(this);
  late final $RestockTable restock = $RestockTable(this);
  late final $CustomerTable customer = $CustomerTable(this);
  late final $SupplierTable supplier = $SupplierTable(this);
  late final $InventoryAdjustmentTable inventoryAdjustment =
      $InventoryAdjustmentTable(this);
  late final $ProductVariantTable productVariant = $ProductVariantTable(this);
  late final $AuditLogTable auditLog = $AuditLogTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        product,
        invoice,
        invoiceProduct,
        restock,
        customer,
        supplier,
        inventoryAdjustment,
        productVariant,
        auditLog
      ];
}

typedef $$ProductTableCreateCompanionBuilder = ProductCompanion Function({
  Value<int> id,
  required String name,
  required double price,
  required int stock,
  required String description,
});
typedef $$ProductTableUpdateCompanionBuilder = ProductCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<double> price,
  Value<int> stock,
  Value<String> description,
});

class $$ProductTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$ProductTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$ProductTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTable> {
  $$ProductTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$ProductTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductTable,
    products,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (products, BaseReferences<_$AppDatabase, $ProductTable, products>),
    products,
    PrefetchHooks Function()> {
  $$ProductTableTableManager(_$AppDatabase db, $ProductTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<String> description = const Value.absent(),
          }) =>
              ProductCompanion(
            id: id,
            name: name,
            price: price,
            stock: stock,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required double price,
            required int stock,
            required String description,
          }) =>
              ProductCompanion.insert(
            id: id,
            name: name,
            price: price,
            stock: stock,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductTable,
    products,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (products, BaseReferences<_$AppDatabase, $ProductTable, products>),
    products,
    PrefetchHooks Function()>;
typedef $$InvoiceTableCreateCompanionBuilder = InvoiceCompanion Function({
  Value<int> id,
  required int customer_id,
  required DateTime timestamp,
  required double subtotal,
  required String discount_type,
  required double discount_amount,
  required double tendered,
  required String currency,
  required String payment_method,
  required String status,
  required String goods_status,
});
typedef $$InvoiceTableUpdateCompanionBuilder = InvoiceCompanion Function({
  Value<int> id,
  Value<int> customer_id,
  Value<DateTime> timestamp,
  Value<double> subtotal,
  Value<String> discount_type,
  Value<double> discount_amount,
  Value<double> tendered,
  Value<String> currency,
  Value<String> payment_method,
  Value<String> status,
  Value<String> goods_status,
});

class $$InvoiceTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceTable> {
  $$InvoiceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customer_id => $composableBuilder(
      column: $table.customer_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get discount_type => $composableBuilder(
      column: $table.discount_type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discount_amount => $composableBuilder(
      column: $table.discount_amount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tendered => $composableBuilder(
      column: $table.tendered, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payment_method => $composableBuilder(
      column: $table.payment_method,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goods_status => $composableBuilder(
      column: $table.goods_status, builder: (column) => ColumnFilters(column));
}

class $$InvoiceTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceTable> {
  $$InvoiceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customer_id => $composableBuilder(
      column: $table.customer_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get discount_type => $composableBuilder(
      column: $table.discount_type,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discount_amount => $composableBuilder(
      column: $table.discount_amount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tendered => $composableBuilder(
      column: $table.tendered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payment_method => $composableBuilder(
      column: $table.payment_method,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goods_status => $composableBuilder(
      column: $table.goods_status,
      builder: (column) => ColumnOrderings(column));
}

class $$InvoiceTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceTable> {
  $$InvoiceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customer_id => $composableBuilder(
      column: $table.customer_id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<String> get discount_type => $composableBuilder(
      column: $table.discount_type, builder: (column) => column);

  GeneratedColumn<double> get discount_amount => $composableBuilder(
      column: $table.discount_amount, builder: (column) => column);

  GeneratedColumn<double> get tendered =>
      $composableBuilder(column: $table.tendered, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get payment_method => $composableBuilder(
      column: $table.payment_method, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get goods_status => $composableBuilder(
      column: $table.goods_status, builder: (column) => column);
}

class $$InvoiceTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoiceTable,
    invoices,
    $$InvoiceTableFilterComposer,
    $$InvoiceTableOrderingComposer,
    $$InvoiceTableAnnotationComposer,
    $$InvoiceTableCreateCompanionBuilder,
    $$InvoiceTableUpdateCompanionBuilder,
    (invoices, BaseReferences<_$AppDatabase, $InvoiceTable, invoices>),
    invoices,
    PrefetchHooks Function()> {
  $$InvoiceTableTableManager(_$AppDatabase db, $InvoiceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customer_id = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<String> discount_type = const Value.absent(),
            Value<double> discount_amount = const Value.absent(),
            Value<double> tendered = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String> payment_method = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> goods_status = const Value.absent(),
          }) =>
              InvoiceCompanion(
            id: id,
            customer_id: customer_id,
            timestamp: timestamp,
            subtotal: subtotal,
            discount_type: discount_type,
            discount_amount: discount_amount,
            tendered: tendered,
            currency: currency,
            payment_method: payment_method,
            status: status,
            goods_status: goods_status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customer_id,
            required DateTime timestamp,
            required double subtotal,
            required String discount_type,
            required double discount_amount,
            required double tendered,
            required String currency,
            required String payment_method,
            required String status,
            required String goods_status,
          }) =>
              InvoiceCompanion.insert(
            id: id,
            customer_id: customer_id,
            timestamp: timestamp,
            subtotal: subtotal,
            discount_type: discount_type,
            discount_amount: discount_amount,
            tendered: tendered,
            currency: currency,
            payment_method: payment_method,
            status: status,
            goods_status: goods_status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InvoiceTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoiceTable,
    invoices,
    $$InvoiceTableFilterComposer,
    $$InvoiceTableOrderingComposer,
    $$InvoiceTableAnnotationComposer,
    $$InvoiceTableCreateCompanionBuilder,
    $$InvoiceTableUpdateCompanionBuilder,
    (invoices, BaseReferences<_$AppDatabase, $InvoiceTable, invoices>),
    invoices,
    PrefetchHooks Function()>;
typedef $$InvoiceProductTableCreateCompanionBuilder = InvoiceProductCompanion
    Function({
  Value<int> id,
  required int invoice_id,
  required int product_id,
  required int quantity,
  required double price,
});
typedef $$InvoiceProductTableUpdateCompanionBuilder = InvoiceProductCompanion
    Function({
  Value<int> id,
  Value<int> invoice_id,
  Value<int> product_id,
  Value<int> quantity,
  Value<double> price,
});

class $$InvoiceProductTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceProductTable> {
  $$InvoiceProductTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get invoice_id => $composableBuilder(
      column: $table.invoice_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));
}

class $$InvoiceProductTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceProductTable> {
  $$InvoiceProductTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get invoice_id => $composableBuilder(
      column: $table.invoice_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));
}

class $$InvoiceProductTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceProductTable> {
  $$InvoiceProductTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoice_id => $composableBuilder(
      column: $table.invoice_id, builder: (column) => column);

  GeneratedColumn<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);
}

class $$InvoiceProductTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoiceProductTable,
    invoice_products,
    $$InvoiceProductTableFilterComposer,
    $$InvoiceProductTableOrderingComposer,
    $$InvoiceProductTableAnnotationComposer,
    $$InvoiceProductTableCreateCompanionBuilder,
    $$InvoiceProductTableUpdateCompanionBuilder,
    (
      invoice_products,
      BaseReferences<_$AppDatabase, $InvoiceProductTable, invoice_products>
    ),
    invoice_products,
    PrefetchHooks Function()> {
  $$InvoiceProductTableTableManager(
      _$AppDatabase db, $InvoiceProductTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceProductTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceProductTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceProductTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> invoice_id = const Value.absent(),
            Value<int> product_id = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> price = const Value.absent(),
          }) =>
              InvoiceProductCompanion(
            id: id,
            invoice_id: invoice_id,
            product_id: product_id,
            quantity: quantity,
            price: price,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int invoice_id,
            required int product_id,
            required int quantity,
            required double price,
          }) =>
              InvoiceProductCompanion.insert(
            id: id,
            invoice_id: invoice_id,
            product_id: product_id,
            quantity: quantity,
            price: price,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InvoiceProductTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoiceProductTable,
    invoice_products,
    $$InvoiceProductTableFilterComposer,
    $$InvoiceProductTableOrderingComposer,
    $$InvoiceProductTableAnnotationComposer,
    $$InvoiceProductTableCreateCompanionBuilder,
    $$InvoiceProductTableUpdateCompanionBuilder,
    (
      invoice_products,
      BaseReferences<_$AppDatabase, $InvoiceProductTable, invoice_products>
    ),
    invoice_products,
    PrefetchHooks Function()>;
typedef $$RestockTableCreateCompanionBuilder = RestockCompanion Function({
  Value<int> id,
  required int product_id,
  required int supplier_id,
  required int quantity,
  required DateTime timestamp,
});
typedef $$RestockTableUpdateCompanionBuilder = RestockCompanion Function({
  Value<int> id,
  Value<int> product_id,
  Value<int> supplier_id,
  Value<int> quantity,
  Value<DateTime> timestamp,
});

class $$RestockTableFilterComposer
    extends Composer<_$AppDatabase, $RestockTable> {
  $$RestockTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get supplier_id => $composableBuilder(
      column: $table.supplier_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$RestockTableOrderingComposer
    extends Composer<_$AppDatabase, $RestockTable> {
  $$RestockTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get supplier_id => $composableBuilder(
      column: $table.supplier_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$RestockTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestockTable> {
  $$RestockTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => column);

  GeneratedColumn<int> get supplier_id => $composableBuilder(
      column: $table.supplier_id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$RestockTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestockTable,
    restocks,
    $$RestockTableFilterComposer,
    $$RestockTableOrderingComposer,
    $$RestockTableAnnotationComposer,
    $$RestockTableCreateCompanionBuilder,
    $$RestockTableUpdateCompanionBuilder,
    (restocks, BaseReferences<_$AppDatabase, $RestockTable, restocks>),
    restocks,
    PrefetchHooks Function()> {
  $$RestockTableTableManager(_$AppDatabase db, $RestockTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestockTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestockTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestockTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> product_id = const Value.absent(),
            Value<int> supplier_id = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              RestockCompanion(
            id: id,
            product_id: product_id,
            supplier_id: supplier_id,
            quantity: quantity,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int product_id,
            required int supplier_id,
            required int quantity,
            required DateTime timestamp,
          }) =>
              RestockCompanion.insert(
            id: id,
            product_id: product_id,
            supplier_id: supplier_id,
            quantity: quantity,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RestockTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RestockTable,
    restocks,
    $$RestockTableFilterComposer,
    $$RestockTableOrderingComposer,
    $$RestockTableAnnotationComposer,
    $$RestockTableCreateCompanionBuilder,
    $$RestockTableUpdateCompanionBuilder,
    (restocks, BaseReferences<_$AppDatabase, $RestockTable, restocks>),
    restocks,
    PrefetchHooks Function()>;
typedef $$CustomerTableCreateCompanionBuilder = CustomerCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  required String phone_number,
  required String address,
});
typedef $$CustomerTableUpdateCompanionBuilder = CustomerCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> phone_number,
  Value<String> address,
});

class $$CustomerTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone_number => $composableBuilder(
      column: $table.phone_number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));
}

class $$CustomerTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone_number => $composableBuilder(
      column: $table.phone_number,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));
}

class $$CustomerTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerTable> {
  $$CustomerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone_number => $composableBuilder(
      column: $table.phone_number, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$CustomerTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomerTable,
    customers,
    $$CustomerTableFilterComposer,
    $$CustomerTableOrderingComposer,
    $$CustomerTableAnnotationComposer,
    $$CustomerTableCreateCompanionBuilder,
    $$CustomerTableUpdateCompanionBuilder,
    (customers, BaseReferences<_$AppDatabase, $CustomerTable, customers>),
    customers,
    PrefetchHooks Function()> {
  $$CustomerTableTableManager(_$AppDatabase db, $CustomerTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> phone_number = const Value.absent(),
            Value<String> address = const Value.absent(),
          }) =>
              CustomerCompanion(
            id: id,
            name: name,
            email: email,
            phone_number: phone_number,
            address: address,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            required String phone_number,
            required String address,
          }) =>
              CustomerCompanion.insert(
            id: id,
            name: name,
            email: email,
            phone_number: phone_number,
            address: address,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomerTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomerTable,
    customers,
    $$CustomerTableFilterComposer,
    $$CustomerTableOrderingComposer,
    $$CustomerTableAnnotationComposer,
    $$CustomerTableCreateCompanionBuilder,
    $$CustomerTableUpdateCompanionBuilder,
    (customers, BaseReferences<_$AppDatabase, $CustomerTable, customers>),
    customers,
    PrefetchHooks Function()>;
typedef $$SupplierTableCreateCompanionBuilder = SupplierCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$SupplierTableUpdateCompanionBuilder = SupplierCompanion Function({
  Value<int> id,
  Value<String> name,
});

class $$SupplierTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierTable> {
  $$SupplierTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$SupplierTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierTable> {
  $$SupplierTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$SupplierTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierTable> {
  $$SupplierTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$SupplierTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierTable,
    suppliers,
    $$SupplierTableFilterComposer,
    $$SupplierTableOrderingComposer,
    $$SupplierTableAnnotationComposer,
    $$SupplierTableCreateCompanionBuilder,
    $$SupplierTableUpdateCompanionBuilder,
    (suppliers, BaseReferences<_$AppDatabase, $SupplierTable, suppliers>),
    suppliers,
    PrefetchHooks Function()> {
  $$SupplierTableTableManager(_$AppDatabase db, $SupplierTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              SupplierCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              SupplierCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SupplierTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SupplierTable,
    suppliers,
    $$SupplierTableFilterComposer,
    $$SupplierTableOrderingComposer,
    $$SupplierTableAnnotationComposer,
    $$SupplierTableCreateCompanionBuilder,
    $$SupplierTableUpdateCompanionBuilder,
    (suppliers, BaseReferences<_$AppDatabase, $SupplierTable, suppliers>),
    suppliers,
    PrefetchHooks Function()>;
typedef $$InventoryAdjustmentTableCreateCompanionBuilder
    = InventoryAdjustmentCompanion Function({
  Value<int> id,
  required int product_id,
  required String type,
  required int quantity,
  required DateTime timestamp,
});
typedef $$InventoryAdjustmentTableUpdateCompanionBuilder
    = InventoryAdjustmentCompanion Function({
  Value<int> id,
  Value<int> product_id,
  Value<String> type,
  Value<int> quantity,
  Value<DateTime> timestamp,
});

class $$InventoryAdjustmentTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentTable> {
  $$InventoryAdjustmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$InventoryAdjustmentTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentTable> {
  $$InventoryAdjustmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$InventoryAdjustmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentTable> {
  $$InventoryAdjustmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$InventoryAdjustmentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryAdjustmentTable,
    inventory_adjustments,
    $$InventoryAdjustmentTableFilterComposer,
    $$InventoryAdjustmentTableOrderingComposer,
    $$InventoryAdjustmentTableAnnotationComposer,
    $$InventoryAdjustmentTableCreateCompanionBuilder,
    $$InventoryAdjustmentTableUpdateCompanionBuilder,
    (
      inventory_adjustments,
      BaseReferences<_$AppDatabase, $InventoryAdjustmentTable,
          inventory_adjustments>
    ),
    inventory_adjustments,
    PrefetchHooks Function()> {
  $$InventoryAdjustmentTableTableManager(
      _$AppDatabase db, $InventoryAdjustmentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryAdjustmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryAdjustmentTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryAdjustmentTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> product_id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              InventoryAdjustmentCompanion(
            id: id,
            product_id: product_id,
            type: type,
            quantity: quantity,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int product_id,
            required String type,
            required int quantity,
            required DateTime timestamp,
          }) =>
              InventoryAdjustmentCompanion.insert(
            id: id,
            product_id: product_id,
            type: type,
            quantity: quantity,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InventoryAdjustmentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryAdjustmentTable,
    inventory_adjustments,
    $$InventoryAdjustmentTableFilterComposer,
    $$InventoryAdjustmentTableOrderingComposer,
    $$InventoryAdjustmentTableAnnotationComposer,
    $$InventoryAdjustmentTableCreateCompanionBuilder,
    $$InventoryAdjustmentTableUpdateCompanionBuilder,
    (
      inventory_adjustments,
      BaseReferences<_$AppDatabase, $InventoryAdjustmentTable,
          inventory_adjustments>
    ),
    inventory_adjustments,
    PrefetchHooks Function()>;
typedef $$ProductVariantTableCreateCompanionBuilder = ProductVariantCompanion
    Function({
  Value<int> id,
  required int product_id,
  required String variant_type,
  required String name,
  required double price_adjustment,
});
typedef $$ProductVariantTableUpdateCompanionBuilder = ProductVariantCompanion
    Function({
  Value<int> id,
  Value<int> product_id,
  Value<String> variant_type,
  Value<String> name,
  Value<double> price_adjustment,
});

class $$ProductVariantTableFilterComposer
    extends Composer<_$AppDatabase, $ProductVariantTable> {
  $$ProductVariantTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variant_type => $composableBuilder(
      column: $table.variant_type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price_adjustment => $composableBuilder(
      column: $table.price_adjustment,
      builder: (column) => ColumnFilters(column));
}

class $$ProductVariantTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductVariantTable> {
  $$ProductVariantTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variant_type => $composableBuilder(
      column: $table.variant_type,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price_adjustment => $composableBuilder(
      column: $table.price_adjustment,
      builder: (column) => ColumnOrderings(column));
}

class $$ProductVariantTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductVariantTable> {
  $$ProductVariantTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get product_id => $composableBuilder(
      column: $table.product_id, builder: (column) => column);

  GeneratedColumn<String> get variant_type => $composableBuilder(
      column: $table.variant_type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price_adjustment => $composableBuilder(
      column: $table.price_adjustment, builder: (column) => column);
}

class $$ProductVariantTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductVariantTable,
    product_variants,
    $$ProductVariantTableFilterComposer,
    $$ProductVariantTableOrderingComposer,
    $$ProductVariantTableAnnotationComposer,
    $$ProductVariantTableCreateCompanionBuilder,
    $$ProductVariantTableUpdateCompanionBuilder,
    (
      product_variants,
      BaseReferences<_$AppDatabase, $ProductVariantTable, product_variants>
    ),
    product_variants,
    PrefetchHooks Function()> {
  $$ProductVariantTableTableManager(
      _$AppDatabase db, $ProductVariantTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductVariantTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductVariantTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductVariantTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> product_id = const Value.absent(),
            Value<String> variant_type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> price_adjustment = const Value.absent(),
          }) =>
              ProductVariantCompanion(
            id: id,
            product_id: product_id,
            variant_type: variant_type,
            name: name,
            price_adjustment: price_adjustment,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int product_id,
            required String variant_type,
            required String name,
            required double price_adjustment,
          }) =>
              ProductVariantCompanion.insert(
            id: id,
            product_id: product_id,
            variant_type: variant_type,
            name: name,
            price_adjustment: price_adjustment,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductVariantTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductVariantTable,
    product_variants,
    $$ProductVariantTableFilterComposer,
    $$ProductVariantTableOrderingComposer,
    $$ProductVariantTableAnnotationComposer,
    $$ProductVariantTableCreateCompanionBuilder,
    $$ProductVariantTableUpdateCompanionBuilder,
    (
      product_variants,
      BaseReferences<_$AppDatabase, $ProductVariantTable, product_variants>
    ),
    product_variants,
    PrefetchHooks Function()>;
typedef $$AuditLogTableCreateCompanionBuilder = AuditLogCompanion Function({
  Value<int> id,
  required String action_type,
  required String user,
  required DateTime timestamp,
  required String description,
});
typedef $$AuditLogTableUpdateCompanionBuilder = AuditLogCompanion Function({
  Value<int> id,
  Value<String> action_type,
  Value<String> user,
  Value<DateTime> timestamp,
  Value<String> description,
});

class $$AuditLogTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action_type => $composableBuilder(
      column: $table.action_type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$AuditLogTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action_type => $composableBuilder(
      column: $table.action_type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get user => $composableBuilder(
      column: $table.user, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$AuditLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action_type => $composableBuilder(
      column: $table.action_type, builder: (column) => column);

  GeneratedColumn<String> get user =>
      $composableBuilder(column: $table.user, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$AuditLogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditLogTable,
    audit_logs,
    $$AuditLogTableFilterComposer,
    $$AuditLogTableOrderingComposer,
    $$AuditLogTableAnnotationComposer,
    $$AuditLogTableCreateCompanionBuilder,
    $$AuditLogTableUpdateCompanionBuilder,
    (audit_logs, BaseReferences<_$AppDatabase, $AuditLogTable, audit_logs>),
    audit_logs,
    PrefetchHooks Function()> {
  $$AuditLogTableTableManager(_$AppDatabase db, $AuditLogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> action_type = const Value.absent(),
            Value<String> user = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String> description = const Value.absent(),
          }) =>
              AuditLogCompanion(
            id: id,
            action_type: action_type,
            user: user,
            timestamp: timestamp,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String action_type,
            required String user,
            required DateTime timestamp,
            required String description,
          }) =>
              AuditLogCompanion.insert(
            id: id,
            action_type: action_type,
            user: user,
            timestamp: timestamp,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuditLogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuditLogTable,
    audit_logs,
    $$AuditLogTableFilterComposer,
    $$AuditLogTableOrderingComposer,
    $$AuditLogTableAnnotationComposer,
    $$AuditLogTableCreateCompanionBuilder,
    $$AuditLogTableUpdateCompanionBuilder,
    (audit_logs, BaseReferences<_$AppDatabase, $AuditLogTable, audit_logs>),
    audit_logs,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductTableTableManager get product =>
      $$ProductTableTableManager(_db, _db.product);
  $$InvoiceTableTableManager get invoice =>
      $$InvoiceTableTableManager(_db, _db.invoice);
  $$InvoiceProductTableTableManager get invoiceProduct =>
      $$InvoiceProductTableTableManager(_db, _db.invoiceProduct);
  $$RestockTableTableManager get restock =>
      $$RestockTableTableManager(_db, _db.restock);
  $$CustomerTableTableManager get customer =>
      $$CustomerTableTableManager(_db, _db.customer);
  $$SupplierTableTableManager get supplier =>
      $$SupplierTableTableManager(_db, _db.supplier);
  $$InventoryAdjustmentTableTableManager get inventoryAdjustment =>
      $$InventoryAdjustmentTableTableManager(_db, _db.inventoryAdjustment);
  $$ProductVariantTableTableManager get productVariant =>
      $$ProductVariantTableTableManager(_db, _db.productVariant);
  $$AuditLogTableTableManager get auditLog =>
      $$AuditLogTableTableManager(_db, _db.auditLog);
}