##------------------Don't touch----------------------##
clear -all

# Config rules
config_rtlds -rule -enable -domain { LINT }
config_rtlds -rule -disable -domain { DFT AUTO_FORMAL }

# ivcad2022_constrain //
config_rtlds -rule  -disable -category { NAMING }
config_rtlds -rule  -disable -tag { IDN_NR_CKYW  NAM_NR_REPU MOD_NR_PGAT MOD_NO_IPRG FLP_NR_MXCS REG_NR_RWRC INS_NR_INPR MOD_NS_GLGC OTP_NR_ASYA} 
# ivcad2022_constrain //

##------------------Don't touch----------------------##

# import and elaborate design //
analyze -v2k ./CPU.v; ## modify your file name ##
elaborate -bbox true -top CPU ; ## modify your top module ##

# Setup clock and reset
clock clk; ## modify your clock name ##
reset rst; ## modify your reset name ##

# Extract checks
check_superlint -extract

