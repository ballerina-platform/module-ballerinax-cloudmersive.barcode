import ballerina/io;
import ballerinax/cloudmersive.barcode;

configurable string apiKey = ?;
configurable string barcodeImagePath = ?;

// Reads the value from a barcode image, then looks up the matching product when it is an EAN code.
public function main() returns error? {
    barcode:Client barcodeClient = check new ({apikey: apiKey});

    byte[] imageContent = check io:fileReadBytes(barcodeImagePath);
    barcode:BarcodeScanResult scan = check barcodeClient->scanBarcodeImage({
        imageFile: {fileContent: imageContent, fileName: "barcode.png"}
    });
    string? rawText = scan?.rawText;
    if scan?.successful != true || rawText is () {
        return error("No barcode could be recognized in the image");
    }
    io:println("Barcode type: ", scan?.barcodeType, ", value: ", rawText);

    string? barcodeType = scan?.barcodeType;
    if barcodeType is string && (barcodeType == "EAN_13" || barcodeType == "EAN_8") {
        barcode:BarcodeLookupResponse lookup = check barcodeClient->lookupEanBarcode(rawText);
        barcode:ProductMatch[] matches = lookup?.matches ?: [];
        foreach barcode:ProductMatch product in matches {
            io:println("Matched product: ", product?.title);
        }
    }
}
