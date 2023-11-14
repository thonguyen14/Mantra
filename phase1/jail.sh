#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
DELAY=300 #Delay time in seconds
for (( ;; )); do
        JAIL=$(echo **** | mantrachaind q staking validator $(mantrachaind keys show tnwl --bech val -a) -o json | jq -r .jailed:);
        if [[ ${JAIL} == *"false"* ]]; then
            echo -e "${GREEN}${JAIL} \n"
        else
            echo -e "${GREEN}${JAIL} \n"
            echo -e $(echo **** | mantrachaind tx slashing unjail --from tnwl --chain-id mantrachain-testnet-1 --node="http://127.0.0.1:29657" --gas=auto --gas-adjustment 1.5 --fees 100uaum -y) \n;
            sleep 1
        fi
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED}%02d${NC} sec\r" $timer
                sleep 1
        done
done
