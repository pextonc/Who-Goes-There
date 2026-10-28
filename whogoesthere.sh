#!/bin/bash
checker() {
echo
timedatectl
echo
whoami
echo
echo -e "\n=== Checking Users ==="
echo
echo -e "Root privileges: "
grep -E "([^:]+:){2}0:" /etc/passwd
echo
echo -e "Interactive shell users: "
grep -E "(/bin/bash|/bin/sh|/bin/zsh)$" /etc/passwd
echo
echo
echo -e "\n=== Listening ports ==="
echo
ss -tulpn | grep LISTEN
echo
echo
echo -e "\n=== Authorised Keys ==="
echo
if [ -f /root/.ssh/authorized_keys ]; then
        echo "/root/ Authorised Keys:"
        cat /root/.ssh/authorized_keys
else
        echo "No authorised keys"
fi
echo
echo
if [ -d ~/.ssh ]; then
    ls ~/.ssh/
fi
echo
if [ -f ~/.ssh/authorized_keys ]; then
        echo "Authorised keys:"
        cat ~/.ssh/authorized_keys
else
        echo "No authorised keys"
fi
echo
echo
echo -e "\n=== Crontab ==="
echo
grep -v -E '^#|^$' /etc/crontab /etc/cron.d/* 2>/dev/null
echo
}
checker

echo
echo -e "Save the output to file? [Y/N]"
echo
read -r answer
echo
if [[ "${answer,,}" == "y" ]]; then
        echo
        echo -e "Filename (e.g., 31-Oct): "
        echo
        read -e Filename
        Filename="${Filename%.txt}"
        checker > "$Filename.txt"
        echo "Output saved to $Filename.txt"
else
        echo "End"
fi
