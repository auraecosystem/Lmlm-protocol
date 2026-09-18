from datasets import load_dataset

# Load a specific category
ds = load_dataset("markov-ai/computer-use-large", "blender")

# Load all categories
ds = load_dataset("markov-ai/computer-use-large")
