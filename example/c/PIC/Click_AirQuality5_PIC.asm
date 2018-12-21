
_systemInit:

;Click_AirQuality5_PIC.c,38 :: 		void systemInit()
;Click_AirQuality5_PIC.c,40 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
	CLRF        FARG_mikrobus_gpioInit_bus+0 
	MOVLW       7
	MOVWF       FARG_mikrobus_gpioInit_pin+0 
	MOVLW       1
	MOVWF       FARG_mikrobus_gpioInit_direction+0 
	CALL        _mikrobus_gpioInit+0, 0
;Click_AirQuality5_PIC.c,41 :: 		mikrobus_i2cInit( _MIKROBUS1, &_AIRQ5_I2C_CFG[0] );
	CLRF        FARG_mikrobus_i2cInit_bus+0 
	MOVLW       __AIRQ5_I2C_CFG+0
	MOVWF       FARG_mikrobus_i2cInit_cfg+0 
	MOVLW       hi_addr(__AIRQ5_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+1 
	MOVLW       higher_addr(__AIRQ5_I2C_CFG+0)
	MOVWF       FARG_mikrobus_i2cInit_cfg+2 
	CALL        _mikrobus_i2cInit+0, 0
;Click_AirQuality5_PIC.c,42 :: 		mikrobus_logInit( _LOG_USBUART, 9600 );
	MOVLW       16
	MOVWF       FARG_mikrobus_logInit_port+0 
	MOVLW       128
	MOVWF       FARG_mikrobus_logInit_baud+0 
	MOVLW       37
	MOVWF       FARG_mikrobus_logInit_baud+1 
	MOVLW       0
	MOVWF       FARG_mikrobus_logInit_baud+2 
	MOVWF       FARG_mikrobus_logInit_baud+3 
	CALL        _mikrobus_logInit+0, 0
;Click_AirQuality5_PIC.c,43 :: 		Delay_ms( 100 );
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_systemInit0:
	DECFSZ      R13, 1, 1
	BRA         L_systemInit0
	DECFSZ      R12, 1, 1
	BRA         L_systemInit0
	DECFSZ      R11, 1, 1
	BRA         L_systemInit0
	NOP
;Click_AirQuality5_PIC.c,44 :: 		}
L_end_systemInit:
	RETURN      0
; end of _systemInit

_applicationInit:

;Click_AirQuality5_PIC.c,46 :: 		void applicationInit()
;Click_AirQuality5_PIC.c,48 :: 		airq5_i2cDriverInit( (T_AIRQ5_P)&_MIKROBUS1_GPIO, (T_AIRQ5_P)&_MIKROBUS1_I2C, 0x48 );
	MOVLW       __MIKROBUS1_GPIO+0
	MOVWF       FARG_airq5_i2cDriverInit_gpioObj+0 
	MOVLW       hi_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_airq5_i2cDriverInit_gpioObj+1 
	MOVLW       higher_addr(__MIKROBUS1_GPIO+0)
	MOVWF       FARG_airq5_i2cDriverInit_gpioObj+2 
	MOVLW       __MIKROBUS1_I2C+0
	MOVWF       FARG_airq5_i2cDriverInit_i2cObj+0 
	MOVLW       hi_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_airq5_i2cDriverInit_i2cObj+1 
	MOVLW       higher_addr(__MIKROBUS1_I2C+0)
	MOVWF       FARG_airq5_i2cDriverInit_i2cObj+2 
	MOVLW       72
	MOVWF       FARG_airq5_i2cDriverInit_slave+0 
	CALL        _airq5_i2cDriverInit+0, 0
;Click_AirQuality5_PIC.c,50 :: 		_AIRQ5_CONFIG_PGA_2_048V |
	MOVLW       __AIRQ5_CONFIG_OS_SINGLE
	MOVWF       R0 
	MOVLW       __AIRQ5_CONFIG_OS_SINGLE+1
	MOVWF       R1 
	MOVLW       __AIRQ5_CONFIG_PGA_2_048V
	IORWF       R0, 0 
	MOVWF       FARG_airq5_setConfiguration_config+0 
	MOVF        R1, 0 
	IORLW       __AIRQ5_CONFIG_PGA_2_048V+1
	MOVWF       FARG_airq5_setConfiguration_config+1 
;Click_AirQuality5_PIC.c,51 :: 		_AIRQ5_CONFIG_SINGLE_MODE |
	MOVLW       __AIRQ5_CONFIG_SINGLE_MODE
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_SINGLE_MODE+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
;Click_AirQuality5_PIC.c,52 :: 		_AIRQ5_CONFIG_DATA_RATE_1600SPS |
	MOVLW       __AIRQ5_CONFIG_DATA_RATE_1600SPS
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_DATA_RATE_1600SPS+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
;Click_AirQuality5_PIC.c,53 :: 		_AIRQ5_CONFIG_COMP_MODE_TRADITIONAL |
	MOVLW       __AIRQ5_CONFIG_COMP_MODE_TRADITIONAL
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_COMP_MODE_TRADITIONAL+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
;Click_AirQuality5_PIC.c,54 :: 		_AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW |
	MOVLW       __AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
