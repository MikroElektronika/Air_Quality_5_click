/*
Example for AirQuality5 Click

    Date          : apr 2018.
    Author        : Katarina Perendic

Test configuration FT90x :
    
    MCU                : FT900
    Dev. Board         : EasyFT90x v7 
    FT90x Compiler ver : v2.2.1.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes I2C module and sets INT pin as INPUT
- Application Initialization - Initializes driver init and configuration chip
- Application Task - (code snippet) - Reads the values of CO, NH3 and NO2 sensor and logs data on USBUART every 500ms.
*/

#include "Click_AirQuality5_types.h"
#include "Click_AirQuality5_config.h"

uint16_t NO2_sensorData;
uint16_t NH3_sensorData;
uint16_t CO_sensorData;
char dataText[50] = {0};

void systemInit()
{
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
    mikrobus_i2cInit( _MIKROBUS1, &_AIRQ5_I2C_CFG[0] );
    mikrobus_logInit( _LOG_USBUART, 9600 );
    Delay_ms( 100 );
}

void applicationInit()
{
    airq5_i2cDriverInit( (T_AIRQ5_P)&_MIKROBUS1_GPIO, (T_AIRQ5_P)&_MIKROBUS1_I2C, 0x48 );
    airq5_setConfiguration( _AIRQ5_CONFIG_OS_SINGLE |
                            _AIRQ5_CONFIG_PGA_2_048V |
                            _AIRQ5_CONFIG_SINGLE_MODE |
                            _AIRQ5_CONFIG_DATA_RATE_1600SPS |
                            _AIRQ5_CONFIG_COMP_MODE_TRADITIONAL |
                            _AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW |
                            _AIRQ5_CONFIG_COMP_LAT_NOT_LATCH |
                            _AIRQ5_CONFIG_COMP_QUE_0CONV );
}

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

void main()
{
    systemInit();
    applicationInit();

    while (1)
    {
        applicationTask();
    }
}