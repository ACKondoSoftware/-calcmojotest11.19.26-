
# Cat's Calculator 0.3
# Single-file Mojo + Tkinter
# Copyright AC Kondo 1999-2026

from std.ffi import external_call, c_int

def main() raises:
    print("Cat's Calculator 0.3")

    var command = """python3 -c 'import tkinter as tk
import ast
import operator

ops = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.truediv,
    ast.UAdd: operator.pos,
    ast.USub: operator.neg
}

def calculate(expr):
    def evaluate(node):
        if isinstance(node, ast.Constant) and type(node.value) in (int, float):
            return node.value
        if isinstance(node, ast.BinOp) and type(node.op) in ops:
            return ops[type(node.op)](evaluate(node.left), evaluate(node.right))
        if isinstance(node, ast.UnaryOp) and type(node.op) in ops:
            return ops[type(node.op)](evaluate(node.operand))
        raise ValueError("Invalid expression")
    return evaluate(ast.parse(expr, mode="eval").body)

root = tk.Tk()
root.title("Cats Calculator 0.3")
w, h = 1200, 800
x = (root.winfo_screenwidth() - w) // 2
y = (root.winfo_screenheight() - h) // 2
root.geometry(f"{w}x{h}+{x}+{y}")
root.configure(bg="#111111")

value = tk.StringVar()
display = tk.Entry(
    root, textvariable=value,
    font=("Menlo", 40),
    bg="#222222", fg="#00aaff",
    insertbackground="white",
    justify="right", relief="flat"
)
display.pack(fill="x", padx=24, pady=24, ipady=20)

def press(key):
    if key == "C":
        value.set("")
    elif key == "=":
        try:
            value.set(str(calculate(value.get())))
        except Exception:
            value.set("Error")
    else:
        if value.get() == "Error":
            value.set("")
        value.set(value.get() + key)

frame = tk.Frame(root, bg="#111111")
frame.pack(expand=True, fill="both", padx=24, pady=12)

rows = [
    ["7", "8", "9", "/"],
    ["4", "5", "6", "*"],
    ["1", "2", "3", "-"],
    ["C", "0", ".", "+"],
    ["="]
]

for i, row in enumerate(rows):
    for j, key in enumerate(row):
        tk.Button(
            frame, text=key,
            font=("Menlo", 30),
            bg="#292929", fg="#00aaff",
            activebackground="#444444",
            activeforeground="white",
            relief="flat",
            command=lambda k=key: press(k)
        ).grid(
            row=i, column=j,
            columnspan=4 if key == "=" else 1,
            sticky="nsew", padx=6, pady=6
        )

for i in range(5):
    frame.rowconfigure(i, weight=1)

for j in range(4):
    frame.columnconfigure(j, weight=1)

display.bind("<Return>", lambda event: press("="))
display.focus_set()
root.mainloop()'"""

    var result = external_call["system", c_int](
        command.as_c_string_span()
    )

    if result != 0:
        print("Calculator launch failed")
