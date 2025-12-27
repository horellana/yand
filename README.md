# Yet Another Nice Daemon (yand)

A lightweight daemon written in GNU Guile Scheme that automatically adjusts the "nice" levels (scheduling priority) of running processes based on predefined rules.

## Features

- **Process Monitoring**: Continuously scans running processes.
- **Rule Matching**: Matches processes by command name and arguments.
- **Priority Adjustment**: Automatically applies `nice` values to matched processes.

## Requirements

- [GNU Guile](https://www.gnu.org/software/guile/)

## Usage

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd yet-another-nice-daemon
   ```

2. **Run the daemon:**
   
   Since changing nice values (especially lowering them to increase priority) often requires root privileges, you may need to run this as root.

   ```bash
   sudo guile -L . yand.scm
   ```

   The daemon runs in a loop, checking processes every 5 seconds.

## Configuration

Currently, rules are defined directly in `yand.scm` via the `my-rules` list.

Example:
```scheme
(define my-rules
  (list 
    ;; Set 'guile' processes to nice level -1
    (make-rule "guile" '() -1)
    
    ;; Set 'python' processes running 'server.py' to nice level -5
    ;; This matches if "server.py" appears in the argument list.
    (make-rule "python" '("server.py") -5)))
```

## Development

To run the test suite:

```bash
guile -L . tests/rules.scm
guile -L . tests/system.scm
```

## Project Structure

- `yand.scm`: Main application entry point.
- `modules/yand/`: Core modules.
  - `system.scm`: System interaction (procfs parsing).
  - `rules.scm`: Rule logic and matching.
- `tests/`: Unit tests.
