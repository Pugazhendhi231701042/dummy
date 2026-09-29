Absolutely machi. Since your **Model Lab pattern has 6 experiments**, prepare these six in this exact record/exam format:

1. Crypto 101 – TryHackMe
2. Snort IDS/IPS – TryHackMe
3. Privilege Escalation – TryHackMe
4. John the Ripper
5. IPTables
6. Aircrack-ng

I’ll keep the procedures **short and practical**, with the commands you actually need.

> **Important:** TryHackMe rooms can change their exact commands/tasks. For those three, I’ll give the standard lab workflow and distinguish commands that depend on the assigned room.

---

# 1. ENCRYPTION — CRYPTO 101

## Aim

To study and perform basic cryptographic techniques such as encryption, decryption, hashing, and encoding using the Crypto 101 TryHackMe platform.

## Procedure

### Step 1 — Start the TryHackMe machine

Open the assigned **Crypto 101** room in TryHackMe and start the machine.

Use the provided **AttackBox** or connect through the assigned VPN.

### Step 2 — Connect to the target

If the room provides an IP:

```bash
ping <TARGET_IP>
```

Example:

```bash
ping 10.10.10.10
```

### Step 3 — Scan the target

```bash
nmap <TARGET_IP>
```

This identifies open ports and services.

### Step 4 — Perform the assigned cryptography tasks

Crypto 101 commonly introduces concepts such as:

```text
Encoding
Encryption
Hashing
Caesar cipher
ROT13
Base64
```

For Base64 decoding:

```bash
echo "SGVsbG8=" | base64 -d
```

Output:

```text
Hello
```

For ROT13:

```bash
echo "uryyb" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Output:

```text
hello
```

### Step 5 — Complete the room questions

Use the obtained values/flags to answer the TryHackMe questions.

## Expected Output / Result

The assigned cryptographic challenges are successfully solved and the required flags/answers are obtained.

### Viva

**What is encryption?**

Encryption converts plaintext into ciphertext using an encryption algorithm and key.

**What is hashing?**

Hashing converts data into a fixed-length digest and is generally one-way.

---

# 2. SNORT IDS/IPS

## Aim

To configure and use Snort as an Intrusion Detection/Prevention System to detect network threats.

## Procedure

### Step 1 — Check Snort installation

```bash
snort -V
```

Expected:

```text
Snort version ...
```

### Step 2 — Find your network interface

```bash
ip a
```

Example:

```text
eth0
```

or

```text
ens33
```

### Step 3 — Test Snort configuration

```bash
sudo snort -T -c /etc/snort/snort.conf
```

`-T` = test configuration.

Expected:

```text
Snort successfully validated the configuration
```

### Step 4 — Run Snort

```bash
sudo snort -i eth0 -c /etc/snort/snort.conf -A console
```

Replace `eth0` with your actual interface.

### Step 5 — Generate traffic

From the authorized TryHackMe lab environment, generate the traffic specified by the room.

Snort monitors the traffic and checks it against its rules.

### Step 6 — Observe alerts

Snort displays alerts when traffic matches a configured detection rule.

Example:

```text
[**] [1:1000001:1] Test Alert [**]
```

## Expected Output / Result

Snort successfully monitors network traffic and generates alerts when suspicious traffic matches the configured rules.

### Viva

**What is IDS?**

Intrusion Detection System detects suspicious activity and generates alerts.

**What is IPS?**

Intrusion Prevention System can detect and actively block/prevent malicious traffic.

**What is Snort?**

Snort is an open-source network intrusion detection and prevention system.

---

# 3. PRIVILEGE ESCALATION — TRYHACKME

## Aim

To identify and exploit misconfigurations in an authorized Linux/Windows lab environment to understand privilege escalation techniques.

## Procedure

### Step 1 — Start the TryHackMe machine

Start the assigned Privilege Escalation room and obtain the target IP.

### Step 2 — Scan the target

```bash
nmap -sC -sV <TARGET_IP>
```

This identifies:

* Open ports
* Services
* Service versions

### Step 3 — Connect to the authorized target

Depending on the room, the connection may be through SSH or another service.

For SSH:

```bash
ssh <username>@<TARGET_IP>
```

### Step 4 — Identify current user

```bash
whoami
```

Example:

```text
student
```

### Step 5 — Check system information

```bash
uname -a
```

### Step 6 — Check sudo permissions

```bash
sudo -l
```

This is one of the **most important commands**.

It shows commands the current user can execute with elevated privileges.

### Step 7 — Search for SUID files

```bash
find / -perm -4000 -type f 2>/dev/null
```

SUID programs can sometimes create privilege-escalation opportunities when improperly configured.

### Step 8 — Look for interesting files

```bash
find / -writable -type f 2>/dev/null
```

### Step 9 — Verify privileges

If the room provides an authorized escalation path, use the method specified by the room.

Finally:

```bash
whoami
```

Expected elevated user may be:

```text
root
```

## Expected Output / Result

The privilege-escalation path in the authorized TryHackMe environment is identified and the required elevated-access flag is obtained.

### Viva

**What is privilege escalation?**

Obtaining higher privileges than those originally assigned to a user.

**Two types?**

```text
Vertical → normal user → administrator/root

