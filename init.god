from dataclasses import dataclass, field
from typing import Any, Dict, List
from datetime import datetime
import json, time

@dataclass
class Model:
    name: str
    capabilities: set
    locality: str = "cloud"
    score: float = 1.0

@dataclass
class Task:
    id: str
    objective: str
    capability: str
    status: str = "PENDING"
    assigned_model: str | None = None
    result: Any = None

@dataclass
class Event:
    type: str
    payload: Dict[str, Any]
    timestamp: str = field(default_factory=lambda: datetime.utcnow().isoformat() + "Z")

class LMLMRuntime:
    def __init__(self):
        self.models: List[Model] = []
        self.events: List[Event] = []
        self.memory: Dict[str, Any] = {}
        self.tasks: List[Task] = []

    def emit(self, event_type, **payload):
        event = Event(event_type, payload)
        self.events.append(event)
        print(f"[{event_type}] {payload}")

    def register(self, model):
        self.models.append(model)
        self.emit("CAPABILITIES", model=model.name, capabilities=sorted(model.capabilities))

    def route(self, task):
        candidates = [m for m in self.models if task.capability in m.capabilities]
        if not candidates:
            raise RuntimeError(f"No model supports capability: {task.capability}")
        selected = max(candidates, key=lambda m: m.score)
        task.assigned_model = selected.name
        task.status = "ROUTED"
        self.emit("ROUTE", task=task.id, model=selected.name, capability=task.capability)
        return selected

    def execute(self, task):
        model = next(m for m in self.models if m.name == task.assigned_model)
        task.status = "EXECUTING"
        self.emit("TASK", task=task.id, model=model.name)
        task.result = f"{model.name} completed: {task.objective}"
        task.status = "RESULT"
        self.emit("RESULT", task=task.id, result=task.result)
        return task.result

    def verify(self, task, checks):
        passed = all(check(task.result) for check in checks)
        task.status = "VERIFIED" if passed else "ERROR"
        self.emit("VERIFY", task=task.id, passed=passed)
        return passed
# Register heterogeneous capabilities.
runtime = LMLMRuntime()

runtime.register(Model("LMLM-Reasoner", {"reasoning", "planning"}, locality="cloud", score=0.96))
runtime.register(Model("LMLM-Vision", {"vision"}, locality="local", score=0.91))
runtime.register(Model("LMLM-Coder", {"code", "testing"}, locality="cloud", score=0.95))
runtime.register(Model("LMLM-Researcher", {"research"}, locality="cloud", score=0.94))
runtime.register(Model("LMLM-Local", {"reasoning", "code"}, locality="local", score=0.89))
[CAPABILITIES] {'model': 'LMLM-Reasoner', 'capabilities': ['planning', 'reasoning']}
[CAPABILITIES] {'model': 'LMLM-Vision', 'capabilities': ['vision']}
[CAPABILITIES] {'model': 'LMLM-Coder', 'capabilities': ['code', 'testing']}
[CAPABILITIES] {'model': 'LMLM-Researcher', 'capabilities': ['research']}
[CAPABILITIES] {'model': 'LMLM-Local', 'capabilities': ['code', 'reasoning']}
/tmp/ipykernel_449/3931695040.py:26: DeprecationWarning: datetime.datetime.utcnow() is deprecated and scheduled for removal in a future version. Use timezone-aware objects to represent datetimes in UTC: datetime.datetime.now(datetime.UTC).
  timestamp: str = field(default_factory=lambda: datetime.utcnow().isoformat() + "Z")
