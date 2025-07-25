# Push_Swap Tester

A comprehensive Bash script designed to rigorously test the `push_swap` project from 42 School.

This tester automates the process of generating numbers, running `push_swap`, checking the validity of the output with `checker`, evaluating the number of instructions, and checking for memory leaks with Valgrind.

  
  ![](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnloZHFiYmNvOTIxcjI1NzQ5YmMxcGtiaXA3Y2N0NDIwcjZya21keiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gw3IWyGkC0rsazTi/giphy.gif)

---

## 📋 Features

This tester performs three critical checks in a single run:

1.  **✅ Instruction Count Test:** Checks if the number of operations generated by your `push_swap` is within the limits required for a full score.
2.  **✅ Solution Validity Test:** Uses the `checker` program to verify that the generated instructions correctly sort the initial stack of numbers.
3.  **✅ Memory Leak Test:** Runs `push_swap` through `Valgrind` to ensure there are no memory leaks or memory-related errors.

It also provides detailed output files for deeper analysis.

---

## 🛠️ Requirements

- A working `push_swap` executable in the root directory.
- The `checker_linux` executable provided by the subject in the root directory.
- `Valgrind` installed on your system.
- A **Linux** environment (as the script and the provided `checker` are intended for it).

---

## 🚀 How to Use

1.  **Clone the repository or download the script.** Make sure the tester script (`push_swap_tester.sh`) is in the root of your `push_swap` project folder.

2.  **Make the script executable:**
    ```bash
    chmod +x push_swap_tester.sh
    ```

3.  **Make the checker executable:**
    ```bash
    chmod +x checker_linux
    ```

4.  **Configure the test:** Open the script in a text editor and change the value of the `n` variable at the top to set the amount of numbers you want to test with.
    ```bash
    # Amount of numbers to be generated
    n=500
    ```
    The script has built-in instruction checks for `n=5`, `n=100`, and `n=500`.

5.  **Run the tester:**
    ```bash
    ./push_swap_tester.sh
    ```

---

## 📊 Interpreting the Output

The script will print a summary to your terminal after it finishes.

### Example Output

```
pa
pb
rra
...
For 500 numbers, number of lines: 4897 ✅
Checker outcome: OK ✅
Valgrind: OK ✅
```

Let's break down what each line means:

- **The instruction list:** The first thing you see is the full list of `pa`, `pb`, `sa`, etc., generated by your `push_swap`.
- **Line Test:** `For 500 numbers, number of lines: 4897 ✅`
  - This tells you how many instructions your program generated for the given number of integers.
  - A ✅ means the count is within the required limits for a full score.
  - A ❌ means the count is too high.
- **Checker Test:** `Checker outcome: OK ✅`
  - This shows the result from piping your instructions into the `checker`.
  - `OK ✅`: Your instructions correctly sorted the stack.
  - `KO ❌`: Your instructions failed to sort the stack.
- **Valgrind Test:** `Valgrind: OK ✅`
  - `OK ✅`: No memory leaks or errors were found.
  - `❌ Issues found!`: The script detected errors. More details will be available in the `valgrind_log.txt` file.

### Generated Files

After running, the script creates a few files for you to inspect the results more closely:

- **`moves.txt`**: Contains the full list of instructions that `push_swap` generated.
- **`numbers_used.txt`**: A log of the number sets that were tested. Each line is prefixed with a ✅ or ❌ indicating if the instruction count test passed for that set. This is incredibly useful for finding specific cases where your algorithm might be inefficient.
- **`valgrind_log.txt`**: The complete, detailed output from the Valgrind run. If the summary shows Valgrind issues, check this file to find the exact source of the memory errors.

---

## 💡 How it Works

The script performs the following steps:

1.  **Number Generation:** It generates `n` unique numbers. It randomly chooses between two methods:
    - Generating a sequence of shuffled positive integers (`1` to `n`).
    - Generating a sequence of random integers within the full `INT_MIN` to `INT_MAX` range to test for edge cases.
2.  **Execution:** It runs your `./push_swap` with the generated numbers and captures the instruction list.
3.  **Analysis:** It then performs the three tests (line count, checker, Valgrind) in parallel on the captured output.
4.  **Reporting:** Finally, it prints the concise summary to the console and saves the detailed logs to text files for debugging.

Happy testing!
