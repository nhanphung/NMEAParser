# NMEAParser
**University of Houston - Senior Design Team (2016)**

- Nhan Phung

- Erik Van Aller

- Kyle Walker

- Vinh Truong 

##Usage
1. Run NMEAParser.m
2. Select GPRMC data file to parse. e.g. SAMPLE.TXT
3. Output file will be generated in the same folder. e.g. PARSED_SAMPLE.TXT

##Format
This parser extracts 5 pieces of information from the original RMC data file.
Output file is a comma-separated file contains: Date, Time, Latitude, Longtitude, Speed (in knots).

######Example:
Original RMC string:

> $GPRMC,043710.000,A,2941.4394,N,09537.1506,W,0.19,167.38,080516,,,A*7A

Parsed string:

> 04:37:10,05/08/2016,29.69066,-95.61918,0.19