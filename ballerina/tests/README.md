# Running Tests

## Prerequisites

You need a Cloudmersive API key to run the tests against the live API. The default mock run needs no credentials.

## Test environments

The suite runs in two modes.

| Mode | How to run | Behaviour |
|---|---|---|
| Mock server (default) | `bal test` | Requests are served by `tests/mock_service.bal` on `localhost:9090` |
| Live server | `IS_LIVE_SERVER=true CLOUDMERSIVE_API_KEY=<key> bal test --groups live_tests` | Requests go to `https://api.cloudmersive.com/barcode` |

The tests read `IS_LIVE_SERVER` and `CLOUDMERSIVE_API_KEY` from the environment.

## Coverage

One test per operation: `lookupEanBarcode`, `scanBarcodeImage`, `scanBarcodeImageAdvanced`, `scanQrBarcodeImageAdvanced`, `createQrScanBatchJob`, `getBatchJobStatus`, `generateQrCode`, `generateUpcABarcode`, `generateUpcEBarcode`, `generateEan13Barcode`, `generateEan8Barcode` and `generateCode128Barcode`. Each is tagged with the `mock_tests` group, and all except the batch job operations (which need a Managed Instance or Private Cloud deployment) are also tagged `live_tests`.

```bash
bal test --groups mock_tests
```
