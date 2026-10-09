import ballerina/io;
import ballerinax/cloudmersive.barcode;

configurable string apiKey = ?;
configurable string productEan = ?;
configurable string labelOutputPath = "product_label.png";
configurable int labelWidth = 300;
configurable int labelHeight = 150;

// Looks up a product by its EAN, then generates an EAN-13 barcode label image for it.
public function main() returns error? {
    barcode:Client barcodeClient = check new ({apikey: apiKey});

    barcode:BarcodeLookupResponse lookup = check barcodeClient->lookupEanBarcode(productEan);
    barcode:ProductMatch[]? matches = lookup?.matches;
    if matches is () || matches.length() == 0 {
        return error(string `No product found for EAN ${productEan}`);
    }
    io:println("Product: ", matches[0]?.title);

    byte[] label = check barcodeClient->generateEan13Barcode(productEan, {
        width: labelWidth,
        height: labelHeight,
        includeLabel: true
    });
    check io:fileWriteBytes(labelOutputPath, label);
    io:println("Barcode label written to ", labelOutputPath);
}
