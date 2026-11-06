# Examples

The `ballerinax/cloudmersive.barcode` connector provides practical examples illustrating usage in various scenarios.

1. [product_label_generation](./product_label_generation/product_label_generation.md) - Look up a product by EAN and generate its barcode label image.
2. [barcode_image_lookup](./barcode_image_lookup/barcode_image_lookup.md) - Read a barcode from an image and look up the matching product.

## Prerequisites

1. A Cloudmersive API key, supplied through each example's `Config.toml`.
2. Ballerina Swan Lake 2201.12.0 or later.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
