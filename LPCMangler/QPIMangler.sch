EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CPLD_Xilinx:XC9572XL-VQ64 U1
U 1 1 61CDDB88
P 3550 4400
F 0 "U1" H 3550 6281 50  0000 C CNN
F 1 "XC9572VQ64" H 3550 6190 50  0000 C CNN
F 2 "Package_QFP:TQFP-64_10x10mm_P0.5mm" H 3550 4400 50  0001 C CNN
F 3 "" H 3550 4400 50  0001 C CNN
	1    3550 4400
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J1
U 1 1 61CDF12A
P 2250 1450
F 0 "J1" H 2300 825 50  0000 C CNN
F 1 "LPC" H 2300 916 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x08_P2.54mm_Vertical" H 2250 1450 50  0001 C CNN
F 3 "~" H 2250 1450 50  0001 C CNN
	1    2250 1450
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J2
U 1 1 61CDFDA4
P 5300 1300
F 0 "J2" H 5380 1292 50  0000 L CNN
F 1 "JTAG" H 5380 1201 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 5300 1300 50  0001 C CNN
F 3 "~" H 5300 1300 50  0001 C CNN
	1    5300 1300
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 61CE06B9
P 6500 1200
F 0 "J3" H 6580 1192 50  0000 L CNN
F 1 "SMBUS" H 6580 1101 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 6500 1200 50  0001 C CNN
F 3 "~" H 6500 1200 50  0001 C CNN
	1    6500 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1750 2450 1750
Wire Wire Line
	3000 1650 2450 1650
Wire Wire Line
	3000 1550 2450 1550
Wire Wire Line
	3000 1450 2450 1450
Wire Wire Line
	3000 1350 2450 1350
Wire Wire Line
	3000 1250 2450 1250
Wire Wire Line
	3000 1150 2450 1150
Wire Wire Line
	3000 1050 2450 1050
Wire Wire Line
	1950 1150 1400 1150
Wire Wire Line
	1950 1250 1400 1250
Wire Wire Line
	1950 1350 1400 1350
Wire Wire Line
	1950 1450 1400 1450
Wire Wire Line
	1950 1550 1400 1550
Wire Wire Line
	1950 1750 1400 1750
Text Label 1400 1750 0    50   ~ 0
GND
Text Label 1400 1550 0    50   ~ 0
+5V
Text Label 1400 1450 0    50   ~ 0
LAD2
Text Label 1400 1350 0    50   ~ 0
LAD1
Text Label 1400 1250 0    50   ~ 0
GND
Text Label 3000 1750 2    50   ~ 0
LCLK
Text Label 3000 1650 2    50   ~ 0
~LFRAME
Text Label 3000 1550 2    50   ~ 0
~RST
Text Label 3000 1450 2    50   ~ 0
LAD3
Text Label 3000 1350 2    50   ~ 0
+3V3
Text Label 3000 1250 2    50   ~ 0
LAD0
Wire Wire Line
	5400 3100 5950 3100
Wire Wire Line
	4900 5500 4350 5500
Text Label 5400 3100 0    50   ~ 0
LCLK
Text Label 4900 5500 2    50   ~ 0
~LFRAME
Wire Wire Line
	2750 5300 2200 5300
Wire Wire Line
	2750 5400 2200 5400
Text Label 2200 5400 0    50   ~ 0
LAD2
Text Label 2200 5300 0    50   ~ 0
LAD1
Wire Wire Line
	2200 5500 2750 5500
Wire Wire Line
	2200 5200 2750 5200
Text Label 2200 5500 0    50   ~ 0
LAD3
Text Label 3450 2150 3    50   ~ 0
+3V3
Text Label 2200 5200 0    50   ~ 0
LAD0
Wire Wire Line
	3450 6200 3450 6500
Text Label 3450 6750 1    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_02x08_Odd_Even JP1
U 1 1 61D04F0A
P 9150 2100
F 0 "JP1" H 9200 2600 50  0000 C CNN
F 1 "GPIO" H 9200 2500 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x08_P2.54mm_Vertical" H 9150 2100 50  0001 C CNN
F 3 "~" H 9150 2100 50  0001 C CNN
	1    9150 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 1800 10000 1800
Text Label 10000 1800 2    50   ~ 0
GND
Wire Wire Line
	9450 1900 10000 1900
Text Label 10000 1900 2    50   ~ 0
GND
Wire Wire Line
	9450 2000 10000 2000
