 #SleepTimer

**SleepTimer** is a PowerShell-based sleep timer for Windows that provides a lightweight, user-friendly way to automatically put your PC to sleep after a set time.

It features:
- A clean GUI for setting the timer in minutes  
- A Cancel button to stop the countdown  
- A system tray icon with notification  
- Easy conversion to a standalone `.exe` using `ps2exe`

---

## ⚙️ Setup Instructions (Step-by-Step)

### Step 1: Download or Create the Script

Save the following script as `SleepTimerGUI.ps1` on your computer:

> [You can find the script in this repository or copy it from the main script file]


### Step 2: Allow PowerShell to Run Scripts

PowerShell may block script execution by default. To enable script execution:

1. **Open PowerShell as Administrator**
2. Run the following command:

```powershell
Set-ExecutionPolicy RemoteSigned
```

3. Type `Y` and press Enter to confirm

This allows locally created scripts to run without needing to be digitally signed.


### Step 3: Install the Required Module (Optional for EXE)

To convert the script into an EXE, you need the `ps2exe` module.  
Open **PowerShell as Administrator** and run:

```powershell
Install-Module -Name ps2exe -Scope CurrentUser
```

Confirm any prompts.

### Step 4: Convert the Script to EXE (Optional)

If you prefer a standalone app (no console window, no need for PowerShell):

```powershell
Invoke-ps2exe -inputFile .\SleepTimerGUI.ps1 -outputFile .\SleepTimer.exe -noConsole
```

You will get `SleepTimer.exe` in the same folder.

### Step 5: Run the Sleep Timer

#### If using the `.ps1` script:
1. Open PowerShell
2. Navigate to the folder where `SleepTimerGUI.ps1` is located
3. Run the script:

```powershell
.\SleepTimerGUI.ps1
```

#### If using the `.exe` file:
- Just double-click `SleepTimer.exe`

### Step 6: Use the App

1. Enter the number of minutes before sleep
2. Click **Start**
3. The app will minimize to your system tray
4. Click **Cancel** any time to stop the countdown
5. Your PC will automatically go to sleep once the timer ends

---

## 💡 Why I Made This

I often fall asleep while using my computer — especially when watching videos or listening to music. Previously, I used a Chrome extension to close tabs after a certain time, but it was unreliable and eventually discontinued due to Chrome and its Manifest V2 BS. So, for convenience and reliability, I built my own sleep timer with PowerShell — simple and effective.

---

## ✅ Requirements

- Windows 10/11
- PowerShell 5.1 or later
- [ps2exe](https://github.com/MScholtes/PS2EXE) module (optional, for EXE conversion)

---

## 📃 License

MIT — feel free to modify or share.
