<?php

require_once 'vendor/autoload.php';

$type = $_GET['type'] ?? '';
$value = $_GET['value'] ?? '';

if (!$value) {
    throw new \Exception("Er is geen waarde aangegeven");
}

switch ($type) {
    case 'qr':
        // Genereer een QR code
        $options = new chillerlan\QRCode\QROptions;
        $options->imageBase64 = false;
        $options->scale = 20;

        $qrCode = new chillerlan\QRCode\QRCode($options);
        $contentType = 'image/png';
        $output = $qrCode->render($value);
        break;

    case 'barcode':
        // Genereer een Barcode (Code 39)
        $barcodeGenerator = new \Picqer\Barcode\BarcodeGeneratorPNG();

        $contentType = 'image/png';
        $output = $barcodeGenerator->getBarcode($value, $barcodeGenerator::TYPE_CODE_39);
        break;

    default:
        throw  new \Exception('Ongeldig type opgegeven. Gebruik "qr" of "barcode".');
}

header('Content-Type: ' . $contentType);
echo $output;
