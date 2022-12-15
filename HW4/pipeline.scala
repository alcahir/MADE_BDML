import breeze.stats.distributions.RandBasis
import breeze.linalg._
import org.apache.spark.ml.regression.LinearRegression
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.sql.SparkSession

object Main extends App {
  val spark = SparkSession.builder
    .appName("Linear regression in Sparkovich")
    .master(s"local[*]")
    .getOrCreate()

  spark.sparkContext.setLogLevel("ERROR")
  import spark.sqlContext.implicits._

  val rand = RandBasis.withSeed(42).uniform
  val X = DenseMatrix.rand[Double](1000000, 3, rand)
  val y = X * DenseVector[Double](1.5, 0.3, -0.7)
  val dataset = DenseMatrix.horzcat(X, y.asDenseMatrix.t)
  val df = data(*, ::).iterator
    .map(x => (x(0), x(1), x(2), x(3)))
    .toSeq
    .toDF("x1", "x2", "x3", "y")
  val pipeline = new Pipeline().setStages(Array(
    new VectorAssembler()
      .setInputCols(Array("x1", "x2", "x3", "y"))
      .setOutputCol("features"),
    new LinearRegression().setFeaturesCol("features").setLabelCol("label")
  ))
  val model = pipeline.fit(df)
  model
   .transform(df)
   .show(false)
  spark.stop()
}