/*
   Inkplate10_Show_Pictures_From_Web example for Soldered Inkplate 10
   For this example you will need a micro USB cable, Inkplate 10, and an available WiFi connection.
   Select "e-radionica Inkplate10" or "Soldered Inkplate10" from Tools -> Board menu.
   Don't have "e-radionica Inkplate10" or "Soldered Inkplate10" option? Follow our tutorial and add it:
   https://soldered.com/learn/add-inkplate-6-board-definition-to-arduino-ide/

   You can open .bmp files that have color depth of 1 bit (BW bitmap), 4 bit, 8 bit and
   24 bit AND have resoluton smaller than 800x600 or otherwise it won't fit on screen.

   This example will show you how you can download a .bmp file (picture) from the web and
   display that image on e-paper display.

   Want to learn more about Inkplate? Visit www.inkplate.io
   Looking to get support? Write on our forums: https://forum.soldered.com/
   11 February 2021 by Soldered
*/

// Next 3 lines are a precaution, you can ignore those, and the example would also work without them
#if !defined(ARDUINO_INKPLATE10) && !defined(ARDUINO_INKPLATE10V2)
#error "Wrong board selection for this example, please select e-radionica Inkplate10 or Soldered Inkplate10 in the boards menu."
#endif

#include "params.h"              // ssid, password, baseAddress
#include "HTTPClient.h"          // Include library for HTTPClient
#include "Inkplate.h"            // Include Inkplate library to the sketch
#include "WiFi.h"                // Include library for WiFi
#include <stdio.h>               // Include standard C library
Inkplate display(INKPLATE_3BIT); // Create an object on Inkplate library and also set library into 1 Bit mode (BW)

void setup()
{
    Serial.begin(115200); // Init serial port
    Serial.println("Starting!");

    display.begin(); // Init Inkplate library (you should call this function ONLY ONCE)

    Serial.println("Display started!");

    display.clearDisplay(); // Clear frame buffer of display
    display.display();      // Put clear image on display

    display.print("Connecting to WiFi...");
    display.partialUpdate();

    Serial.println("Connecting to WiFi...");

    // Connect to the WiFi network.
    WiFi.mode(WIFI_MODE_STA);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        display.print(".");
        Serial.println("(waiting for connection)");
        display.partialUpdate();
    }

    Serial.println("Connected to WiFi!");

    // Print IP address
    Serial.println(WiFi.localIP());

    // Craft bitmap URL
    char bitmapUrl[100];
    sprintf(bitmapUrl, "%s/newspaper.bmp", baseAddress);

    // Draw the first image from web.
    // Monochromatic bitmap with 1 bit depth. Images like this load quickest.
    // NOTE: Both drawImage methods allow for an optional fifth "invert" parameter. Setting this parameter to true
    // will flip all colors on the image, making black white and white black. This may be necessary when exporting
    // bitmaps from certain softwares. Forth parameter will dither the image.
    if (!display.drawImage(bitmapUrl, 0, 0, false, false))
    {
        // If is something failed (wrong filename or wrong bitmap format), write error message on the screen.
        // REMEMBER! You can only use Windows Bitmap file with color depth of 1, 4, 8 or 24 bits with no compression!
        display.println("Image open error");
        display.display();
    }
    display.display();
    WiFi.mode(WIFI_OFF);
}

void loop()
{
    // Nothing...
}
