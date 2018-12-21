/*
    __airq5_driver.c

-----------------------------------------------------------------------------

  This file is part of mikroSDK.

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

#include "__airq5_driver.h"
#include "__airq5_hal.c"

/* ------------------------------------------------------------------- MACROS */

/* Chanel data  */
const uint16_t _AIRQ5_DATA_CHANNEL_NO2 = 0x4000;
const uint16_t _AIRQ5_DATA_CHANNEL_NH3 = 0x5000;
const uint16_t _AIRQ5_DATA_CHANNEL_CO  = 0x6000;

/* Register  */
const uint8_t _AIRQ5_REG_POINTER_CONVERT     = 0x00;
const uint8_t _AIRQ5_REG_POINTER_CONFIG      = 0x01;
const uint8_t _AIRQ5_REG_POINTER_LOW_THRESH  = 0x02;
const uint8_t _AIRQ5_REG_POINTER_HIGH_THRESH = 0x03;

/* Congiguration OS  */
const uint16_t _AIRQ5_CONFIG_OS_SINGLE    = 0x8000;
const uint16_t _AIRQ5_CONFIG_OS_BUSY      = 0x0000;
const uint16_t _AIRQ5_CONFIG_OS_NOTBUSY   = 0x8000;

/* Congiguration PGA  */
const uint16_t _AIRQ5_CONFIG_PGA_6_144V   = 0x0000;
const uint16_t _AIRQ5_CONFIG_PGA_4_096V   = 0x0200;
const uint16_t _AIRQ5_CONFIG_PGA_2_048V   = 0x0400;
const uint16_t _AIRQ5_CONFIG_PGA_1_024V   = 0x0600;
const uint16_t _AIRQ5_CONFIG_PGA_0_512V   = 0x0800;
const uint16_t _AIRQ5_CONFIG_PGA_0_256V   = 0x0A00;

/* Congiguration MODE  */
const uint16_t _AIRQ5_CONFIG_CONTINUOUS_MODE  = 0x0000;
const uint16_t _AIRQ5_CONFIG_SINGLE_MODE      = 0x0100;

/* Congiguration DR  */
const uint16_t _AIRQ5_CONFIG_DATA_RATE_128SPS    = 0x0000;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_250SPS    = 0x0020;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_490SPS    = 0x0040;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_920SPS    = 0x0060;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_1600SPS   = 0x0080;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_2400SPS   = 0x00A0;
const uint16_t _AIRQ5_CONFIG_DATA_RATE_3300SPS   = 0x00C0;

/* Congiguration CMODE  */
const uint16_t _AIRQ5_CONFIG_COMP_MODE_TRADITIONAL  = 0x0000;
const uint16_t _AIRQ5_CONFIG_COMP_MODE_WINDOW       = 0x0010;

/* Congiguration CPOL  */
const uint16_t _AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW    = 0x0000;
const uint16_t _AIRQ5_CONFIG_COMP_POL_ACTIVE_HIGH   = 0x0008;

/* Congiguration CLAT  */
const uint16_t _AIRQ5_CONFIG_COMP_LAT_NOT_LATCH   = 0x0000;
const uint16_t _AIRQ5_CONFIG_COMP_LAT_LATCH       = 0x0004;

/* Congiguration CQUE  */
const uint16_t _AIRQ5_CONFIG_COMP_QUE_1CONV   = 0x0000;
const uint16_t _AIRQ5_CONFIG_COMP_QUE_2CONV   = 0x0001;
const uint16_t _AIRQ5_CONFIG_COMP_QUE_4CONV   = 0x0002;
const uint16_t _AIRQ5_CONFIG_COMP_QUE_0CONV   = 0x0003;

/* ---------------------------------------------------------------- VARIABLES */

#ifdef   __AIRQ5_DRV_I2C__
static uint8_t _slaveAddress;
#endif

static uint16_t _dataConfig = 0x8583;

/* -------------------------------------------- PRIVATE FUNCTION DECLARATIONS */



/* --------------------------------------------- PRIVATE FUNCTION DEFINITIONS */



/* --------------------------------------------------------- PUBLIC FUNCTIONS */

#ifdef   __AIRQ5_DRV_SPI__

void airq5_spiDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P spiObj)
{
    hal_spiMap( (T_HAL_P)spiObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

#endif
#ifdef   __AIRQ5_DRV_I2C__

void airq5_i2cDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P i2cObj, uint8_t slave)
{
    _slaveAddress = slave;
    hal_i2cMap( (T_HAL_P)i2cObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

#endif
#ifdef   __AIRQ5_DRV_UART__

void airq5_uartDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P uartObj)
{
    hal_uartMap( (T_HAL_P)uartObj );
    hal_gpioMap( (T_HAL_P)gpioObj );
}

#endif


/* ----------------------------------------------------------- IMPLEMENTATION */

void airq5_writeData(uint8_t reg, uint16_t _data)
{
    uint8_t writeReg[ 3 ];

    writeReg[ 0 ] = reg;
    writeReg[ 1 ] = _data >> 8;
    writeReg[ 2 ] = _data & 0x00FF;

    hal_i2cStart();
    hal_i2cWrite(_slaveAddress, writeReg, 3, END_MODE_STOP);
}

uint16_t airq5_readData(uint8_t reg)
{
    uint8_t writeReg[ 1 ];
    uint8_t readReg[ 2 ];
    uint16_t dataValue;

    writeReg[ 0 ] = reg;

    hal_i2cStart();
    hal_i2cWrite(_slaveAddress, writeReg, 1, END_MODE_RESTART);
    hal_i2cRead(_slaveAddress, readReg, 2, END_MODE_STOP);

    dataValue = readReg[ 0 ];
    dataValue = dataValue << 8;
    dataValue = dataValue | readReg[ 1 ];

    return dataValue;
}


void airq5_setConfiguration(uint16_t config)
{
    _dataConfig = config;
}


uint16_t airq5_readSensorData(uint16_t channel_data)
{
    uint16_t setConfig;
    uint16_t getData;
   
    setConfig = _dataConfig;
    setConfig = setConfig | channel_data;
    
    while (airq5_getInterrupt() != 1);
    
    airq5_writeData(_AIRQ5_REG_POINTER_CONFIG, setConfig );
    getData = airq5_readData( _AIRQ5_REG_POINTER_CONVERT );
    
    getData = getData >> 4;

    return getData;
}

uint8_t airq5_getInterrupt()
{
    return hal_gpio_intGet();
}

/* -------------------------------------------------------------------------- */
/*
  __airq5_driver.c

  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. All advertising materials mentioning features or use of this software
   must display the following acknowledgement:
   This product includes software developed by the MikroElektonika.

4. Neither the name of the MikroElektonika nor the
   names of its contributors may be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY MIKROELEKTRONIKA ''AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL MIKROELEKTRONIKA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

----------------------------------------------------------------------------- */