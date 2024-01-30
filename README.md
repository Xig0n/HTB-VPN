# HTB VPN
![Xig0n](https://img.shields.io/badge/Powered%20by-Xig0n-D04848?style=for-the-badge&logo=cyberdefenders&logoColor=D04848) ![Bash](https://img.shields.io/badge/Bash-Scripting-blue?style=for-the-badge&logo=gnubash&logoColor=ffffff)
HTB-VPN is a tool to manage your vpn conexion to htb easly and conveniently
![HTB-VPN-LOGO](./img/logo-htb-vpn.png)

## 👉 Instalation:
```bash
git clone https://github.com/Xig0n/HTB-VPN
cd HTB-VPN
chmod 754 htbvpn.sh
./htbvpn.sh
```

> NOTE: It's necessary to add the var paths to the openvpn files downloaded in Hack The Box .2

```bash
## GLOBBAL VARIABLES
declare -r vpn_sp=""   # Starting-Point PATH 
declare -r vpn_ma=""   # Machines PATH
```

## 🤷‍♂️ How does it work?:
Once the script is executed as root it provides us with the help panel
![HTB-VPN Help Menu](./img/help_menu.png)
    -m -> Allows to start the machine vpn (The most used)
    -p -> Alow to start the starting-point vpn (For beginners in htb)
    -k -> Kill all openvpn process
    -h -> Display the help menu and exit

## 🧑‍💻 EXAMPLES
![HTB-VPN example](./img/start_starting_point.png)

- Bash File Hash SHA256: fced9a86b71e397736ba9ace1bd5d55f28defe0fb300bf233c846e26b6c1e08d   
- Bash File Hash SHA1 : e9677c9a4a05bba753ba6c1998c4416ecaf27029
- Bash   File Hash MD5: 3011930caeeaa360075f5d684da633c9
