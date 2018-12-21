_systemInit:
;Click_AirQuality5_STM.c,34 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_AirQuality5_STM.c,36 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_AirQuality5_STM.c,37 :: 		mikrobus_i2cInit( _MIKROBUS1, &_AIRQ5_I2C_CFG[0] );
MOVW	R0, #lo_addr(__AIRQ5_I2C_CFG+0)
MOVT	R0, #hi_addr(__AIRQ5_I2C_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_i2cInit+0
;Click_AirQuality5_STM.c,38 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 );
MOVW	R1, #9600
MOVS	R0, #32
BL	_mikrobus_logInit+0
;Click_AirQuality5_STM.c,39 :: 		Delay_ms( 100 );
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_systemInit0:
SUBS	R7, R7, #1
BNE	L_systemInit0
NOP
NOP
NOP
;Click_AirQuality5_STM.c,40 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_AirQuality5_STM.c,42 :: 		void applicationInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_AirQuality5_STM.c,44 :: 		airq5_i2cDriverInit( (T_AIRQ5_P)&_MIKROBUS1_GPIO, (T_AIRQ5_P)&_MIKROBUS1_I2C, 0x48 );
MOVS	R2, #72
MOVW	R1, #lo_addr(__MIKROBUS1_I2C+0)
MOVT	R1, #hi_addr(__MIKROBUS1_I2C+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_airq5_i2cDriverInit+0
;Click_AirQuality5_STM.c,46 :: 		_AIRQ5_CONFIG_PGA_2_048V |
MOVW	R1, __AIRQ5_CONFIG_PGA_2_048V
MOVW	R0, __AIRQ5_CONFIG_OS_SINGLE
ORR	R1, R0, R1, LSL #0
UXTH	R1, R1
;Click_AirQuality5_STM.c,47 :: 		_AIRQ5_CONFIG_SINGLE_MODE |
MOVW	R0, __AIRQ5_CONFIG_SINGLE_MODE
ORRS	R1, R0
UXTH	R1, R1
;Click_AirQuality5_STM.c,48 :: 		_AIRQ5_CONFIG_DATA_RATE_1600SPS |
MOVW	R0, __AIRQ5_CONFIG_DATA_RATE_1600SPS
ORRS	R1, R0
UXTH	R1, R1
;Click_AirQuality5_STM.c,49 :: 		_AIRQ5_CONFIG_COMP_MODE_TRADITIONAL |
MOVW	R0, __AIRQ5_CONFIG_COMP_MODE_TRADITIONAL
ORRS	R1, R0
UXTH	R1, R1
;Click_AirQuality5_STM.c,50 :: 		_AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW |
MOVW	R0, __AIRQ5_CONFIG_COMP_POL_ACTIVE_LOW
ORRS	R1, R0
UXTH	R1, R1
;Click_AirQuality5_STM.c,51 :: 		_AIRQ5_CONFIG_COMP_LAT_NOT_LATCH |
MOVW	R0, __AIRQ5_CONFIG_COMP_LAT_NOT_LATCH
ORRS	R1, R0
UXTH	R1, R1
;Click_AirQuality5_STM.c,52 :: 		_AIRQ5_CONFIG_COMP_QUE_0CONV );
MOVW	R0, __AIRQ5_CONFIG_COMP_QUE_0CONV
ORR	R0, R1, R0, LSL #0
BL	_airq5_setConfiguration+0
;Click_AirQuality5_STM.c,53 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationInit
_applicationTask:
;Click_AirQuality5_STM.c,55 :: 		void applicationTask()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_AirQuality5_STM.c,57 :: 		NO2_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NO2);
MOVW	R0, __AIRQ5_DATA_CHANNEL_NO2
BL	_airq5_readSensorData+0
MOVW	R1, #lo_addr(_NO2_sensorData+0)
MOVT	R1, #hi_addr(_NO2_sensorData+0)
STRH	R0, [R1, #0]
;Click_AirQuality5_STM.c,58 :: 		NH3_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_NH3);
MOVW	R0, __AIRQ5_DATA_CHANNEL_NH3
BL	_airq5_readSensorData+0
MOVW	R1, #lo_addr(_NH3_sensorData+0)
MOVT	R1, #hi_addr(_NH3_sensorData+0)
STRH	R0, [R1, #0]
;Click_AirQuality5_STM.c,59 :: 		CO_sensorData = airq5_readSensorData(_AIRQ5_DATA_CHANNEL_CO);
MOVW	R0, __AIRQ5_DATA_CHANNEL_CO
BL	_airq5_readSensorData+0
MOVW	R1, #lo_addr(_CO_sensorData+0)
MOVT	R1, #hi_addr(_CO_sensorData+0)
STRH	R0, [R1, #0]
;Click_AirQuality5_STM.c,61 :: 		IntToStr(NO2_sensorData, dataText);
MOVW	R0, #lo_addr(_NO2_sensorData+0)
MOVT	R0, #hi_addr(_NO2_sensorData+0)
LDRH	R0, [R0, #0]
MOVW	R1, #lo_addr(_dataText+0)
MOVT	R1, #hi_addr(_dataText+0)
BL	_IntToStr+0
;Click_AirQuality5_STM.c,62 :: 		mikrobus_logWrite(" NO2 data: ", _LOG_TEXT);
MOVW	R0, #lo_addr(?lstr1_Click_AirQuality5_STM+0)
MOVT	R0, #hi_addr(?lstr1_Click_AirQuality5_STM+0)
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,63 :: 		mikrobus_logWrite(dataText, _LOG_LINE);
MOVS	R1, #2
MOVW	R0, #lo_addr(_dataText+0)
MOVT	R0, #hi_addr(_dataText+0)
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,65 :: 		IntToStr(NH3_sensorData, dataText);
MOVW	R0, #lo_addr(_NH3_sensorData+0)
MOVT	R0, #hi_addr(_NH3_sensorData+0)
LDRH	R0, [R0, #0]
MOVW	R1, #lo_addr(_dataText+0)
MOVT	R1, #hi_addr(_dataText+0)
BL	_IntToStr+0
;Click_AirQuality5_STM.c,66 :: 		mikrobus_logWrite(" NH3 data: ", _LOG_TEXT);
MOVW	R0, #lo_addr(?lstr2_Click_AirQuality5_STM+0)
MOVT	R0, #hi_addr(?lstr2_Click_AirQuality5_STM+0)
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,67 :: 		mikrobus_logWrite(dataText, _LOG_LINE);
MOVS	R1, #2
MOVW	R0, #lo_addr(_dataText+0)
MOVT	R0, #hi_addr(_dataText+0)
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,69 :: 		IntToStr(CO_sensorData, dataText);
MOVW	R0, #lo_addr(_CO_sensorData+0)
MOVT	R0, #hi_addr(_CO_sensorData+0)
LDRH	R0, [R0, #0]
MOVW	R1, #lo_addr(_dataText+0)
MOVT	R1, #hi_addr(_dataText+0)
BL	_IntToStr+0
;Click_AirQuality5_STM.c,70 :: 		mikrobus_logWrite(" CO data: ", _LOG_TEXT);
MOVW	R0, #lo_addr(?lstr3_Click_AirQuality5_STM+0)
MOVT	R0, #hi_addr(?lstr3_Click_AirQuality5_STM+0)
MOVS	R1, #1
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,71 :: 		mikrobus_logWrite(dataText, _LOG_LINE);
MOVS	R1, #2
MOVW	R0, #lo_addr(_dataText+0)
MOVT	R0, #hi_addr(_dataText+0)
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,73 :: 		mikrobus_logWrite(" -------- ", _LOG_LINE);
MOVW	R0, #lo_addr(?lstr4_Click_AirQuality5_STM+0)
MOVT	R0, #hi_addr(?lstr4_Click_AirQuality5_STM+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_AirQuality5_STM.c,74 :: 		Delay_ms( 200 );
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_applicationTask2:
SUBS	R7, R7, #1
BNE	L_applicationTask2
NOP
NOP
NOP
;Click_AirQuality5_STM.c,75 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationTask
_main:
;Click_AirQuality5_STM.c,77 :: 		void main()
;Click_AirQuality5_STM.c,79 :: 		systemInit();
BL	_systemInit+0
;Click_AirQuality5_STM.c,80 :: 		applicationInit();
BL	_applicationInit+0
;Click_AirQuality5_STM.c,82 :: 		while (1)
L_main4:
;Click_AirQuality5_STM.c,84 :: 		applicationTask();
BL	_applicationTask+0
;Click_AirQuality5_STM.c,85 :: 		}
IT	AL
BAL	L_main4
;Click_AirQuality5_STM.c,86 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