Horizontal → one user → another user with similar privilege
```

---

# 4. JOHN THE RIPPER ⭐

## Aim

To demonstrate password hash cracking using John the Ripper.

## Procedure

### Step 1 — Check John

```bash
john --version
```

### Step 2 — Create a test hash

For a controlled lab, create a SHA-512 password hash:

```bash
openssl passwd -6 password123
```

This produces something like:

```text
$6$...$...
```

Save the generated hash:

```bash
nano hash.txt
```

Put the hash inside:

```text
$6$...$...
```

Save:

```text
Ctrl+O
Enter
Ctrl+X
```

### Step 3 — Run John

```bash
john hash.txt
```

John attempts to crack the hash using its configured password candidates.

### Step 4 — Display the cracked password

```bash
john --show hash.txt
```

Expected format:

```text
hash.txt:password123
```

## Expected Output / Result

John the Ripper successfully identifies the password corresponding to the test hash.

### Important commands

```bash
john hash.txt
```

```bash
john --show hash.txt
```

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

If `rockyou.txt` is compressed:

```bash
sudo gzip -dk /usr/share/wordlists/rockyou.txt.gz
```

Then:

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

### Viva

**What is John the Ripper?**

A password-security auditing and password-recovery tool that can test password guesses against password hashes.

**What is a hash?**

A fixed-length representation generated from input data using a hash function.

---

# 5. IPTABLES FIREWALL ⭐

## Aim

To configure firewall rules in Linux using IPTables to allow and block network traffic.

## Procedure

### Step 1 — Display current rules

```bash
sudo iptables -L -n --line-numbers
```

### Step 2 — Block an IP

Use the IP specified by your lab:

```bash
sudo iptables -A INPUT -s 192.168.1.50 -j DROP
```

### Step 3 — Block HTTP

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
```

### Step 4 — Allow SSH