;Click_AirQuality5_PIC.c,55 :: 		_AIRQ5_CONFIG_COMP_LAT_NOT_LATCH |
	MOVLW       __AIRQ5_CONFIG_COMP_LAT_NOT_LATCH
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_COMP_LAT_NOT_LATCH+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
;Click_AirQuality5_PIC.c,56 :: 		_AIRQ5_CONFIG_COMP_QUE_0CONV );
	MOVLW       __AIRQ5_CONFIG_COMP_QUE_0CONV
	IORWF       FARG_airq5_setConfiguration_config+0, 1 
	MOVLW       __AIRQ5_CONFIG_COMP_QUE_0CONV+1
	IORWF       FARG_airq5_setConfiguration_config+1, 1 
	CALL        _airq5_setConfiguration+0, 0
;Click_AirQuality5_PIC.c,57 :: 		}
L_end_applicationInit:
	RETURN      0
; end of _applicationInit

_applicationTask:

;Click_AirQuality5_PIC.c,59 :: 		void applicationTask()
;Click_AirQuality5_PIC.c,61 :: 		NO2_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NO2);
	MOVLW       __AIRQ5_DATA_CHANNEL_NO2
	MOVWF       FARG_airq5_readSensorData_channel_data+0 
	MOVLW       __AIRQ5_DATA_CHANNEL_NO2+1
	MOVWF       FARG_airq5_readSensorData_channel_data+1 
	CALL        _airq5_readSensorData+0, 0
	MOVF        R0, 0 
	MOVWF       _NO2_sensorData+0 
	MOVF        R1, 0 
	MOVWF       _NO2_sensorData+1 
;Click_AirQuality5_PIC.c,62 :: 		NH3_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NH3);
	MOVLW       __AIRQ5_DATA_CHANNEL_NH3
	MOVWF       FARG_airq5_readSensorData_channel_data+0 
	MOVLW       __AIRQ5_DATA_CHANNEL_NH3+1
	MOVWF       FARG_airq5_readSensorData_channel_data+1 
	CALL        _airq5_readSensorData+0, 0
	MOVF        R0, 0 
	MOVWF       _NH3_sensorData+0 
	MOVF        R1, 0 
	MOVWF       _NH3_sensorData+1 
;Click_AirQuality5_PIC.c,63 :: 		CO_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_CO);
	MOVLW       __AIRQ5_DATA_CHANNEL_CO
	MOVWF       FARG_airq5_readSensorData_channel_data+0 
	MOVLW       __AIRQ5_DATA_CHANNEL_CO+1
	MOVWF       FARG_airq5_readSensorData_channel_data+1 
	CALL        _airq5_readSensorData+0, 0
	MOVF        R0, 0 
	MOVWF       _CO_sensorData+0 
	MOVF        R1, 0 
	MOVWF       _CO_sensorData+1 
;Click_AirQuality5_PIC.c,65 :: 		NO2_Data = airq5_getNO2Data(NO2_sensorData);
	MOVF        _NO2_sensorData+0, 0 
	MOVWF       FARG_airq5_getNO2Data_NO2_data+0 
	MOVF        _NO2_sensorData+1, 0 
	MOVWF       FARG_airq5_getNO2Data_NO2_data+1 
	CALL        _airq5_getNO2Data+0, 0
	MOVF        R0, 0 
	MOVWF       _NO2_Data+0 
	MOVF        R1, 0 
	MOVWF       _NO2_Data+1 
	MOVF        R2, 0 
	MOVWF       _NO2_Data+2 
	MOVF        R3, 0 
	MOVWF       _NO2_Data+3 
;Click_AirQuality5_PIC.c,66 :: 		airq5_getNH3Data(NH3_sensorData, NH3_bufferData);
	MOVF        _NH3_sensorData+0, 0 
	MOVWF       FARG_airq5_getNH3Data_NH3_Data+0 
	MOVF        _NH3_sensorData+1, 0 
	MOVWF       FARG_airq5_getNH3Data_NH3_Data+1 
	MOVLW       _NH3_bufferData+0
	MOVWF       FARG_airq5_getNH3Data_dataBuffer+0 
	MOVLW       hi_addr(_NH3_bufferData+0)
	MOVWF       FARG_airq5_getNH3Data_dataBuffer+1 
	CALL        _airq5_getNH3Data+0, 0
;Click_AirQuality5_PIC.c,67 :: 		airq5_getCOData(CO_sensorData, CO_bufferData);
	MOVF        _CO_sensorData+0, 0 
	MOVWF       FARG_airq5_getCOData_CO_Data+0 
	MOVF        _CO_sensorData+1, 0 
	MOVWF       FARG_airq5_getCOData_CO_Data+1 
	MOVLW       _CO_bufferData+0
	MOVWF       FARG_airq5_getCOData_dataBuffer+0 
	MOVLW       hi_addr(_CO_bufferData+0)
	MOVWF       FARG_airq5_getCOData_dataBuffer+1 
	CALL        _airq5_getCOData+0, 0
