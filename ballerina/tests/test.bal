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
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.cloudmersive.com/barcode" : "http://localhost:9090";
final string apiKey = isLiveServer ? os:getEnv("CLOUDMERSIVE_API_KEY") : "test_api_key";

final Client barcodeClient = check new ({apikey: apiKey}, {httpVersion: http:HTTP_1_1}, serviceUrl);

final ScanBarcodeImageRequest sampleImage = {
    imageFile: {fileContent: [137, 80, 78, 71, 13, 10, 26, 10], fileName: "barcode.png"}
};

@test:Config {groups: ["live_tests", "mock_tests"]}
function testLookupEanBarcode() returns error? {
    BarcodeLookupResponse response = check barcodeClient->lookupEanBarcode("5901234123457");
    test:assertTrue(response?.successful is boolean);
    test:assertTrue(response?.matches is ProductMatch[]);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testScanBarcodeImage() returns error? {
    BarcodeScanResult response = check barcodeClient->scanBarcodeImage(sampleImage);
    test:assertEquals(response?.successful, true);
    test:assertTrue(response?.rawText is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testScanBarcodeImageAdvanced() returns error? {
    BarcodeAdvancedScanResult response = check barcodeClient->scanBarcodeImageAdvanced(sampleImage);
    test:assertEquals(response?.successful, true);
    test:assertTrue((response?.barcodeCount ?: 0) > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testScanQrBarcodeImageAdvanced() returns error? {
    BarcodeScanQRAdvancedResult response = check barcodeClient->scanQrBarcodeImageAdvanced(sampleImage);
    test:assertEquals(response?.successful, true);
    test:assertTrue((response?.barcodeCount ?: 0) > 0);
}

@test:Config {groups: ["mock_tests"]}
function testCreateQrScanBatchJob() returns error? {
    BarcodeBatchJobResult response = check barcodeClient->createQrScanBatchJob(sampleImage);
    test:assertTrue(response?.asyncJobID is string);
}

@test:Config {groups: ["mock_tests"]}
function testGetBatchJobStatus() returns error? {
    BarcodeBatchJobStatusResult response = check barcodeClient->getBatchJobStatus(asyncJobID = "b6a1d3f0-5c1e-4f6e-9a57-2f1c3d8e7a90");
    test:assertEquals(response?.asyncJobID, "b6a1d3f0-5c1e-4f6e-9a57-2f1c3d8e7a90");
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateQrCode() returns error? {
    byte[] response = check barcodeClient->generateQrCode("https://example.com");
    test:assertTrue(isPng(response));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateUpcABarcode() returns error? {
    byte[] response = check barcodeClient->generateUpcABarcode("614141000036", {width: 200, height: 100});
    test:assertTrue(isPng(response));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateUpcEBarcode() returns error? {
    byte[] response = check barcodeClient->generateUpcEBarcode("01234565");
    test:assertTrue(isPng(response));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateEan13Barcode() returns error? {
    byte[] response = check barcodeClient->generateEan13Barcode("5901234123457", {includeLabel: true});
    test:assertTrue(isPng(response));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateEan8Barcode() returns error? {
    byte[] response = check barcodeClient->generateEan8Barcode("96385074");
    test:assertTrue(isPng(response));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGenerateCode128Barcode() returns error? {
    byte[] response = check barcodeClient->generateCode128Barcode("ABC-12345");
    test:assertTrue(isPng(response));
}

# Checks that the bytes form a PNG: the 8-byte signature followed eventually by the IEND trailer chunk.
#
# + content - The bytes to check
# + return - `true` if the bytes start with the PNG signature and end with the IEND chunk
isolated function isPng(byte[] content) returns boolean {
    byte[] signature = [137, 80, 78, 71, 13, 10, 26, 10];
    byte[] iend = [0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130];
    int len = content.length();
    return len >= signature.length() + iend.length()
        && content.slice(0, signature.length()) == signature
        && content.slice(len - iend.length()) == iend;
}
