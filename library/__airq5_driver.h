/*
    __airq5_driver.h

-----------------------------------------------------------------------------

  This file is part of mikroSDK.
  
  Copyright (c) 2017, MikroElektonika - http://www.mikroe.com

  All rights reserved.

----------------------------------------------------------------------------- */

/**
@file   __airq5_driver.h
@brief    AirQuality5 Driver
@mainpage AirQuality5 Click
@{

@image html libstock_fb_view.jpg

@}

@defgroup   AIRQ5
@brief      AirQuality5 Click Driver
@{

| Global Library Prefix | **AIRQ5** |
|:---------------------:|:-----------------:|
| Version               | **1.0.0**    |
| Date                  | **apr 2018.**      |
| Developer             | **Katarina Perendic**     |

*/
/* -------------------------------------------------------------------------- */

#include "stdint.h"

#ifndef _AIRQ5_H_
#define _AIRQ5_H_

/** 
 * @macro T_AIRQ5_P
 * @brief Driver Abstract type 
 */
#define T_AIRQ5_P    const uint8_t*

/** @defgroup AIRQ5_COMPILE Compilation Config */              /** @{ */

//  #define   __AIRQ5_DRV_SPI__                            /**<     @macro __AIRQ5_DRV_SPI__  @brief SPI driver selector */
   #define   __AIRQ5_DRV_I2C__                            /**<     @macro __AIRQ5_DRV_I2C__  @brief I2C driver selector */                                          
// #define   __AIRQ5_DRV_UART__                           /**<     @macro __AIRQ5_DRV_UART__ @brief UART driver selector */ 

                                                                       /** @} */
/** @defgroup AIRQ5_VAR Variables */                           /** @{ */


// channel
extern const uint16_t _AIRQ5_DATA_CHANNEL_NO2;
extern const uint16_t _AIRQ5_DATA_CHANNEL_NH3;
extern const uint16_t _AIRQ5_DATA_CHANNEL_CO;

// register
extern const uint8_t _AIRQ5_REG_POINTER_CONVERT;
extern const uint8_t _AIRQ5_REG_POINTER_CONFIG;
extern const uint8_t _AIRQ5_REG_POINTER_LOW_THRESH;
extern const uint8_t _AIRQ5_REG_POINTER_HIGH_THRESH;

/* Congiguration operational status  */
extern const uint16_t _AIRQ5_CONFIG_OS_SINGLE;
extern const uint16_t _AIRQ5_CONFIG_OS_BUSY;
extern const uint16_t _AIRQ5_CONFIG_OS_NOTBUSY;

/* Programmable gain amplifier configuration */
extern const uint16_t _AIRQ5_CONFIG_PGA_6_144V;
extern const uint16_t _AIRQ5_CONFIG_PGA_4_096V;
extern const uint16_t _AIRQ5_CONFIG_PGA_2_048V;
extern const uint16_t _AIRQ5_CONFIG_PGA_1_024V;
extern const uint16_t _AIRQ5_CONFIG_PGA_0_512V;
extern const uint16_t _AIRQ5_CONFIG_PGA_0_256V;

/* Device operating mode  */
extern const uint16_t _AIRQ5_CONFIG_CONTINUOUS_MODE;
extern const uint16_t _AIRQ5_CONFIG_SINGLE_MODE;

/* Data rate */
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_128SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_250SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_490SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_920SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_1600SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_2400SPS;
extern const uint16_t _AIRQ5_CONFIG_DATA_RATE_3300SPS;

/* Comparator mode  */
extern const uint16_t _AIRQ5_CONFIG_COMP_MODE_TRADITIONAL;
extern const uint16_t _AIRQ5_CONFIG_COMP_MODE_WINDOW;

/* Comparator polarity  */
extern const uint16_t _AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW;
extern const uint16_t _AIRQ5_CONFIG_COMP_POL_ACTIVE_HIGH;

/* Latching comparator  */
extern const uint16_t _AIRQ5_CONFIG_COMP_LAT_NOT_LATCH;
extern const uint16_t _AIRQ5_CONFIG_COMP_LAT_LATCH;

/* Comparator queue and disable  */
extern const uint16_t _AIRQ5_CONFIG_COMP_QUE_1CONV;
extern const uint16_t _AIRQ5_CONFIG_COMP_QUE_2CONV;
extern const uint16_t _AIRQ5_CONFIG_COMP_QUE_4CONV;
extern const uint16_t _AIRQ5_CONFIG_COMP_QUE_0CONV;

                                                                       /** @} */

