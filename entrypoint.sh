#!/usr/bin/env sh

# Exit immediately if a command exits with a non-zero status
set -e

# Define constants for the configuration directory and file
readonly CONFIG_DIR="/config"
readonly CONFIG_FILE="${CONFIG_DIR}/mumble-server.ini"

# If the configuration file doesn't exist, download the most recent default from GitHub
if [ ! -f "$CONFIG_FILE" ]; then
    # Use curl to download the file
    # -o saves the downloaded file to the specified path
    # The URL is the direct link to the raw mumble-server.ini file on GitHub
    curl -o "${CONFIG_FILE}" "https://raw.githubusercontent.com/mumble-voip/mumble/master/auxiliary_files/mumble-server.ini"
fi

# Print a message to the console
echo "Starting Mumble server..."

# Start the Mumble server with the configuration file
# exec replaces the current shell process with the Mumble server process
# -ini specifies the path to the configuration file
# -fg runs the server in the foreground, which is necessary for Docker
exec "/usr/bin/mumble-server" "-ini" "${CONFIG_FILE}" "-fg"
