# eink

## Server

```bash
$ docker build ./server -t eink

$ docker run --rm --env-file .env -p 3000:3000 eink

Starting...
Server listening on port 3000!

# See more in server/examples
$ curl -X PATCH \ 
    -d '{\"data1\": \"hello there it is me josh\"}' \
    http://localhost:3000/update?mode=newspaper

$ wget localhost:3000/image.bmp
```

### Environment variables

#### Required

None.

#### Optional

- `SPOONACULAR_API`: Spoonacular API key. (Required when `mode=recipe`).

## Client sketch

> See _https://github.com/SolderedElectronics/Inkplate-Arduino-library_

### Setup
```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/bin sh

$ arduino-cli config init

$ arduino-cli config add board_manager.additional_urls  https://github.com/SolderedElectronics/Dasduino-Board-Definitions-for-Arduino-IDE/raw/master/package_Dasduino_Boards_index.json
$ arduino-cli update

$ arduino-cli core install Inkplate_Boards:esp32
$ arduino-cli lib install InkplateLibrary

$ arduino-cli board search Inkplate
Board Name                     FQBN                                   Platform ID           
Soldered Inkplate 4 TEMPERA    Inkplate_Boards:esp32:Inkplate4TEMPERA Inkplate_Boards:esp32 
Soldered Inkplate 6COLOR       Inkplate_Boards:esp32:Inkplate6COLOR   Inkplate_Boards:esp32 
Soldered Inkplate 6Plus        Inkplate_Boards:esp32:Inkplate6plusV2  Inkplate_Boards:esp32 
Soldered Inkplate10            Inkplate_Boards:esp32:Inkplate10V2     Inkplate_Boards:esp32 
Soldered Inkplate2             Inkplate_Boards:esp32:Inkplate2        Inkplate_Boards:esp32 
Soldered Inkplate4             Inkplate_Boards:esp32:Inkplate4        Inkplate_Boards:esp32 
Soldered Inkplate5             Inkplate_Boards:esp32:Inkplate5        Inkplate_Boards:esp32 
Soldered Inkplate6             Inkplate_Boards:esp32:Inkplate6V2      Inkplate_Boards:esp32 
Soldered Inkplate7             Inkplate_Boards:esp32:Inkplate7        Inkplate_Boards:esp32 
e-radionica.com Inkplate 6Plus Inkplate_Boards:esp32:Inkplate6plus    Inkplate_Boards:esp32 
e-radionica.com Inkplate10     Inkplate_Boards:esp32:Inkplate10       Inkplate_Boards:esp32 
e-radionica.com Inkplate6      Inkplate_Boards:esp32:Inkplate6        Inkplate_Boards:esp32 

$ cd ./sketch \
  && python -m venv . \
  && source bin/activate \
  && pip install pyserial==3.3
```

### Compile for your board

#### `params.h`

Create a `sketch/params.h` file similar to below.

```c++
const char *ssid = "mywifi";
const char *password = "mypass";
const char *baseAddress = "http://10.0.0.1:3000";
```

```bash
(venv) $ arduino-cli compile -b Inkplate_Boards:esp32:Inkplate10

Sketch uses 939357 bytes (29%) of program storage space. Maximum is 3145728 bytes.
Global variables use 55200 bytes (16%) of dynamic memory, leaving 272480 bytes for local variables. Maximum is 327680 bytes.

Used library     Version Path                                                                                          
HTTPClient       2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/HTTPClient      
WiFi             2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/WiFi            
WiFiClientSecure 2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/WiFiClientSecure
InkplateLibrary  8.2.1   /home/josh/Arduino/libraries/InkplateLibrary                                                  
SPI              2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/SPI             
Wire             2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/Wire            
EEPROM           2.0.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0/libraries/EEPROM          

Used platform         Version Path                                                               
Inkplate_Boards:esp32 7.1.0   /home/josh/.arduino15/packages/Inkplate_Boards/hardware/esp32/7.1.0
```

### Upload

```bash
arduino-cli upload -b Inkplate_Boards:esp32:Inkplate10 -p /dev/ttyUSB0
```
