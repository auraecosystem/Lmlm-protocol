from threading import Thread
from transformers import TextIteratorStreamer

class LocalStreamer:
    def __init__(self, model, tokenizer):
        self.model = model
        self.tokenizer = tokenizer

    def stream_response(self, prompt: str):
        inputs = self.tokenizer(prompt, return_tensors="pt").to(self.model.device)
        streamer = TextIteratorStreamer(self.tokenizer, skip_prompt=True, skip_special_tokens=True)
        generation_kwargs = dict(**inputs, streamer=streamer, max_new_tokens=512)
        
        thread = Thread(target=self.model.generate, kwargs=generation_kwargs)
        thread.start()
        
        for new_text in streamer:
            yield new_text
