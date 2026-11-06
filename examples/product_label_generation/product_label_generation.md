# Product label generation

Looks up a product by its EAN code with the Cloudmersive Barcode API, and then generates an EAN-13 barcode label image for that product.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<YOUR_API_KEY>"
  productEan = "<EAN_13_CODE>"
  labelOutputPath = "product_label.png"
  labelWidth = 300
  labelHeight = 150
  ```

## Run the example

```bash
bal run
```
