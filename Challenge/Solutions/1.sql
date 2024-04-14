# 1. Provide the list of markets in which customer "AtliqExclusive" operates its business in the APAC region.

SELECT distinct market FROM gdb023.dim_customer where customer="Atliq Exclusive" and region="APAC";