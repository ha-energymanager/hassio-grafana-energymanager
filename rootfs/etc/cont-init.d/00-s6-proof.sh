#!/command/with-contenv sh
echo "=== S6 DIAG: BEGIN ==="
echo -n "PID 1 cmd: " ; ps -o pid,comm= -p 1 || true
echo -n "PID 1 exe: " ; readlink /proc/1/exe || true
echo -n "Has /init: " ; if [ -x /init ]; then echo "yes"; else echo "no"; fi
echo -n "with-contenv paths: " ; ls -1 /command/with-contenv /usr/bin/with-contenv 2>/dev/null || true
echo "=== S6 DIAG: END ==="