;Click_AirQuality5_PIC.c,69 :: 		FloatToStr(NO2_Data, dataText);
	MOVF        _NO2_Data+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _NO2_Data+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _NO2_Data+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _NO2_Data+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,70 :: 		mikrobus_logWrite(" NO2 data: ", _LOG_TEXT);
	MOVLW       ?lstr1_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr1_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,71 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,72 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr2_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr2_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,74 :: 		FloatToStr(NH3_bufferData[0], dataText);
	MOVF        _NH3_bufferData+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _NH3_bufferData+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _NH3_bufferData+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _NH3_bufferData+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,75 :: 		mikrobus_logWrite(" NH3 data: ", _LOG_TEXT);
	MOVLW       ?lstr3_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr3_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,76 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,77 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr4_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr4_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,79 :: 		FloatToStr(NH3_bufferData[1], dataText);
	MOVF        _NH3_bufferData+4, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _NH3_bufferData+5, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _NH3_bufferData+6, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _NH3_bufferData+7, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,80 :: 		mikrobus_logWrite(" C3H8 data: ", _LOG_TEXT);
	MOVLW       ?lstr5_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr5_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,81 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,82 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr6_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr6_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,84 :: 		FloatToStr(NH3_bufferData[2], dataText);
	MOVF        _NH3_bufferData+8, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _NH3_bufferData+9, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _NH3_bufferData+10, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _NH3_bufferData+11, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,85 :: 		mikrobus_logWrite(" C4H10 data: ", _LOG_TEXT);
	MOVLW       ?lstr7_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr7_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,86 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,87 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr8_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr8_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,89 :: 		FloatToStr(CO_bufferData[0], dataText);
	MOVF        _CO_bufferData+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _CO_bufferData+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _CO_bufferData+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _CO_bufferData+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,90 :: 		mikrobus_logWrite(" CO data: ", _LOG_TEXT);
	MOVLW       ?lstr9_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr9_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,91 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,92 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr10_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr10_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,94 :: 		FloatToStr(CO_bufferData[1], dataText);
	MOVF        _CO_bufferData+4, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _CO_bufferData+5, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _CO_bufferData+6, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _CO_bufferData+7, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,95 :: 		mikrobus_logWrite(" CH4 data: ", _LOG_TEXT);
	MOVLW       ?lstr11_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr11_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,96 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,97 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr12_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr12_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,99 :: 		FloatToStr(CO_bufferData[2], dataText);
	MOVF        _CO_bufferData+8, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _CO_bufferData+9, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _CO_bufferData+10, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _CO_bufferData+11, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,100 :: 		mikrobus_logWrite(" H2 data: ", _LOG_TEXT);
	MOVLW       ?lstr13_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr13_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,101 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,102 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr14_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr14_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,104 :: 		FloatToStr(CO_bufferData[3], dataText);
	MOVF        _CO_bufferData+12, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _CO_bufferData+13, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _CO_bufferData+14, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _CO_bufferData+15, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _dataText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Click_AirQuality5_PIC.c,105 :: 		mikrobus_logWrite(" C2H5OH data: ", _LOG_TEXT);
	MOVLW       ?lstr15_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr15_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,106 :: 		mikrobus_logWrite(dataText, _LOG_TEXT);
	MOVLW       _dataText+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(_dataText+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,107 :: 		mikrobus_logWrite(" ppm", _LOG_LINE);
	MOVLW       ?lstr16_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr16_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,109 :: 		mikrobus_logWrite(" -------- ", _LOG_LINE);
	MOVLW       ?lstr17_Click_AirQuality5_PIC+0
	MOVWF       FARG_mikrobus_logWrite_data_+0 
	MOVLW       hi_addr(?lstr17_Click_AirQuality5_PIC+0)
	MOVWF       FARG_mikrobus_logWrite_data_+1 
	MOVLW       2
	MOVWF       FARG_mikrobus_logWrite_format+0 
	CALL        _mikrobus_logWrite+0, 0
;Click_AirQuality5_PIC.c,110 :: 		Delay_ms( 500 );
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_applicationTask1:
	DECFSZ      R13, 1, 1
	BRA         L_applicationTask1
	DECFSZ      R12, 1, 1
	BRA         L_applicationTask1
	DECFSZ      R11, 1, 1
	BRA         L_applicationTask1
;Click_AirQuality5_PIC.c,111 :: 		}
L_end_applicationTask:
	RETURN      0
; end of _applicationTask

_main:

;Click_AirQuality5_PIC.c,113 :: 		void main()
;Click_AirQuality5_PIC.c,115 :: 		systemInit();
	CALL        _systemInit+0, 0
;Click_AirQuality5_PIC.c,116 :: 		applicationInit();
	CALL        _applicationInit+0, 0
;Click_AirQuality5_PIC.c,118 :: 		while (1)
L_main2:
;Click_AirQuality5_PIC.c,120 :: 		applicationTask();
	CALL        _applicationTask+0, 0
;Click_AirQuality5_PIC.c,121 :: 		}
	GOTO        L_main2
;Click_AirQuality5_PIC.c,122 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
