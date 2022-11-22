## 修改默认的mod
- build/modules.conf.in
- conf/vanilla/autoload_configs/modules.conf.xml
## docker
- docker build -t fengz/aiswitch:v1
- docker run -d -t --name=fengz_aiswitch --net=host --hostname=fengz_aiswitch fengz/aiswitch:v1
