# AMD GPU Monitoring for Zabbix on Ubuntu(ethos)

Template and script allow you to monitor multi gpu, tested on ubuntu 16.04, ETHOS.

  - Install Zabbix agent
  - add lines options at the end of agent conf file
  - Import Template Into Zabbix Frontend

### Installation

  - 1 Copy script into /etc/zabbix/scripts/get_gpus_info.sh 
  - 2 Add lines at the end of ZabbixAgent.conf 

```sh
#AMD GPU LINUX
UserParameter=gpu.discovery,/etc/zabbix/scripts/get_gpus_info.sh
UserParameter=gpu.temp[*],export DISPLAY=:0 && xhost + > /dev/null && amdconfig --adapter=$1 --odgt | grep 'Temperature' | cut -d'-' -f2 | cut -d'.' -f1 | tr -d ' '
UserParameter=gpu.utilization[*],export DISPLAY=:0 && xhost + > /dev/null  && amdconfig --adapter=$1 --odgc | grep 'GPU load' | cut -f1 -d'%' | cut -f2 -d':'| tr -d ' '
UserParameter=gpu.number,show stats | grep "gpus:" | tr -s ' ' | cut -d ' ' -f 2
```
  - 3 Import Template into Zabbix 
  - 4 Put your Hosts into template 

#### Tip me a coffee if helpful
| Currency | Addr |
| ------ | ------ |
| Bitcoin | 1HEULe96ey4amR62oDvnaqwgaY1aaJFpwx |

Thanks to for source : https://github.com/plambe/zabbix-nvidia-smi-multi-gpu


