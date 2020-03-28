#!/usr/bin/env python
##     'param'     : "151.128/165.128/166.128",
from ecmwfapi import ECMWFDataServer
    
server = ECMWFDataServer()

## ## Variables de analisis    
## server.retrieve({
##     'stream'    : "oper",
##     'levtype'   : "sfc",
##     'param'     : "166.128",
##     'param'     : "228.128", ## Total Precipitation
##     'param'     : "49.128", ## Windgust
##     'dataset'   : "interim",
##     'step'      : "0",
##     'grid'      : "0.75/0.75",
##     'time'      : "00/06/12/18",
##     'date'      : "2004-01-01/to/2017-07-31",
##     'type'      : "an",
##     'class'     : "ei",
##     'format'    : "netcdf",
##     'target'    : "interim_2004-01-01to2017-07-31_00061218_166.128.nc"
## })
##    "target": "/home/sixto/Documents/DATA/TDS5/tomcat/content/thredds/public/interim/work/INTERIM075_197901-201712_SFC_228.128_an.nc",
##    "target": "/home/sixto/Documents/DATA/TDS5/tomcat/content/thredds/public/interim/work/INTERIM075_197901-201712_SFC_49.128_an.nc",

## Forecast de precipitacion
##     "date": "1979-01-01/to/2017-10-31",
##     "step": "3/6/9/12",

## server.retrieve({
##     "class": "ei",
##     "dataset": "interim",
##     "date": "1979-01-01/to/2017-12-31",
##     "expver": "1",
##     "grid": "0.75/0.75",
##     "levtype": "sfc",
##     "param": "49.128",
##     "step": "12",
##     "stream": "oper",
##     "time": "00:00:00/12:00:00",
##     "type": "fc",
##     "target": "/home/sixto/Documents/DATA/TDS5/tomcat/content/thredds/public/interim/work/INTERIM075_197901-201712_SFC_49.128_fc.nc",
## })
## server.retrieve({
##     "class": "ei",
##     "dataset": "interim",
##     "date": "1979-01-01/to/2017-12-31",
##     "expver": "1",
##     "grid": "0.75/0.75",
##     "levtype": "sfc",
##     "param": "151.128",
##     "step": "0",
##     "stream": "oper",
##     "time": "00:00:00/06:00:00/12:00:00/18:00:00",
##     "type": "an",
##     "target": "/home/sixto/Documents/DATA/TDS5/tomcat/content/thredds/public/interim/work/INTERIM075_197901-201710_SFC_151.128_an.nc",
## })
##     "param": "60.128",
server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "1979-01-01/to/2017-12-31",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "1000",
    "levtype": "pl",
    "param": "138.128",
    "step": "0",
    "stream": "oper",
    "time": "00:00:00/06:00:00/12:00:00/18:00:00",
    "type": "an",
    "target": "/home/sixto/Documents/DATA/TDS5/tomcat/content/thredds/public/interim/work/INTERIM075_197901-201712_1000PL_138.128_an.nc",
})
