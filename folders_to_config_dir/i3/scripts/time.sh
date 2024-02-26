#!/usr/bin/bash
# Author: Carlos Lacaci Moya
# Description: Display time 
# Date: sáb 28 ene 2023 13:34:06 CET

# Debugging setup for bash
set -euo pipefail
################################################################################ 

my_time=$(date +%c)
notify-send "$my_time"