```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

### Step 5 — Display rules

```bash
sudo iptables -L -n --line-numbers
```

You should see rules similar to:

```text
DROP    tcp  --  192.168.1.50
DROP    tcp  --  0.0.0.0/0  tcp dpt:80
ACCEPT  tcp  --  0.0.0.0/0  tcp dpt:22
```

### Step 6 — Delete a rule

If rule number 1 needs to be removed:

```bash
sudo iptables -D INPUT 1
```

### Step 7 — Clear rules after the experiment

```bash
sudo iptables -F
```

## Expected Output / Result

The specified IP address and port traffic are successfully blocked/allowed according to the configured IPTables rules.

### Viva

**INPUT?**

Incoming traffic.

**OUTPUT?**

Outgoing traffic.

**FORWARD?**

Traffic passing through the system.

**`-A`?**

Append/add a rule.

**`-D`?**

Delete a rule.

**`-F`?**

Flush rules.

**`DROP`?**

Discard the packet.

---

# 6. AIRCRACK-NG ⭐⭐⭐

## Aim

To perform a wireless security audit on an authorized test network and demonstrate WPA/WPA2 key recovery using Aircrack-ng.

> **Only perform this against your own/authorized lab router or the assigned practical environment.**

## Procedure

### Step 1 — Check wireless interface

```bash
iwconfig
```

Example:

```text
wlan0
```

### Step 2 — Enable monitor mode

Using the interface supplied by your lab:

```bash
sudo airmon-ng start wlan0
```

It may create:

```text
wlan0mon
```

### Step 3 — Scan nearby networks

```bash
sudo airodump-ng wlan0mon
```

You will see:

```text
BSSID              CH   ENC     ESSID
AA:BB:CC:DD:EE:FF   6   WPA2    TestNetwork
```

Record:

```text
BSSID
Channel
ESSID
```

### Step 4 — Capture packets from the authorized network

```bash
sudo airodump-ng --bssid AA:BB:CC:DD:EE:FF -c 6 -w capture wlan0mon
```

Meaning:

```text
--bssid → target access point
-c      → channel
-w      → save capture
```

The capture is saved with a name such as:

```text
capture-01.cap
```

### Step 5 — If the practical requires a handshake

A WPA/WPA2 handshake can be captured when a client connects/reconnects to the authorized access point.

Wait for the handshake indicator in the lab.

### Step 6 — Attempt key recovery using the authorized lab wordlist

```bash
aircrack-ng -w wordlist.txt -b AA:BB:CC:DD:EE:FF capture-01.cap
```

Where:

```text
-w → wordlist
-b → target BSSID
```

If the correct password exists in the wordlist, Aircrack-ng reports the recovered key.

### Step 7 — Stop monitor mode

```bash
sudo airmon-ng stop wlan0mon
```

## Expected Output / Result

The authorized wireless network is successfully audited, the WPA/WPA2 handshake is captured, and the key is recovered when the correct password is present in the supplied lab wordlist.

### Viva

**What is Aircrack-ng?**

A suite of tools for auditing Wi-Fi network security.

**What is monitor mode?**

A wireless interface mode that allows it to capture wireless frames without being limited to traffic addressed to the device.

**What is a WPA handshake?**

A series of authentication messages exchanged between a client and access point during WPA/WPA2 authentication.

---

# 🔥 FINAL 6-EXPERIMENT CHEAT SHEET

If you have very little time, memorize these:

### John

```bash
john --version
john hash.txt
john --show hash.txt
```

### IPTables

```bash
sudo iptables -L -n --line-numbers
sudo iptables -A INPUT -s IP -j DROP
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -F
```

### Aircrack

```bash
iwconfig
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon
sudo airodump-ng --bssid BSSID -c CHANNEL -w capture wlan0mon
aircrack-ng -w wordlist.txt -b BSSID capture-01.cap
sudo airmon-ng stop wlan0mon
```

### Snort

```bash
snort -V
ip a
sudo snort -T -c /etc/snort/snort.conf
sudo snort -i eth0 -c /etc/snort/snort.conf -A console
```

### Privilege Escalation

```bash
nmap -sC -sV TARGET_IP
whoami
uname -a
sudo -l
find / -perm -4000 -type f 2>/dev/null
```

### Crypto 101

```bash
nmap TARGET_IP
echo "SGVsbG8=" | base64 -d
echo "uryyb" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

**One correction to our earlier plan:** don't spend your remaining preparation time memorizing the four cipher programs unless your actual question paper/lab instructor has indicated they can be asked. Based on the model pattern you received, these **six lab experiments should be your main focus tonight**.
