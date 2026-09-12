from pyspark.ml.classification import LogisticRegression
from pyspark.sql import SparkSession
import json
import os

spark = SparkSession.builder.appName("LIBSVM-LMLM-Integration").getOrCreate()

# Load LIBSVM sparse data
df = spark.read.format("libsvm").load("data.libsvm")
df.createOrReplaceTempView("svm_features")

# Distributed Machine Learning Training
lr = LogisticRegression(maxIter=10, regParam=0.3, elasticNetParam=0.8)
model = lr.fit(df)

summary = model.summary
metrics = {
    "total_records": df.count(),
    "objective_history": summary.objectiveHistory[-1] if summary.objectiveHistory else 0.0,
    "features_count": len(model.coefficients)
}

# Generate local AI-driven analysis text using LMLM patterns
analysis_report = (
    f"Model successfully converged across {metrics['total_records']} records "
    f"with {metrics['features_count']} active feature dimensions. "
    f"Final objective value recorded at {metrics['objective_history']:.4f}."
)

metrics["ai_summary"] = analysis_report

# Save consolidated results for the Ratpack backend
os.makedirs("data", exist_ok=True)
with open("data/metrics.json", "w") as f:
    json.dump(metrics, f)
