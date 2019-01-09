![MikroE](http://www.mikroe.com/img/designs/beta/logo_small.png)

---

# AirQuality5 Click

- **CIC Prefix**  : AIRQ5
- **Author**      : Katarina Perendic
- **Verison**     : 1.0.0
- **Date**        : apr 2018.

---

### Software Support

We provide a library for the AirQuality5 Click on our [LibStock](https://libstock.mikroe.com/projects/view/2404/air-quality-5-click) 
page, as well as a demo application (example), developed using MikroElektronika 
[compilers](http://shop.mikroe.com/compilers). The demo can run on all the main 
MikroElektronika [development boards](http://shop.mikroe.com/development-boards).

**Library Description**

The library initializes and defines the I2C bus driver and drivers that offer a choice for writing data in registers and reading data
from registers. The library includes functions for full initialization chip, reading 3 sensor (CO, NH3 and NO2 data).  
User can check the state of the RDY pin indicating that the data is ready for reading.

Key functions :

- ``` void airq5_setConfiguration(uint16_t config) ``` - Functions for configuration
- ``` uint16_t airq5_readSensorData(uint16_t channel_data) ``` - Functions for read sensor data


**Examples Description**

The application is composed of three sections :

- System Initialization - Initializes I2C module and sets INT pin as INPUT
- Application Initialization - Initializes driver init and configuration chip
- Application Task - (code snippet) - Reads the values of CO, NH3 and NO2 sensor and logs data on USBUART every 500ms.

```.c
void applicationTask()
{
    NO2_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NO2);
    NH3_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NH3);
    CO_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_CO);
      
    IntToStr(NO2_sensorData, dataText);
    mikrobus_logWrite(" NO2 data: ", _LOG_TEXT);
    mikrobus_logWrite(dataText, _LOG_LINE);

    IntToStr(NH3_sensorData, dataText);
    mikrobus_logWrite(" NH3 data: ", _LOG_TEXT);
    mikrobus_logWrite(dataText, _LOG_LINE);

    IntToStr(CO_sensorData, dataText);
    mikrobus_logWrite(" CO data: ", _LOG_TEXT);
    mikrobus_logWrite(dataText, _LOG_LINE);

    mikrobus_logWrite(" -------- ", _LOG_LINE);
    Delay_ms( 500 );
}

```

The full application code, and ready to use projects can be found on our 
[LibStock](https://libstock.mikroe.com/projects/view/2404/air-quality-5-click) page.

Other mikroE Libraries used in the example:

- Conversions
- I2C
- UART

**Additional notes and informations**

Depending on the development board you are using, you may need 
[USB UART click](http://shop.mikroe.com/usb-uart-click), 
[USB UART 2 Click](http://shop.mikroe.com/usb-uart-2-click) or 
[RS232 Click](http://shop.mikroe.com/rs232-click) to connect to your PC, for 
development systems with no UART to USB interface available on the board. The 
terminal available in all Mikroelektronika 
[compilers](http://shop.mikroe.com/compilers), or any other terminal application 
of your choice, can be used to read the message.

---
---
