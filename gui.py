import tkinter as tk
from tkinter import messagebox
import subprocess

def schedule_job():
    # Get input values
    time = entry_time.get()
    endpoint = entry_endpoint.get()
    query = entry_query.get()

    # Validate inputs
    if not time or not endpoint or not query:
        messagebox.showerror("Error", "All fields are required!")
        return

    # Validate time format (HH:MM)
    try:
        hour, minute = map(int, time.split(':'))
        if hour < 0 or hour > 23 or minute < 0 or minute > 59:
            raise ValueError
    except ValueError:
        messagebox.showerror("Error", "Invalid time format. Use 'HH:MM' (e.g., 08:30).")
        return

    # Call the shell script
    try:
        subprocess.run(
            ["./task.sh", time, endpoint, query],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        messagebox.showinfo("Success", "Cron job scheduled successfully!")
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Error", f"Failed to schedule job:\n{e.stderr.decode()}")

# Create the main window
root = tk.Tk()
root.title("Schedule GraphQL Query")

# Set window size and make it non-resizable
root.geometry("400x250")
root.resizable(False, False)

# Add input fields and labels
tk.Label(root, text="Time (HH:MM):", anchor="w").grid(row=0, column=0, padx=10, pady=5, sticky="w")
entry_time = tk.Entry(root)
entry_time.grid(row=0, column=1, padx=10, pady=5, sticky="ew")

tk.Label(root, text="Endpoint:", anchor="w").grid(row=1, column=0, padx=10, pady=5, sticky="w")
entry_endpoint = tk.Entry(root)
entry_endpoint.grid(row=1, column=1, padx=10, pady=5, sticky="ew")

tk.Label(root, text="Query:", anchor="w").grid(row=2, column=0, padx=10, pady=5, sticky="w")
entry_query = tk.Entry(root)
entry_query.grid(row=2, column=1, padx=10, pady=5, sticky="ew")

# Add a button to schedule the job
tk.Button(root, text="Schedule Job", command=schedule_job).grid(row=3, column=0, columnspan=2, pady=10)

# Add a status label
status_label = tk.Label(root, text="", fg="green")
status_label.grid(row=4, column=0, columnspan=2, pady=10)

# Run the application
root.mainloop()