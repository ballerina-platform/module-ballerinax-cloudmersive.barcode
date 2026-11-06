_Author_:  DimuthuMadushan \
_Created_: 2026/10/09 \
_Updated_: 2026/10/09 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Cloudmersive Barcode. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/cloudmersive/barcode/v1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Update the API Paths
- **Original**: Paths included common prefix `/barcode` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

2. Add the API key security requirement
- **Original**: `securityDefinitions` declared the `Apikey` header scheme, but no top-level `security` requirement referenced it.
- **Updated**: Added top-level `security: [{"Apikey": []}]` to `docs/spec/openapi.json`.
- **Reason**: Without a requirement the generated client has no authentication configuration.

3. Remove the empty `consumes` override
- **Original**: `BatchJob_GetAsyncJobStatus` (`GET /barcode/batch-job/status`) declared `consumes: []`.
- **Updated**: Removed the empty array.
- **Reason**: An empty per-operation `consumes` overrides the global setting and produces generic media types.

4. Correct the Code 128 summary and description
- **Original**: `GenerateBarcode_Code128` was summarised as "Generate a EAN-13 code barcode as PNG file" and described as generating an EAN-13 barcode.
- **Updated**: Summary is "Generate a Code 128 barcode as PNG file" and the description refers to Code 128.
- **Reason**: The text contradicted the operation.

5. Fix the `height` header parameter descriptions
- **Original**: The `height` header on the six `GenerateBarcode_*` operations was described as "width of the barcode in pixels".
- **Updated**: Changed to "height of the barcode in pixels".
- **Reason**: Copy-paste error in the source description.

6. Replace generic `OK` response descriptions
- **Original**: Every `200` response was described as `OK`.
- **Updated**: Each now describes what is returned, for example "Product data for the matched barcode" or "PNG image of the generated QR code".
- **Reason**: Improves the generated return documentation.

7. Rename operations (recorded in `ai-mappings.json`)
- **Original**: operationIds of the form `Group_Operation`.
- **Updated**: `BarcodeLookup_EanLookup` -> `lookupEanBarcode`, `BarcodeScan_Image` -> `scanBarcodeImage`, `BarcodeScan_ImageAdvanced` -> `scanBarcodeImageAdvanced`, `BarcodeScan_ImageAdvancedQR` -> `scanQrBarcodeImageAdvanced`, `BatchJob_ScanImageAdvancedQRBatchJob` -> `createQrScanBatchJob`, `BatchJob_GetAsyncJobStatus` -> `getBatchJobStatus`, `GenerateBarcode_QRCode` -> `generateQrCode`, `GenerateBarcode_UPCA` -> `generateUpcABarcode`, `GenerateBarcode_UPCE` -> `generateUpcEBarcode`, `GenerateBarcode_EAN13` -> `generateEan13Barcode`, `GenerateBarcode_EAN8` -> `generateEan8Barcode`, `GenerateBarcode_Code128` -> `generateCode128Barcode`.
- **Reason**: Concise, intent-revealing Ballerina method names.

8. Rename the multipart request schema (recorded in `ai-mappings.json`)
- **Original**: `ScanImageBody`.
- **Updated**: `ScanBarcodeImageRequest`.
- **Reason**: Name the shared image upload body after its purpose.

9. Collapse the double slash in the server URL (edit to the aligned spec; re-apply after a re-align)
- **Original**: After the `/barcode` prefix is folded into the server, the aligned spec's server URL is `https://api.cloudmersive.com//barcode`.
- **Updated**: `https://api.cloudmersive.com/barcode` in `docs/spec/aligned_ballerina_openapi.json`.
- **Reason**: The doubled slash is invalid in the generated default `serviceUrl`.

10. Use the production host
- **Original**: `host` was `testapi.cloudmersive.com`, Cloudmersive's test endpoint.
- **Updated**: `api.cloudmersive.com`, so the client's default `serviceUrl` is `https://api.cloudmersive.com/barcode`.
- **Reason**: The connector should target the production API by default.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

