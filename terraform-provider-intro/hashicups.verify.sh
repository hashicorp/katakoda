if curl -sL --fail localhost:19090/health -o /dev/null; then
    echo "done"
else
    echo "Not ready yet"
fi
