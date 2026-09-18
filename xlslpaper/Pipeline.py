from transformers import AutoTokenizer
import transformers
import torch

model_id = "meta-llama/CodeLlama-70b-hf"
tokenizer = AutoTokenizer.from_pretrained(model_id)
pipeline = transformers.pipeline(
   "text-generation",
   model=model_id,
   torch_dtype=torch.float16,
   device_map="auto",
)

sequences = pipeline(
   'def fibonacci(',
   do_sample=True,
   temperature=0.2,
   top_p=0.9,
   num_return_sequences=1,
   eos_token_id=tokenizer.eos_token_id,
   max_length=100,
)
for seq in sequences:
   print(f"Result: {seq['generated_text']}")
