from pyspark.ml.classification import LogisticRegression
from pyspark.sql import SparkSession
import json

spark = SparkSession.builder.appName("LIBSVM-ML-Pipeline").getOrCreate()

# Load LIBSVM sparse data
df = spark.read.format("libsvm").load("data.libsvm")
df.createOrReplaceTempView("svm_features")

# Run Spark SQL query to get label distribution
summary_df = spark.sql("""
    SELECT label, COUNT(*) as frequency 
    FROM svm_features 
    GROUP BY label 
    ORDER BY frequency DESC
""")
summary_df.toPandas().to_json("data/summary.json", orient="records")

# Train a distributed Logistic Regression model
lr = LogisticRegression(maxIter=10, regParam=0.3, elasticNetParam=0.8)
model = lr.fit(df)

summary = model.summary
metrics = {
    "total_records": df.count(),
    "objective_history": summary.objectiveHistory[-1] if summary.objectiveHistory else 0.0,
    "features_count": len(model.coefficients)
}

with open("data/metrics.json", "w") as f:
    json.dump(metrics, f)