#ifdef __cplusplus
extern "C"{
#endif

/** @defgroup AIRQ5_INIT Driver Initialization */              /** @{ */

#ifdef   __AIRQ5_DRV_SPI__
void airq5_spiDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P spiObj);
#endif
#ifdef   __AIRQ5_DRV_I2C__
void airq5_i2cDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P i2cObj, uint8_t slave);
#endif
#ifdef   __AIRQ5_DRV_UART__
void airq5_uartDriverInit(T_AIRQ5_P gpioObj, T_AIRQ5_P uartObj);
#endif

// GPIO Only Drivers - remove in other cases
void airq5_gpioDriverInit(T_AIRQ5_P gpioObj);
                                                                       /** @} */
/** @defgroup AIRQ5_FUNC Driver Functions */                   /** @{ */

/**
 * @brief Functions for write data in register
 *
 * @param[in] reg    Register in which the data will be written
 * @param[in] _data  Data which be written in the register
 *
 * Use this function when you need to written data into the register
 */
void airq5_writeData(uint8_t reg, uint16_t _data);

/**
 * @brief Functions for read data from register
 *
 * @param[in] reg  Register from which will be read
 * @retval two byte data which is read from the register
 *
 * Use this function when you need to reads data from the register
 */
uint16_t airq5_readData(uint8_t reg);

/**
 * @brief Functions for configuration
 *
 * @param[in]  reg     Register which be set
 * @param[out] _data   Data which be written in the register
 *
 * Options for settings:
        - Operational statu ( No effect or Start a single conversios)
        - Programmable gain amplifier (FSR : ±6.144 V, ±4.096, V ±2.048 V, ±1.024 V, ±0.512 V or ±0.256 V )
        - Device operating mode (Continuous-conversion mode or Single mode)
        - Data rate ( SPS : 128, 250, 490, 920, 1600, 2400 or 3300)
        - Comparator mode (Traditional comparator or Window comparator)
        - Comparator polarity (Active LOW or Active HIGH)
        - Latching comparator (Nonlatching comparato or Latching comparator)
        - Comparator queue and disable (Assert after one, two, foue conversion or disable comparator)

 */
void airq5_setConfiguration(uint16_t config);

/**
 * @brief Functions for read sensor data
 *
 * @param[out] channel_data   Data which be reads
 *
 * Options for reads:
        - CO Data
        - NH3 Data
        - NO2 Data

 */
uint16_t airq5_readSensorData(uint16_t channel_data);

/**
 * @brief Functions for reads interrupt pin
 *
 * @retval status reading from pins
 */
uint8_t airq5_getInterrupt();




                                                                       /** @} */
#ifdef __cplusplus
} // extern "C"
#endif
#endif

/**
    @example Click_AirQuality5_STM.c
    @example Click_AirQuality5_TIVA.c
    @example Click_AirQuality5_CEC.c
    @example Click_AirQuality5_KINETIS.c
    @example Click_AirQuality5_MSP.c
    @example Click_AirQuality5_PIC.c
    @example Click_AirQuality5_PIC32.c
    @example Click_AirQuality5_DSPIC.c
    @example Click_AirQuality5_AVR.c
    @example Click_AirQuality5_FT90x.c
    @example Click_AirQuality5_STM.mbas
    @example Click_AirQuality5_TIVA.mbas
    @example Click_AirQuality5_CEC.mbas
    @example Click_AirQuality5_KINETIS.mbas
    @example Click_AirQuality5_MSP.mbas
    @example Click_AirQuality5_PIC.mbas
    @example Click_AirQuality5_PIC32.mbas
    @example Click_AirQuality5_DSPIC.mbas
    @example Click_AirQuality5_AVR.mbas
    @example Click_AirQuality5_FT90x.mbas
    @example Click_AirQuality5_STM.mpas
    @example Click_AirQuality5_TIVA.mpas
    @example Click_AirQuality5_CEC.mpas
    @example Click_AirQuality5_KINETIS.mpas
    @example Click_AirQuality5_MSP.mpas
    @example Click_AirQuality5_PIC.mpas
    @example Click_AirQuality5_PIC32.mpas
    @example Click_AirQuality5_DSPIC.mpas
    @example Click_AirQuality5_AVR.mpas
    @example Click_AirQuality5_FT90x.mpas
*/                                                                     /** @} */
/* -------------------------------------------------------------------------- */
/*
  __airq5_driver.h

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