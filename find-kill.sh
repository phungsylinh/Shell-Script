#!/bin/bash
# Shell script function to find and kill all the zombie processes
# Find PID
find_zombies() {
    ZOMBIES=$(ps -eo pid,ppid,stat | awk '$3=="Z+" {print $1, $2}')

    if [[ -z "$ZOMBIES" ]]; then
        echo "No zombie processes found."
        return 1
    fi  
    return 0
}

# Kill ZB
kill_zombies() {
    find_zombies
    if [[ $? -ne 0 ]]; then
        echo "No zombies to kill."
        return 0
    fi

    echo "Killing parent processes of zombies..."
    echo "$ZOMBIES" | while read -r ZOMBIE_PID PARENT_PID; do
        echo "Zombie PID: $ZOMBIE_PID | Killing Parent PID: $PARENT_PID"
        #kill -SIGCHLD $PARENT_PID
        kill -9 "$PARENT_PID" 2>/dev/null && echo "Parent $PARENT_PID killed."
    done

    echo "Zombie cleanup complete!"
}

kill_zombies