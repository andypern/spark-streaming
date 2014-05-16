name := "m7import"

scalaVersion := "2.10.3"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-streaming" % "0.9.1",
  "org.apache.hbase" % "hbase" % "0.94.17"
)

resolvers ++= Seq( "Akka Repository" at
"http://repo.akka.io/releases/","Spray Repository" at
"http://repo.spray.cc/")