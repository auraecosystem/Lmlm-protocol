from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("LIBSVM-ETL").getOrCreate()

# Load LIBSVM sparse data
df = spark.read.format("libsvm").load("data.libsvm")
df.createOrReplaceTempView("svm_features")

# Run Spark SQL query to get feature summary statistics
summary_df = spark.sql("""
    SELECT label, COUNT(*) as frequency 
    FROM svm_features 
    GROUP BY label 
    ORDER BY frequency DESC
""")

# Export results for the Ratpack backend to consume
summary_df.toPandas().to_json("data/summary.json", orient="records")