Text Label 10000 2000 2    50   ~ 0
GND
Wire Wire Line
	8950 1800 8400 1800
Text Label 8400 1800 0    50   ~ 0
GPIO0
Wire Wire Line
	8950 1900 8400 1900
Text Label 8400 1900 0    50   ~ 0
GPIO1
Wire Wire Line
	8950 2000 8400 2000
Text Label 8400 2000 0    50   ~ 0
GPIO2
Wire Wire Line
	4350 3500 4900 3500
Text Label 4900 3500 2    50   ~ 0
GPIO2
Wire Wire Line
	4350 3300 4900 3300
Text Label 4900 3300 2    50   ~ 0
GPIO0
Wire Wire Line
	4350 3400 4900 3400
Text Label 4900 3400 2    50   ~ 0
GPIO1
Wire Wire Line
	2750 4000 2200 4000
Text Label 2200 4000 0    50   ~ 0
~CS
Text Label 2200 3000 0    50   ~ 0
LED0
Wire Wire Line
	2750 4900 2200 4900
Text Label 2200 4900 0    50   ~ 0
LED1
Wire Wire Line
	4350 3000 4900 3000
Wire Wire Line
	4350 2900 4900 2900
Text Label 4900 2900 2    50   ~ 0
S_D2
Text Label 4900 3000 2    50   ~ 0
S_D1
Wire Wire Line
	2200 4100 2750 4100
Wire Wire Line
	4900 3100 4350 3100
Text Label 2200 4100 0    50   ~ 0
S_D3
Text Label 4900 3100 2    50   ~ 0
S_D0
Wire Wire Line
	3450 6500 3550 6500
Wire Wire Line
	3750 6500 3750 6200
Wire Wire Line
	3550 6200 3550 6500
Connection ~ 3550 6500
Wire Wire Line
	3550 6500 3650 6500
Wire Wire Line
	3650 6500 3650 6200
Connection ~ 3650 6500
Wire Wire Line
	3650 6500 3750 6500
Connection ~ 3450 6500
Wire Wire Line
	3450 6500 3450 6750
Wire Wire Line
	3450 2700 3450 2400
Wire Wire Line
	3450 2400 3550 2400
Wire Wire Line
	3750 2400 3750 2700
Wire Wire Line
	3550 2700 3550 2400
Connection ~ 3550 2400
Wire Wire Line
	3550 2400 3650 2400
Wire Wire Line
	3650 2400 3650 2700
Connection ~ 3650 2400
Wire Wire Line
	3650 2400 3750 2400
Connection ~ 3450 2400
Wire Wire Line
	3450 2400 3450 2150
Wire Wire Line
	6300 1400 5750 1400
Text Label 5750 1400 0    50   ~ 0
GND
Wire Wire Line
	5750 1100 6300 1100
Text Label 5750 1100 0    50   ~ 0
+3V3
Wire Wire Line
	5100 1200 4550 1200
Text Label 4550 1200 0    50   ~ 0
GND
Wire Wire Line
	4550 1100 5100 1100
Text Label 4550 1100 0    50   ~ 0
+3V3
Wire Wire Line
	5100 1400 4550 1400
Text Label 4550 1400 0    50   ~ 0
TDO
Wire Wire Line
	4550 1300 5100 1300
Text Label 4550 1300 0    50   ~ 0
TCK
Wire Wire Line
	5100 1600 4550 1600
Text Label 4550 1600 0    50   ~ 0
TMS
Wire Wire Line
	4550 1500 5100 1500
Text Label 4550 1500 0    50   ~ 0
TDI
Wire Wire Line
	6300 1300 5750 1300
Text Label 5750 1300 0    50   ~ 0
SDA
Wire Wire Line
	5750 1200 6300 1200
Text Label 5750 1200 0    50   ~ 0
SCL
Text Label 3000 1150 2    50   ~ 0
SCL
Text Label 1400 1150 0    50   ~ 0
SDA
Text Label 3000 1050 2    50   ~ 0
+3V3
NoConn ~ 1950 1050
NoConn ~ 1950 1650
Wire Wire Line
	5950 2900 5400 2900
Text Label 5400 2900 0    50   ~ 0
~CS
Wire Wire Line
	6950 2900 7500 2900
Wire Wire Line
	6950 3100 7500 3100
Text Label 7500 3100 2    50   ~ 0
S_D2
Text Label 7500 2900 2    50   ~ 0
S_D1
Wire Wire Line
	7500 3200 6950 3200
