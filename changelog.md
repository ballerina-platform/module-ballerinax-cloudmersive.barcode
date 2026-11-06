# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Remote methods for barcode scanning and batch jobs: `scanBarcodeImage`, `scanBarcodeImageAdvanced`, `scanQrBarcodeImageAdvanced`, `createQrScanBatchJob` and `getBatchJobStatus`, with the records they use (`ScanBarcodeImageRequest`, `BarcodeAdvancedScanResult`, `BarcodeAdvancedResultItem`, `BarcodeScanQRAdvancedResult`, `BarcodeQRResultItem`, `BarcodeBatchJobResult`, `BarcodeBatchJobStatusResult`).
- `generateCode128Barcode`, which generates a Code 128 barcode as a PNG image.
- A `headers` parameter on every remote method. The barcode generation methods take a typed headers record (for example `GenerateQrCodeHeaders`) for the optional `width` and `height` of the image.
- New `ConnectionConfig` fields, taken from `http:ClientConfiguration`: `followRedirects`, `cookieConfig`, `socketConfig` and `laxDataBinding`.

### Changed

- **Breaking:** the remote methods are renamed:
  - `barcodeEanLookup` is now `lookupEanBarcode`.
  - `generateBarcodeQrcode` is now `generateQrCode`.
  - `generateBarcodeUpca` is now `generateUpcABarcode`.
  - `generateBarcodeUpce` is now `generateUpcEBarcode`.
  - `generateBarcodeEan13` is now `generateEan13Barcode`.
  - `generateBarcodeEan8` is now `generateEan8Barcode`.
- **Breaking:** the barcode generation methods return the PNG image as `byte[]` (was `string`).
- **Breaking:** record fields use camel case, mapped to the API's Pascal-case JSON names with `@jsondata:Name`. For example, `BarcodeLookupResponse.Successful` is now `successful`, and `ProductMatch.EAN` is now `eAN`.
- **Breaking:** the default `serviceUrl` is `https://api.cloudmersive.com/barcode`, Cloudmersive's production endpoint (was the test endpoint `https://testapi.cloudmersive.com/`). A custom `serviceUrl` must now include the `/barcode` path.
- **Breaking:** `ConnectionConfig.http1Settings` is now `http:ClientHttp1Settings` (was the connector's own `ClientHttp1Settings`).
- `ConnectionConfig.timeout` defaults to 30 seconds (was 60).

### Removed

- **Breaking:** the connector's own `ClientHttp1Settings` and `ProxyConfig` records. Use `http:ClientHttp1Settings` and `http:ProxyConfig` instead.
