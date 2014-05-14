#!/usr/bin/bash

export SHARK_HOME=/opt/mapr/shark/shark-0.9.0
export SPARK_HOME=/opt/mapr/spark/spark-0.9.1
export SCALA_HOME=/usr/share/java


export CLASSPATH


#first, use the JAR we care about
CLASSPATH+=target/scala-2.10/m7import_2.10-0.1-SNAPSHOT.jar



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

/bin/java -cp $CLASSPATH org.apache.spark.streaming.m7import.m7import spark://shark-1:7077 shark-1 9999 3