Wire Wire Line
	7500 2800 6950 2800
Text Label 7500 3200 2    50   ~ 0
S_D3
Text Label 7500 2800 2    50   ~ 0
S_D0
Wire Wire Line
	2750 3000 2200 3000
Wire Wire Line
	2200 3700 2750 3700
Text Label 2200 3700 0    50   ~ 0
~RST
Wire Wire Line
	2200 3600 2750 3600
Text Label 2200 3600 0    50   ~ 0
LCLK
Wire Wire Line
	4350 6000 4900 6000
Text Label 4900 6000 2    50   ~ 0
TDO
Wire Wire Line
	4900 5900 4350 5900
Text Label 4900 5900 2    50   ~ 0
TCK
Wire Wire Line
	4350 5800 4900 5800
Text Label 4900 5800 2    50   ~ 0
TMS
Wire Wire Line
	4900 5700 4350 5700
Text Label 4900 5700 2    50   ~ 0
TDI
Wire Wire Line
	6450 3400 6450 3950
Text Label 6450 3950 1    50   ~ 0
GND
Wire Wire Line
	6450 2050 6450 2600
Text Label 6450 2050 3    50   ~ 0
+3V3
$Comp
L Device:C C1
U 1 1 61E60988
P 5300 7000
F 0 "C1" H 5415 7046 50  0000 L CNN
F 1 "C" H 5415 6955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5338 6850 50  0001 C CNN
F 3 "~" H 5300 7000 50  0001 C CNN
	1    5300 7000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 61E61470
P 5750 7000
F 0 "C2" H 5865 7046 50  0000 L CNN
F 1 "C" H 5865 6955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5788 6850 50  0001 C CNN
F 3 "~" H 5750 7000 50  0001 C CNN
	1    5750 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 7150 5300 7700
Text Label 5300 7700 1    50   ~ 0
GND
Wire Wire Line
	5750 7150 5750 7700
Text Label 5750 7700 1    50   ~ 0
GND
Wire Wire Line
	5300 6300 5300 6850
Text Label 5300 6300 3    50   ~ 0
+3V3
Wire Wire Line
	5750 6300 5750 6850
Text Label 5750 6300 3    50   ~ 0
+3V3
Wire Wire Line
	9250 5250 9800 5250
Text Label 9800 5250 2    50   ~ 0
GPIO0
Wire Wire Line
	9250 5000 9800 5000
Text Label 9800 5000 2    50   ~ 0
GPIO1
Wire Wire Line
	9250 4750 9800 4750
Text Label 9800 4750 2    50   ~ 0
GPIO2
$Comp
L Device:R R1
U 1 1 61CEDE2D
P 9100 5250
F 0 "R1" H 9170 5296 50  0000 L CNN
F 1 "R" H 9170 5205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 5250 50  0001 C CNN
F 3 "~" H 9100 5250 50  0001 C CNN
	1    9100 5250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8400 5250 8950 5250
Text Label 8400 5250 0    50   ~ 0
+3V3
Wire Wire Line
	8400 5000 8950 5000
Text Label 8400 5000 0    50   ~ 0
+3V3
Wire Wire Line
	8400 4750 8950 4750
Text Label 8400 4750 0    50   ~ 0
+3V3
$Comp
L Device:R R2
U 1 1 61CF5497
P 9100 5000
F 0 "R2" H 9170 5046 50  0000 L CNN
F 1 "R" H 9170 4955 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 5000 50  0001 C CNN
F 3 "~" H 9100 5000 50  0001 C CNN
	1    9100 5000
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 61CF5787
P 9100 4750
F 0 "R3" H 9170 4796 50  0000 L CNN
F 1 "R" H 9170 4705 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 4750 50  0001 C CNN
F 3 "~" H 9100 4750 50  0001 C CNN
	1    9100 4750
	0    -1   -1   0   
$EndComp
$Comp
L Memory_Flash:W25Q128JVS U2
U 1 1 61F39AE3
P 6450 3000
F 0 "U2" H 6450 3581 50  0000 C CNN
F 1 "W25Q128JVS" H 6450 3490 50  0000 C CNN
F 2 "Package_SO:SOIC-8_5.23x5.23mm_P1.27mm" H 6450 3000 50  0001 C CNN
F 3 "http://www.winbond.com/resource-files/w25q128jv_dtr%20revc%2003272018%20plus.pdf" H 6450 3000 50  0001 C CNN
	1    6450 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 3600 4900 3600
