// ignore_for_file: unused_import

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import '../tools/helper.dart';
import 'view.list.dart';

part 'model.g.dart';
// part 'model.g.view.dart'; // you do not need this part if you do not want to use the Form Generator property

const tableUser = SqfEntityTable(
  tableName: "users",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField("username", DbType.text), // Username with max length
    SqfEntityField("password", DbType.text), // Password (hashed and secured)
    SqfEntityField("email", DbType.text), // Unique email address
    SqfEntityField("firstName", DbType.text),
    SqfEntityField("lastName", DbType.text),
    // Add more fields as needed (e.g., phone number, address)
  ],
);


// CATEGORIES
const tableCategory = SqfEntityTable(
    tableName: 'category',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
    ]);

//Product Table
const tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('description', DbType.text),
      SqfEntityField('cost', DbType.real),
      SqfEntityField('price', DbType.real),
      SqfEntityField('quantity', DbType.integer),
      SqfEntityFieldRelationship(
          parentTable: tableCategory,
          isNotNull: false,
          defaultValue: 0,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.SET_NULL),
      SqfEntityField('reference', DbType.integer, sequencedBy: seqIdentity),
      SqfEntityField('image_url', DbType.text),
      SqfEntityField("expiry_date", DbType.datetime),
      SqfEntityField("date", DbType.datetime),
    ]);

// Payment methods Table
const tablePaymentMethods = SqfEntityTable(
    tableName: "paymentMethods",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField("name", DbType.text),
      SqfEntityField("description", DbType.text),
      SqfEntityField("date", DbType.datetime),
    ]);

// LEAD / CUSTOMER
const tableLead = SqfEntityTable(
    tableName: "lead",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('email', DbType.text),
      SqfEntityField('phone', DbType.text),
      SqfEntityField('date', DbType.datetime),
    ]);

// SUPPLIER
const tableSupplier = SqfEntityTable(
    tableName: "supplier",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('email', DbType.text),
      SqfEntityField('phone', DbType.text),
      SqfEntityField('description', DbType.text),
      SqfEntityField('date', DbType.datetime),
    ]);

// Payment Details
const tablePaymentDetails = SqfEntityTable(
    tableName: "paymentDetails",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityFieldRelationship(
          deleteRule: DeleteRule.CASCADE,
          relationType: RelationType.ONE_TO_MANY,
          parentTable: tablePaymentMethods,
          defaultValue: 0
          ),
      SqfEntityField("details", DbType.text),
      SqfEntityField("date", DbType.date),
    ]);

// Order Table
const tableOrders = SqfEntityTable(
    tableName: "orders",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
       SqfEntityFieldRelationship(
          parentTable: tableSales,
          deleteRule: DeleteRule.CASCADE,
          relationType: RelationType.ONE_TO_MANY,
          defaultValue: 0),
      SqfEntityFieldRelationship(
          parentTable: tableProduct,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0),
      SqfEntityField("quantity", DbType.integer),
      SqfEntityField("amount", DbType.real),
    ]);

// Invoice Table
const tableInvoice = SqfEntityTable(
    tableName: "invoice",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityFieldRelationship(
          parentTable: tableSales,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0,

          ),
   
      SqfEntityField("customer_name", DbType.text),
      SqfEntityField("invoice_number", DbType.text),
      SqfEntityField("amount", DbType.real),
      SqfEntityField("date", DbType.datetime),
    ]);

// Payment Table
const tablePayment = SqfEntityTable(
    tableName: "payment",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('number', DbType.integer, sequencedBy: seqIdentity),
      SqfEntityFieldRelationship(
          parentTable: tablePaymentMethods,
          deleteRule: DeleteRule.CASCADE,
          relationType: RelationType.ONE_TO_MANY,
          defaultValue: 0),
      SqfEntityFieldRelationship(
          fieldName: 'sale',
          parentTable: tableSales,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0),
      SqfEntityField("amount", DbType.real),
      SqfEntityField("description", DbType.text),
      SqfEntityField("date", DbType.datetime),
    ]);

// Expense
const tableExpense = SqfEntityTable(
    tableName: 'expense',
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField("name", DbType.text),
      SqfEntityField("amount", DbType.real),
      SqfEntityField("description", DbType.text),
      SqfEntityField("date", DbType.datetime),
    ]);

// Sales Table
const tableSales = SqfEntityTable(
    tableName: "sales",
    primaryKeyName: "id",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
     
      SqfEntityField("date", DbType.datetime),
      SqfEntityField("isCredit", DbType.bool),
      SqfEntityField("amount", DbType.real),
    ]);


// Profit and Loss Period Table
const tablePeriod = SqfEntityTable(
    tableName: 'period',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "period",
    fields: [
      SqfEntityField("start_date", DbType.date),
      SqfEntityField("end_date", DbType.date),
    ]);

// Profit and Loss Table
const tableProfitAndLoss = SqfEntityTable(
    tableName: 'profitAndLoss',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "profitAndLoss",
    fields: [
      SqfEntityFieldRelationship(
          parentTable: tablePeriod,
          relationType: RelationType.ONE_TO_ONE,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0), // Relationship column for CategoryId of Product
      SqfEntityField("revenue", DbType.real),
      SqfEntityField("cost", DbType.real),
      SqfEntityField("expense", DbType.real),
      SqfEntityField("profit", DbType.real),
      SqfEntityField("date", DbType.datetime),
    ]);

// For Keeping track of changes in product

const tableProductRecords = SqfEntityTable(
  tableName: "productRecords",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
  SqfEntityFieldRelationship(
          parentTable: tableProduct,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.SET_NULL,
          defaultValue: 0),     
    SqfEntityField("name", DbType.text), // Username with max length
    SqfEntityField("currentQuantity", DbType.text), // Username with max length
    SqfEntityField("previousQuantity", DbType.text), 
    SqfEntityField("action", DbType.text), // Unique email address
     SqfEntityField("date", DbType.datetime),// Password (hashed and secured)
    
    // Add more fields as needed (e.g., phone number, address)
  ],
);


const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  // maxValue:  10000, /* optional. default is max int (9.223.372.036.854.775.807) */
  // modelName: 'SQEidentity',
  /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
  // cycle : false,   /* optional. default is false; */
  // minValue = 0;    /* optional. default is 0 */
  // incrementBy = 1; /* optional. default is 1 */
  // startWith = 0;   /* optional. default is 0 */
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'SalesSafeDbModel', // optional
  databaseName: 'sales_safe.db',
  // put defined tables into the tables list.
  databaseTables: [
    tableCategory,
    tableProduct,
    tableLead,
    tableSupplier,
    tablePaymentMethods,
    tablePaymentDetails,
    tableOrders,
    tableInvoice,
    tablePayment,
    tableSales,
    tablePeriod,
    tableExpense,
    tableProfitAndLoss,
    tableUser,
  ],
 
  // put defined sequences into the sequences list.
  sequences: [seqIdentity],
);
