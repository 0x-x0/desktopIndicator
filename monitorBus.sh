dbus-monitor --session type='signal',interface='com.canonical.Unity.Session' | while true
do
  read x
  if echo "$x" | grep -q Locked; then
    echo "set yourself away at $(date)"
		`curl -X GET -H "Cache-Control: no-cache" "URL"`
  elif echo "$x" | grep -q Unlocked; then
    echo "set yourself active at $(date)"
		`curl -X GET -H "Cache-Control: no-cache" "URL"`
  fi
done