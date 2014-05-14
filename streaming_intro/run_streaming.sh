#!/usr/bin/bash

# To use this:
# 1) mkfifo /mapr/cluster/input
# 2) tail -f /mapr/cluster/input | nc -lk 9999
# 3) start this spark app to connect to the port
# 4) echo/cat stuff into /mapr/cluster/input
# This should allow the connection to stay open, and be able to shove whatever you want into the FIFO and have it show up on the spark side.




export SHARK_HOME=/opt/mapr/shark/shark-0.9.0
export SPARK_HOME=/opt/mapr/spark/spark-0.9.1
export SCALA_HOME=/usr/share/java
export CLASSPATH

SPARK_MASTER=$1
HOSTNAME=$2
PORT=$3

#first, use the JAR we care about
CLASSPATH+=target/scala-2.10/streamcatcher_2.10-0.1-SNAPSHOT.jar



#next, grab jars from mapR spark + shark folders

for jar in `find $SPARK_HOME -name '*.jar'`; do
	CLASSPATH+=:$jar
done

for jar in `find $SHARK_HOME/lib_managed -name '*.jar'`; do
	CLASSPATH+=:$jar
done

#lastly, grab JARS from scala dir

for jar in `find $SCALA_HOME -name 'scala*.jar'`; do
	CLASSPATH+=:$jar
done




#finally, execute the code

/bin/java -cp $CLASSPATH org.apache.spark.streaming.andyp.NetworkWordCount ${SPARK_MASTER} ${HOSTNAME} ${PORT}