#!/usr/bin/env python3
import os
import shutil
import sys
import time
import subprocess

# Enable verbose logging
DEBUG = True

def log(msg, level="INFO"):
    """Log messages with timestamps"""
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    log_msg = f"[{timestamp}] [{level}] {msg}"
    print(log_msg, file=sys.stderr)
    
    # Also log to a file for debugging
    with open("/tmp/gxupdate_helper.log", "a") as f:
        f.write(log_msg + "\n")

def main():
    log(f"gxupdate_helper started with args: {' '.join(sys.argv)}")
    
    if len(sys.argv) < 3:
        log("ERROR: Insufficient arguments", "ERROR")
        log("Usage: gxupdate_helper.py <extracted_dir> <repo_root> [launcher_to_run]")
        sys.exit(1)
        
    extracted_dir = sys.argv[1]
    repo_root = sys.argv[2]
    launcher = sys.argv[3] if len(sys.argv) > 3 else None
    
    log(f"Waiting for gxinstall to exit...")
    time.sleep(2)  # Give gxinstall time to exit

    # SAFETY: Never operate on root directory
    if repo_root in ('/', ''):
        log("ERROR: repo_root is root directory! Aborting for safety.", "ERROR")
        sys.exit(1)
        
    # Verify extracted directory exists and has files
    if not os.path.isdir(extracted_dir):
        log(f"ERROR: Extracted directory does not exist: {extracted_dir}", "ERROR")
        sys.exit(1)
        
    log(f"Source directory: {extracted_dir}")
    log(f"Target directory: {repo_root}")
    
    # List files in extracted directory for debugging
    if DEBUG:
        log("Files in extracted directory:")
        for root, dirs, files in os.walk(extracted_dir):
            for f in files:
                log(f"  {os.path.join(root, f)}")
    
    # Create repo_root if it doesn't exist
    os.makedirs(repo_root, exist_ok=True)
    
    # Remove old files (except config/logs and self) ONLY in repo_root
    log(f"Removing old files in {repo_root}")
    self_name = os.path.basename(__file__)
    protected_files = ["gxinstall_logs", self_name]
    
    for fname in os.listdir(repo_root):
        if fname in protected_files:
            log(f"Skipping {fname} (protected)")
            continue
            
        fpath = os.path.join(repo_root, fname)
        try:
            if os.path.isdir(fpath):
                log(f"Removing directory: {fpath}")
                shutil.rmtree(fpath)
            else:
                log(f"Removing file: {fpath}")
                os.remove(fpath)
        except Exception as e:
            log(f"Warning: Could not remove {fpath}: {e}", "WARNING")

    # Copy new files
    log(f"Copying new files from {extracted_dir} to {repo_root}")
    for fname in os.listdir(extracted_dir):
        src = os.path.join(extracted_dir, fname)
        dst = os.path.join(repo_root, fname)
        
        try:
            if os.path.isdir(src):
                log(f"Copying directory: {src} -> {dst}")
                # If destination exists and is a file, remove it first
                if os.path.exists(dst) and not os.path.isdir(dst):
                    log(f"Removing file (to replace with directory): {dst}")
                    os.remove(dst)
                shutil.copytree(src, dst, dirs_exist_ok=True)
            else:
                log(f"Copying file: {src} -> {dst}")
                # If destination exists and is a directory, remove it first
                if os.path.exists(dst) and os.path.isdir(dst):
                    log(f"Removing directory (to replace with file): {dst}")
                    shutil.rmtree(dst)
                shutil.copy2(src, dst)
                
                # Make scripts executable
                if fname.endswith('.py') or fname.endswith('.sh'):
                    os.chmod(dst, 0o755)
                    log(f"Made executable: {dst}")
                    
        except Exception as e:
            log(f"ERROR: Could not copy {src} to {dst}: {e}", "ERROR")
            continue

    log("Update complete!")
    
    # Clean up tempdir (parent of extracted_dir)
    tempdir = os.path.dirname(extracted_dir)
    try:
        log(f"Cleaning up temporary directory: {tempdir}")
        shutil.rmtree(tempdir)
        log("Temporary files cleaned up successfully")
    except Exception as e:
        log(f"Warning: Could not remove temporary directory {tempdir}: {e}", "WARNING")
        print(f"[gxupdate_helper] Cleaned up tempdir: {tempdir}")
    except Exception as e:
        print(f"[gxupdate_helper] Could not clean up tempdir: {e}")
    # Optionally relaunch gxinstall
    if launcher:
        if os.path.isfile(launcher) and os.access(launcher, os.X_OK):
            print(f"[gxupdate_helper] Relaunching: {launcher}")
            subprocess.Popen([launcher])
        else:
            print(f"[gxupdate_helper] Not relaunching: {launcher} does not exist or is not executable.")

if __name__ == "__main__":
    main()
