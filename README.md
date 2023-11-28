# BarCode-QrCode-Generator

Met dit project is het mogelijk eenvoudig een QR code of een Barcode (code39) te genereren. De binaire data wordt teruggestuurd, inclusief bijbehorende http headers.

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

Zie ook:
https://hub.docker.com/repository/docker/renkosteenbeek/barcode-qrcode

## Ontwikkelen
### Projectstructuur

- `index.php`: Bevat de PHP-bronbestand van het project.
- `vendor/`: Bevat de Composer-afhankelijkheden. Deze map wordt automatisch gegenereerd; u hoeft deze niet handmatig toe te voegen.
- `composer.json` en `composer.lock`: Configuratiebestanden voor Composer-afhankelijkheden.
- `Dockerfile`: Definieert de Docker-container voor het project.

### Build and push image (multi arch)
Buildx instance maken en gebruiken:
```
docker buildx create --name mybuilder --use;
docker buildx inspect --bootstrap
```
Builden:
```
docker build --platform linux/amd64,linux/arm64 -t renkosteenbeek/barcode-qrcode:latest . --push
```

### Build image (single arch)
```
docker build -t barcode-qrcode .
```
### Script aanpassingen
Installeer in je lokale directory the Composer packages:
```
docker run --rm -v $(pwd):/app composer install
```

Start de image:
```
docker run -p 8000:80 -v $(pwd):/var/www/html barcode-qrcode
````
