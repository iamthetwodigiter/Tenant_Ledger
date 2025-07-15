# Tenant Ledger

Tenant Ledger is a comprehensive Flutter application designed to simplify property management for landlords. It provides a streamlined system for managing tenants, tracking rent payments, generating professional receipts, and monitoring utility usage.

## Table of Contents

- Overview
- Features
- Architecture
- Database Schema
- Installation
- Usage
- PDF Generation
- Contributing
- License

## Overview

Tenant Ledger helps landlords and property managers keep track of tenant information, rent payments, utility charges, and outstanding dues. The application uses Drift (formerly Moor) for local database management and follows a service-based architecture.

## Features

### Tenant Management
- **Add/Edit Tenants**: Store comprehensive tenant details including name, contact information, and emergency contacts
- **Document Storage**: Save and view tenant documents like Aadhar cards with multi-image support
- **Agreement Tracking**: Monitor agreement status, period, and payment terms

### Owner Management
- **Owner Profiles**: Create and manage property owner information
- **Contact Details**: Store owner contact information for tenants
- **UPI Payment Integration**: Save UPI ID for digital payments

### Rent Management
- **Monthly Rent Collection**: Track rent on a monthly basis with due date reminders
- **Utility Billing**: Calculate electricity charges based on meter readings
- **Payment History**: View complete payment history for each tenant
- **Outstanding Dues**: Track pending payments and total dues

### PDF Generation
- **Professional Invoices**: Generate pre-payment invoices for tenants
- **Payment Receipts**: Create official receipts after payment collection
- **Shareable Documents**: Share PDF documents directly from the app
- **Customized Templates**: Well-designed templates with all necessary payment details

### Utility Tracking
- **Meter Reading Management**: Record and track electricity meter readings
- **Automatic Calculations**: Calculate utility charges based on consumption
- **Water Charges**: Include fixed water charges in the monthly bill

### Financial Insights
- **Payment Status**: View paid vs. unpaid status for each tenant
- **Due Amount Tracking**: Monitor outstanding balances
- **Yearly Increment**: Automatic rent increment calculations based on configurable percentages

## Architecture

Tenant Ledger follows a service-based architecture pattern:

### Model
- **Database Layer**: Implemented using Drift (SQLite)
- **Data Models**: Structured data classes for tenants, owners, and rent entries
- **TypeConverters**: Custom converters for complex data types (like List<String> for images)

### View
- **UI Components**: Flutter widgets for displaying and interacting with data
- **State Management**: Uses Flutter's built-in state management solutions
- **Reactive UI**: Updates in response to database and service changes

### Service Layer
- **Database Service**: Handles database operations and data access
- **PDF Service**: Manages PDF generation, rendering, and sharing
- **Utility Services**: Handles calculations and business logic
- **File Management**: Manages document storage and retrieval

## Database Schema

### Tenant Table
```
Table: tenant
- tenantID: Integer (Primary Key, AutoIncrement)
- name: Text
- mobileNo: Text
- aadharNo: Text
- permanentAddress: Text
- emergencyContact: Text
- agreementPeriod: Integer
- aadharImages: Text (Stored as JSON array of paths)
- agreementDone: Boolean
- rentPerMonth: Real
- advancePayment: Real
- totalDueAmount: Real
- monthEntered: DateTime
- monthExit: DateTime (Nullable)
- meterReadingInitial: Real
- meterReadingFinal: Real (Nullable)
- electricityRate: Real
- waterCharges: Real
- perYearIncrement: Real
- createdAt: DateTime
- updatedAt: DateTime
```

### Owner Table
```
Table: owner
- ownerID: Integer (Primary Key, AutoIncrement)
- name: Text
- mobileNo: Text
- address: Text
- upiID: Text (Nullable)
- upiScannerImage: Text (Nullable, path to QR code image)
- idProof: Text (Stored as JSON array of paths)
- propertyDocuments: Text (Stored as JSON array of paths)
- createdAt: DateTime
- updatedAt: DateTime
```

### Rent Table
```
Table: rent
- rentID: Integer (Primary Key, AutoIncrement)
- tenantID: Integer (Foreign Key)
- rentPerMonth: Real
- electricityRate: Real
- rentPaid: Boolean
- currentDueAmount: Real
- totalDueAmount: Real
- amountPaidOn: DateTime (Nullable)
- meterReadingLastMonth: Real
- meterReadingThisMonth: Real
- paymentMode: Text (Nullable)
- totalRentForMonth: Real
- rentMonth: DateTime
- createdAt: DateTime
- updatedAt: DateTime
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/iamthetwodigiter/Tenant_Ledger.git
```

2. Install dependencies:
```bash
cd tenant_ledger
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage

### Adding a New Owner
1. Navigate to the Owner section
2. Fill in owner details including name, contact information, and address
3. Add UPI payment details if available
4. Save the owner profile

### Adding a New Tenant
1. Navigate to the Tenants tab
2. Tap the + button to add a new tenant
3. Fill in all required details including personal information, agreement details, and financial information
4. Capture Aadhar card images using the camera icon
5. Tap "Add Tenant" to save

### Recording Rent Payment
1. Navigate to the Rent tab
2. Tap the + button to add a new rent entry
3. Select the tenant from the dropdown
4. Enter current meter reading and other details
5. Toggle payment status if payment is received
6. Tap "Save" to record the payment

### Generating PDF Documents
1. Navigate to a rent entry detail page
2. Tap "Generate Invoice" to create a pre-payment invoice with UPI details
3. Tap "Payment Receipt" to generate a receipt for paid entries
4. Use the "Share" buttons to share PDFs via messaging apps, email, etc.

## PDF Generation

The app generates two types of PDF documents:

### Rent Invoice (Pre-payment)
- Generated before payment to provide tenants with payment details
- Includes breakdown of rent, utilities, and previous dues
- Shows meter readings and electricity consumption
- Includes owner's UPI ID for digital payments
- Includes payment instructions

### Payment Receipt (Post-payment)
- Generated after payment to provide proof of payment
- Includes paid amount details with breakdown
- Shows "PAID" status prominently
- Includes signature lines for tenant and landlord

PDFs are stored in the device's external storage under the TenantLedger/Receipts directory and can be shared directly from the app.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Developed with ❤️ by [Prabhat Jana](http://github.com/iamthetwodigiter)

---