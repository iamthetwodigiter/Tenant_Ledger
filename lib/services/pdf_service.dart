import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tenant_ledger/services/db_connection.dart';
import 'package:tenant_ledger/util/util_methods.dart';

class PdfService {
  // Generate a rent invoice (pre-payment)
  Future<File> generateRentInvoice(
    RentData rent,
    TenantData tenant,
    OwnerData owner,
  ) async {
    final pdf = pw.Document();

    final font = await rootBundle.load("assets/fonts/SF-Pro.ttf");
    final ttf = pw.Font.ttf(font);
    final boldFont = await rootBundle.load("assets/fonts/SF-Pro.ttf");
    final boldTtf = pw.Font.ttf(boldFont);

    final unitsConsumed =
        rent.meterReadingThisMonth - rent.meterReadingLastMonth;
    final electricityBill = unitsConsumed * rent.electricityRate;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'RENT INVOICE',
                          style: pw.TextStyle(
                            font: boldTtf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 24,
                            color: PdfColors.blue900,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'Invoice Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          'Invoice #: INV-${rent.rentID}-${DateFormat('yyyyMMdd').format(rent.rentMonth)}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          owner.name,
                          style: pw.TextStyle(
                            font: boldTtf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                            color: PdfColors.blue900,
                          ),
                        ),
                        pw.Text(
                          owner.propertyName,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          owner.address,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          '${owner.city}, ${owner.state}, ${owner.pinCode}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          'Phone: ${owner.phone}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 30),

                // Tenant Information
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Bill To:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            tenant.name,
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.Text(
                            'Mobile: ${tenant.mobileNo}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.Spacer(),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Rent Period:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            '${formatDate(rent.rentMonth)} - ${formatDate(rent.rentMonth.add(Duration(days: 30)))}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            'Due Date: ${DateFormat('dd MMM yyyy').format(DateTime(rent.rentMonth.year, rent.rentMonth.month, 10))}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),

                // Invoice Items
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(3),
                  },
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.blue100),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Description',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Quantity',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Rate',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Amount',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                      ],
                    ),
                    // Base Rent
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Base Monthly Rent',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('1', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${rent.rentPerMonth.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${rent.rentPerMonth.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Water Charges
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Water Charges',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('1', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${tenant.waterCharges.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${tenant.waterCharges.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Electricity
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Electricity Charges',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '${unitsConsumed.toStringAsFixed(1)} units',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${rent.electricityRate.toStringAsFixed(2)}/unit',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${electricityBill.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Previous Due
                    if (rent.currentDueAmount > 0)
                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.red50),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              'Previous Due Amount',
                              style: pw.TextStyle(font: ttf),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('1', style: pw.TextStyle(font: ttf)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('-', style: pw.TextStyle(font: ttf)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '₹${rent.currentDueAmount.toStringAsFixed(2)}',
                              style: pw.TextStyle(font: ttf),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Total
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    width: 250,
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Subtotal:',
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                            ),
                            pw.Text(
                              '₹${(rent.rentPerMonth + tenant.waterCharges + electricityBill).toStringAsFixed(2)}',
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        if (rent.currentDueAmount > 0)
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Previous Due:',
                                style: pw.TextStyle(font: ttf, fontSize: 12),
                              ),
                              pw.Text(
                                '₹${rent.currentDueAmount.toStringAsFixed(2)}',
                                style: pw.TextStyle(font: ttf, fontSize: 12),
                              ),
                            ],
                          ),
                        pw.SizedBox(height: 5),
                        pw.Divider(thickness: 1),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'TOTAL DUE:',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            pw.Text(
                              '₹${rent.totalRentForMonth.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.red900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                pw.SizedBox(height: 40),

                // Meter Reading Details
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Electricity Meter Details:',
                        style: pw.TextStyle(
                          font: boldTtf,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Previous Reading:',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            '${rent.meterReadingLastMonth.toStringAsFixed(1)} units',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Current Reading:',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            '${rent.meterReadingThisMonth.toStringAsFixed(1)} units',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Units Consumed:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            '${unitsConsumed.toStringAsFixed(1)} units',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Electricity Rate:',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            '₹${rent.electricityRate.toStringAsFixed(2)}/unit',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),

                // UPI Payment Details
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.blue300),
                    borderRadius: pw.BorderRadius.circular(5),
                    color: PdfColors.blue50,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'UPI Payment Details:',
                        style: pw.TextStyle(
                          font: boldTtf,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                          color: PdfColors.blue900,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        owner.upiID != null && owner.upiID!.isNotEmpty
                            ? 'UPI ID: ${owner.upiID}'
                            : 'UPI ID: Not provided',
                        style: pw.TextStyle(font: ttf, fontSize: 12),
                      ),
                      pw.SizedBox(height: 15),

                      // QR Code text even if image isn't available
                      pw.Text(
                        'Contact owner for UPI QR code',
                        style: pw.TextStyle(font: ttf, fontSize: 10),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'Please mention tenant name and month in the UPI payment note',
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 10,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),

                // Payment Instructions
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Payment Instructions:',
                        style: pw.TextStyle(
                          font: boldTtf,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '1. Please pay the amount before the due date to avoid late fees.',
                        style: pw.TextStyle(font: ttf, fontSize: 10),
                      ),
                      pw.Text(
                        '2. Payment can be made by cash, cheque, or online transfer.',
                        style: pw.TextStyle(font: ttf, fontSize: 10),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'Note: This is a computer-generated invoice and does not require a signature.',
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 10,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),

                // Footer
                pw.Footer(
                  leading: pw.Text(
                    'Generated on: ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())}',
                    style: pw.TextStyle(font: ttf, fontSize: 8),
                  ),
                  title: pw.Text(
                    'Thank you for your business!',
                    style: pw.TextStyle(font: ttf, fontSize: 8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = Directory('/storage/emulated/0/TenantLedger/Receipts');
    if (!output.existsSync()) {
      output.createSync(recursive: true);
    }

    final file = File(
      '${output.path}/Invoice_${tenant.name.replaceAll(' ', '_')}_${DateFormat('MMM_yyyy').format(rent.rentMonth)}.pdf',
    );

    try {
      final pdfBytes = await pdf.save();
      await file.writeAsBytes(pdfBytes);
    } catch (saveError) {
      throw Exception('Failed to save PDF file: $saveError');
    }

    return file;
  }

  // Generate a payment receipt (post-payment)
  Future<File> generatePaymentReceipt(
    RentData rent,
    TenantData tenant,
    OwnerData owner,
  ) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/SF-Pro.ttf");
    final ttf = pw.Font.ttf(font);
    final boldFont = await rootBundle.load("assets/fonts/SF-Pro.ttf");
    final boldTtf = pw.Font.ttf(boldFont);

    final unitsConsumed =
        rent.meterReadingThisMonth - rent.meterReadingLastMonth;
    final electricityBill = unitsConsumed * rent.electricityRate;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'PAYMENT RECEIPT',
                          style: pw.TextStyle(
                            font: boldTtf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 24,
                            color: PdfColors.green900,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'Receipt Date: ${DateFormat('dd MMM yyyy').format(rent.amountPaidOn ?? DateTime.now())}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          'Receipt #: RCPT-${rent.rentID}-${DateFormat('yyyyMMdd').format(rent.amountPaidOn ?? DateTime.now())}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          owner.name,
                          style: pw.TextStyle(
                            font: boldTtf,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                            color: PdfColors.green900,
                          ),
                        ),
                        pw.Text(
                          owner.propertyName,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          owner.address,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          '${owner.city}, ${owner.state}, ${owner.pinCode}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                        pw.Text(
                          'Phone: ${owner.phone}',
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Receipt Status
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.green100,
                    borderRadius: pw.BorderRadius.circular(5),
                    border: pw.Border.all(color: PdfColors.green700),
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      'PAID',
                      style: pw.TextStyle(
                        font: boldTtf,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 24,
                        color: PdfColors.green900,
                      ),
                    ),
                  ),
                ),

                pw.SizedBox(height: 20),

                // Tenant Information
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Receipt To:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            tenant.name,
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.Text(
                            'Mobile: ${tenant.mobileNo}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.Spacer(),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Payment Details:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Rent Period: ${formatDate(rent.rentMonth)} - ${formatDate(rent.rentMonth.add(Duration(days: 30)))}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            'Payment Date: ${DateFormat('dd MMM yyyy').format(rent.amountPaidOn ?? DateTime.now())}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            'Payment Mode: ${rent.paymentMode?.toUpperCase() ?? "CASH"}',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),

                // Receipt Items
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(5),
                    1: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey200),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Description',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Amount',
                            style: pw.TextStyle(font: boldTtf),
                          ),
                        ),
                      ],
                    ),
                    // Base Rent
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Base Monthly Rent',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${rent.rentPerMonth.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Water Charges
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Water Charges',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${tenant.waterCharges.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Electricity
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Electricity Charges (${unitsConsumed.toStringAsFixed(1)} units × ₹${rent.electricityRate.toStringAsFixed(2)}/unit)',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            '₹${electricityBill.toStringAsFixed(2)}',
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                    // Previous Due if any
                    if (rent.currentDueAmount > 0)
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              'Previous Due Amount',
                              style: pw.TextStyle(font: ttf),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '₹${rent.currentDueAmount.toStringAsFixed(2)}',
                              style: pw.TextStyle(font: ttf),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Total
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    width: 250,
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.green50,
                      borderRadius: pw.BorderRadius.circular(5),
                      border: pw.Border.all(color: PdfColors.green200),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Total Amount:',
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                            ),
                            pw.Text(
                              '₹${rent.totalRentForMonth.toStringAsFixed(2)}',
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Divider(thickness: 1, color: PdfColors.green200),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'PAID AMOUNT:',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            pw.Text(
                              '₹${rent.totalRentForMonth.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.green900,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'REMAINING DUE:',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            pw.Text(
                              '₹0.00',
                              style: pw.TextStyle(
                                font: boldTtf,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                                color: PdfColors.green900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                pw.SizedBox(height: 30),

                // Meter Reading Details
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Electricity Meter Details:',
                        style: pw.TextStyle(
                          font: boldTtf,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Previous Reading:',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            '${rent.meterReadingLastMonth.toStringAsFixed(1)} units',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Current Reading:',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                          pw.Text(
                            '${rent.meterReadingThisMonth.toStringAsFixed(1)} units',
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Units Consumed:',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          pw.Text(
                            '${unitsConsumed.toStringAsFixed(1)} units',
                            style: pw.TextStyle(
                              font: boldTtf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 40),

                // Signature
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(width: 150, child: pw.Divider()),
                        pw.Text(
                          'Tenant Signature',
                          style: pw.TextStyle(font: ttf, fontSize: 10),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(width: 150, child: pw.Divider()),
                        pw.Text(
                          'Landlord Signature',
                          style: pw.TextStyle(font: ttf, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.Spacer(),

                // Footer
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'Thank you for your payment!',
                        style: pw.TextStyle(
                          font: boldTtf,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                          color: PdfColors.green800,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'This is a computer-generated receipt and does not require a signature.',
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 10,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'Generated on: ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())}',
                        style: pw.TextStyle(font: ttf, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = Directory('/storage/emulated/0/TenantLedger/Receipts');
    if (!output.existsSync()) {
      output.createSync(recursive: true);
    }
    final file = File(
      '${output.path}/Receipt_${tenant.name.replaceAll(' ', '_')}_${DateFormat('MMM_yyyy').format(rent.rentMonth)}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // Function to open the PDF file
  Future<void> openPDF(File file) async {
    await OpenFile.open(file.path);
  }

  // Function to share the PDF file
  Future<void> sharePDF(File file, String title) async {
    await SharePlus.instance.share(
      ShareParams(text: title, files: [XFile(file.path)]),
    );
  }
}
