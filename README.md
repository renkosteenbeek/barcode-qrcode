# BarCode-QrCode-Generator

Met dit project is het mogelijk eenvoudig een QR code of een Barcode (code39) te genereren.

## Gebruik
```
// Genereer een barcode (code39)
http://localhost:8000/?type=barcode&value=1241221215

// Genereer een QR code
http://localhost:8000/?type=qr&value=qrContent
```
## Starten image
```
docker run -p 8000:80 -d --restart=always renkosteenbeek/barcode-qrcode:latest
```

De binaire data wordt teruggestuurd, inclusief bijbehorende http headers.

## Ontwikkelen
### Projectstructuur

- `index.php`: Bevat de PHP-bronbestand van het project.
- `vendor/`: Bevat de Composer-afhankelijkheden. Deze map wordt automatisch gegenereerd; u hoeft deze niet handmatig toe te voegen.
- `composer.json` en `composer.lock`: Configuratiebestanden voor Composer-afhankelijkheden.
- `Dockerfile`: Definieert de Docker-container voor het project.

### Build image
```
docker buildx build --platform linux/amd64,linux/arm64 -t renkosteenbeek/barcode-qrcode:latest
```
### Script aanpassingen
Na het builden, voer het volgende commando uit vanuit de project directory.
```
docker run -p 8000:80 -v $(pwd):/var/www/html barcode-qrcode
````
