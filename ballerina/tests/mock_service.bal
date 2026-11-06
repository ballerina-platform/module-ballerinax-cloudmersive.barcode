// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

// A complete 1x1 grayscale PNG (signature, IHDR, IDAT, IEND) returned for every generated barcode image.
final byte[] & readonly pngBytes = [
    137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 1, 0, 0, 0, 1, 8, 0, 0, 0, 0, 58, 126,
    155, 85, 0, 0, 0, 10, 73, 68, 65, 84, 120, 156, 99, 248, 15, 0, 1, 1, 1, 0, 177, 56, 246, 20, 0, 0, 0, 0, 73,
    69, 78, 68, 174, 66, 96, 130
];

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {

    # Get the status and result of a Barcode Batch Job
    #
    # + asyncJobID - Job ID for the batch job to get the status of
    # + return - Status and, once completed, result of the barcode batch job
    resource function get batch\-job/status(@http:Query {name: "AsyncJobID"} string asyncJobID) returns BarcodeBatchJobStatusResult {
        return {
            asyncJobID,
            asyncJobStatus: "COMPLETED",
            successful: true,
            qRScanResult: {
                barcodeCount: 1,
                resultBarcodes: [{rawText: "https://example.com/product/1234"}],
                successful: true
            }
        };
    }

    # Advanced AI scan and recognition of an image of one or more QR barcodes as a Batch Job
    #
    # + preprocessing - Optional preprocessing mode
    # + recognitionMode - Optional recognition mode
    # + request - Multipart request carrying the image file
    # + return - Identifier of the created barcode batch job
    resource function post batch\-job/scan/image/advanced/qr(@http:Header string? preprocessing, @http:Header string? recognitionMode, http:Request request) returns BarcodeBatchJobResult {
        return {asyncJobID: "b6a1d3f0-5c1e-4f6e-9a57-2f1c3d8e7a90", successful: true};
    }

    # Generate a Code 128 barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels
    # + height - Optional: height of the barcode in pixels
    # + includeLabel - Optional: show text label on the barcode image
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated Code 128 barcode
    resource function post generate/code\-128(@http:Header int? width, @http:Header int? height, @http:Header boolean? includeLabel, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Generate a EAN-13 code barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels
    # + height - Optional: height of the barcode in pixels
    # + includeLabel - Optional: show text label on the barcode image
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated EAN-13 barcode
    resource function post generate/ean\-13(@http:Header int? width, @http:Header int? height, @http:Header boolean? includeLabel, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Generate a EAN-8 code barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels
    # + height - Optional: height of the barcode in pixels
    # + includeLabel - Optional: show text label on the barcode image
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated EAN-8 barcode
    resource function post generate/ean\-8(@http:Header int? width, @http:Header int? height, @http:Header boolean? includeLabel, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Generate a QR code barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels.  Minimum value of 10
    # + height - Optional: height of the barcode in pixels.  Minimum value of 10
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated QR code
    resource function post generate/qrcode(@http:Header int? width, @http:Header int? height, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Generate a UPC-A code barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels
    # + height - Optional: height of the barcode in pixels
    # + includeLabel - Optional: show text label on the barcode image
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated UPC-A barcode
    resource function post generate/upc\-a(@http:Header int? width, @http:Header int? height, @http:Header boolean? includeLabel, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Generate a UPC-E code barcode as PNG file
    #
    # + width - Optional: width of the barcode in pixels
    # + height - Optional: height of the barcode in pixels
    # + includeLabel - Optional: show text label on the barcode image
    # + request - Request carrying the barcode value to generate from
    # + return - PNG image of the generated UPC-E barcode
    resource function post generate/upc\-e(@http:Header int? width, @http:Header int? height, @http:Header boolean? includeLabel, http:Request request) returns byte[] {
        return pngBytes;
    }

    # Lookup EAN barcode value, return product data
    #
    # + request - Request carrying the barcode value to generate from
    # + return - Product data for the matched barcode
    resource function post lookup/ean(http:Request request) returns BarcodeLookupResponse {
        return {
            matches: [
                {eAN: "5901234123457", title: "Organic Whole Grain Oat Cereal 500g"}
            ],
            successful: true
        };
    }

    # Scan and recognize an image of a barcode
    #
    # + request - Multipart request carrying the image file
    # + return - Recognized value and type of the barcode in the image
    resource function post scan/image(http:Request request) returns BarcodeScanResult {
        return {rawText: "5901234123457", barcodeType: "EAN_13", successful: true};
    }

    # Advanced AI scan and recognition of an image of one or more barcodes of any type
    #
    # + request - Multipart request carrying the image file
    # + return - Recognized barcodes found in the image
    resource function post scan/image/advanced(http:Request request) returns BarcodeAdvancedScanResult {
        return {
            barcodeCount: 2,
            resultBarcodes: [
                {rawText: "5901234123457", barcodeType: "EAN_13"},
                {rawText: "https://example.com/product/1234", barcodeType: "QR_CODE"}
            ],
            successful: true
        };
    }

    # Advanced AI scan and recognition of an image of one or more QR barcodes
    #
    # + preprocessing - Optional preprocessing mode
    # + recognitionMode - Optional recognition mode
    # + request - Multipart request carrying the image file
    # + return - Recognized QR barcodes found in the image
    resource function post scan/image/advanced/qr(@http:Header string? preprocessing, @http:Header string? recognitionMode, http:Request request) returns BarcodeScanQRAdvancedResult {
        return {
            barcodeCount: 1,
            resultBarcodes: [{rawText: "https://example.com/product/1234"}],
            successful: true
        };
    }
}
