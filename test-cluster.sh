MASTER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' play-with-redis-go-cluster_master1_1)
SLAVE_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' play-with-redis-go-cluster_slave1_1)
SLAVE2_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' play-with-redis-go-cluster_slave1_2)
SENTINEL_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' play-with-redis-go-cluster_sentinel1_1)

echo Redis master: $MASTER_IP
echo Redis Slave1: $SLAVE_IP
echo Redis Slave2: $SLAVE2_IP
echo ------------------------------------------------
echo Initial status of sentinel
echo ------------------------------------------------
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 info Sentinel
echo Current master is
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 SENTINEL get-master-addr-by-name mymaster
echo ------------------------------------------------

echo Stop redis master
docker pause play-with-redis-go-cluster_master1_1
echo Wait for 10 seconds
sleep 10
echo Current infomation of sentinel
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 info Sentinel
echo Current master is
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 SENTINEL get-master-addr-by-name mymaster


echo ------------------------------------------------
echo Restart Redis master
docker unpause play-with-redis-go-cluster_master1_1
sleep 5
echo Current infomation of sentinel
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 info Sentinel
echo Current master is
docker exec play-with-redis-go-cluster_sentinel1_1 redis-cli -p 26379 SENTINEL get-master-addr-by-name mymaster