Text Label 4900 3600 2    50   ~ 0
GPIO3
Wire Wire Line
	4350 3700 4900 3700
Text Label 4900 3700 2    50   ~ 0
GPIO4
Wire Wire Line
	4350 3800 4900 3800
Text Label 4900 3800 2    50   ~ 0
GPIO5
Wire Wire Line
	4350 3900 4900 3900
Text Label 4900 3900 2    50   ~ 0
GPIO6
Wire Wire Line
	4350 4000 4900 4000
Text Label 4900 4000 2    50   ~ 0
GPIO7
Wire Wire Line
	8950 2100 8400 2100
Text Label 8400 2100 0    50   ~ 0
GPIO3
Wire Wire Line
	8950 2200 8400 2200
Text Label 8400 2200 0    50   ~ 0
GPIO4
Wire Wire Line
	8950 2300 8400 2300
Text Label 8400 2300 0    50   ~ 0
GPIO5
Wire Wire Line
	8950 2400 8400 2400
Text Label 8400 2400 0    50   ~ 0
GPIO6
Wire Wire Line
	8950 2500 8400 2500
Text Label 8400 2500 0    50   ~ 0
GPIO7
Wire Wire Line
	9450 2100 10000 2100
Text Label 10000 2100 2    50   ~ 0
GND
Wire Wire Line
	9450 2200 10000 2200
Text Label 10000 2200 2    50   ~ 0
GND
Wire Wire Line
	9450 2300 10000 2300
Text Label 10000 2300 2    50   ~ 0
GND
Wire Wire Line
	9450 2400 10000 2400
Text Label 10000 2400 2    50   ~ 0
GND
Wire Wire Line
	9450 2500 10000 2500
Text Label 10000 2500 2    50   ~ 0
GND
Wire Wire Line
	9250 4500 9800 4500
Text Label 9800 4500 2    50   ~ 0
GPIO3
Wire Wire Line
	9250 4250 9800 4250
Text Label 9800 4250 2    50   ~ 0
GPIO4
Wire Wire Line
	9250 4000 9800 4000
Text Label 9800 4000 2    50   ~ 0
GPIO5
$Comp
L Device:R R4
U 1 1 61F9521D
P 9100 4500
F 0 "R4" H 9170 4546 50  0000 L CNN
F 1 "R" H 9170 4455 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 4500 50  0001 C CNN
F 3 "~" H 9100 4500 50  0001 C CNN
	1    9100 4500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8400 4500 8950 4500
Text Label 8400 4500 0    50   ~ 0
+3V3
Wire Wire Line
	8400 4250 8950 4250
Text Label 8400 4250 0    50   ~ 0
+3V3
Wire Wire Line
	8400 4000 8950 4000
Text Label 8400 4000 0    50   ~ 0
+3V3
$Comp
L Device:R R5
U 1 1 61F95229
P 9100 4250
F 0 "R5" H 9170 4296 50  0000 L CNN
F 1 "R" H 9170 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 4250 50  0001 C CNN
F 3 "~" H 9100 4250 50  0001 C CNN
	1    9100 4250
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R6
U 1 1 61F9522F
P 9100 4000
F 0 "R6" H 9170 4046 50  0000 L CNN
F 1 "R" H 9170 3955 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 4000 50  0001 C CNN
F 3 "~" H 9100 4000 50  0001 C CNN
	1    9100 4000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9250 3750 9800 3750
Text Label 9800 3750 2    50   ~ 0
GPIO6
Wire Wire Line
	9250 3500 9800 3500
Text Label 9800 3500 2    50   ~ 0
GPIO7
Wire Wire Line
	8400 3750 8950 3750
Text Label 8400 3750 0    50   ~ 0
+3V3
Wire Wire Line
	8400 3500 8950 3500
Text Label 8400 3500 0    50   ~ 0
+3V3
$Comp
L Device:R R7
U 1 1 61F99748
P 9100 3750
F 0 "R7" H 9170 3796 50  0000 L CNN
F 1 "R" H 9170 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 3750 50  0001 C CNN
F 3 "~" H 9100 3750 50  0001 C CNN
	1    9100 3750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R8
U 1 1 61F9974E
P 9100 3500
F 0 "R8" H 9170 3546 50  0000 L CNN
F 1 "R" H 9170 3455 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" V 9030 3500 50  0001 C CNN
F 3 "~" H 9100 3500 50  0001 C CNN
	1    9100 3500
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
