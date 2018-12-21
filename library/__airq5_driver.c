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
#define _DBL_MAX_       3.40282347e+38
#define _FRNDINT(x)   ((double)(long)(x))

#ifdef   __AIRQ5_DRV_I2C__
static uint8_t _slaveAddress;
#endif

static uint16_t _dataConfig = 0x8583;

/* -------------------------------------------- PRIVATE FUNCTION DECLARATIONS */

static double _floor(double x);
static double _frexp(double value, int * eptr);
static double _ldexp(double value, int newexp);
static double _eval_poly(double x, const double code * d, int n);
static double _exp(double x);
static double _log(double x);
static double _myPow(double x, double y);

/* --------------------------------------------- PRIVATE FUNCTION DEFINITIONS */

#if defined  __MIKROC_PRO_FOR_ARM__  ||  __MIKROC_PRO_FOR_PIC32__ || __MIKROC_PRO_FOR_DSPIC__ || __MIKROC_PRO_FOR_AVR__ || __MIKROC_PRO_FOR_FT90x__
static union both
{
        struct flt
        {
                unsigned char   mant[2];
                unsigned        hmant:7;
                unsigned        exp:8;
                unsigned        sign:1;

        }        flt;
        double        fl;
};

//--------------
static double _frexp(double value, int * eptr) {
  union both uv;
  volatile int bb;

  uv.fl = value;
  bb = uv.flt.exp - 126;
  *eptr = bb;
  uv.flt.exp = 126;
 return uv.fl;

}

//--------------
static double _ldexp(double value, int newexp) {
   union both uv;

  uv.fl = value;
  newexp += uv.flt.exp;
  if (newexp < 0)
    return 0.0;
  else
    if (newexp > 255)
      if (value < 0.0)
        return -_DBL_MAX_;
      else
        return _DBL_MAX_;
    else
      uv.flt.exp = newexp;
  return uv.fl;

}
#endif

#if defined __MIKROC_PRO_FOR_PIC__
static double _frexp(double value, int * eptr)
{
    char *     pom;
    pom = &value;
    *eptr = pom[3] - 126;
    pom[3] = 126;
    return value;
}

static double _ldexp(double value, int newexp)
{
    char * pom;
    pom = &value;
    newexp += pom[3];
    if (newexp < 0)
        return 0.0;
    else if (newexp > 255)
        if (value < 0.0)
            return -_DBL_MAX_;
        else
            return _DBL_MAX_;
    else
        pom[3] = newexp;
  return value;
}
#endif


static double _floor(double x) {
  double    i;
  int       expon;

  expon = ((*(unsigned long *)&x >> 23) & 255);
  expon = expon- 127;
  if(expon < 0)
    if (x < 0.0)
      return -1.0;
    else
      return  0.0;
  if((unsigned)expon > sizeof(double) * 8 - 8)
    return x;           /* already an integer */
  i = _FRNDINT(x);

  if(i > x)
    return i - 1.0;
  return i;
}


static double _eval_poly(double x, const double code * d, int n) {
  double res;

  res = d[n];
  while(n)
    res = x * res + d[--n];

  return res;
}

static double _exp(double x) {
  int       exp;
  char     sign;

  const static double coeff[] = {
    1.0000000000e+00,
    6.9314718056e-01,
    2.4022650695e-01,
    5.5504108945e-02,
    9.6181261779e-03,
    1.3333710529e-03,
    1.5399104432e-04,
    1.5327675257e-05,
    1.2485143336e-06,
    1.3908092221e-07,
  };

  if(x == 0.0)
    return 1.0;
  if (x > 89.416)    //too big?
    return _DBL_MAX_;
  if (x < -87.33655)    //too small?
    return 0.0;
  sign = x < 0.0;
  if(sign)
    x = -x;
  x *= 1.4426950409;            // convert to log2 //
  exp = (int)_floor(x);
  x -= (double)exp;
  x = _ldexp(_eval_poly(x, coeff, sizeof coeff/sizeof coeff[0] - 1), exp);
  if(sign) {
    if (x == _DBL_MAX_)
      return 0.0;
    return 1.0/x;
  }
  return x;
}


//-------------- Returns natural logarithm of given argument - ln(x)
static double _log(double x) {
  int       exp;
  static const double coeff[] = {
     0.0000000001,      // a0 //
     0.9999964239,      // a1 //
    -0.4998741238,      // a2 //
     0.3317990258,      // a3 //
    -0.2407338084,      // a4 //
     0.1676540711,      // a5 //
    -0.0953293897,      // a6 //
     0.0360884937,      // a7 //
    -0.0064535442,      // a8 //
  };

  // zero or -ve arguments are not defined //

  if(x <= 0.0)
            return 0.0;
  x = _frexp(x, &exp) * 2.0 - 1.0;
  exp--;
  x = _eval_poly(x, coeff, sizeof coeff/sizeof coeff[0] - 1);
  return x + 0.69314718055995 * exp;
  //return x +   0.68768932874451 * exp;
}

//-------------- Returns argument x raised to power of argument y
static double _myPow(double x, double y) {
  unsigned char sign = 0;       // Promenjeno unsigned int u
                                // unsigned char (optimizacija)  MZ 11.08.2008.
  long yi;

  if(y == 0.0)
    return 1.0;
  if(x == 0.0)
    return 0.0;
  if(x < 0.0) {
    yi = (long)y;
    if((double)yi != y)
      return 0.0;
    sign = yi & 1;
    x = -x;
  }
  x = _log(x);
  x = x*y;
  x = _exp(x);

  if(sign)
    return -x;
  return x;
}



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