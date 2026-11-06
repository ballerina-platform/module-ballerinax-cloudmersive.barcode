## Overview

The Cloudmersive Barcode connector provides programmatic access to the [Cloudmersive Barcode API](https://api.cloudmersive.com/docs/barcode.asp), which lets you generate barcode images and recognize values from images of barcodes. This connector supports version 1 of the API and lets Ballerina applications scan barcode images, look up product data for EAN codes, and generate QR, UPC, EAN and Code 128 barcodes with a few remote method calls.
### Key features

- Recognize the value and type of a barcode in an image, including advanced AI recognition of multiple barcodes and QR codes
- Look up product details for an EAN barcode value
- Generate QR, UPC-A, UPC-E, EAN-8, EAN-13 and Code 128 barcodes as PNG images
- Submit QR code recognition as a batch job and poll its status
- Authenticate with a single Cloudmersive API key


## Setup guide

To use this connector you need a Cloudmersive API key.

1. Sign up or log in at the [Cloudmersive portal](https://account.cloudmersive.com/).
2. Open the **API Keys** page of your account.
3. Create a new API key, or copy an existing one.
4. Supply the key as the `apikey` field when you initialize the client. Keep it out of source control, for example by reading it from `Config.toml`.

## Quickstart

1. Add the import:

    ```ballerina
    import ballerinax/cloudmersive.barcode;
    ```

2. Create a `Config.toml` with your API key:

    ```toml
    apiKey = "<YOUR_API_KEY>"
    ```

3. Declare the configurable for the API key:

    ```ballerina
    configurable string apiKey = ?;
    ```

4. Create the client and invoke an operation:

    ```ballerina
    public function main() returns error? {
        barcode:Client barcodeClient = check new ({apikey: apiKey});
        barcode:BarcodeLookupResponse _ = check barcodeClient->lookupEanBarcode("5901234123457");
    }
    ```

## Examples

The `Cloudmersive Barcode` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.barcode/tree/main/examples/), covering the following use cases:

- [product_label_generation](../examples/product_label_generation/product_label_generation.md) - Look up a product by EAN and generate its barcode label image.
- [barcode_image_lookup](../examples/barcode_image_lookup/barcode_image_lookup.md) - Read a barcode from an image and look up the matching product.
