# Barcode image lookup

Reads the barcode value from an image with the Cloudmersive Barcode API and, when the barcode is an EAN code, looks up the matching product.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  barcodeImagePath = "<PATH_TO_BARCODE_IMAGE>"
  ```

## Run the example

```bash
bal run
```
