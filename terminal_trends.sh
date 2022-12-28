#!/bin/bash

# Set the colors for the script
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if the .bash_history file exists
if [ -f ~/.bash_history ]; then
  # Extract the commands used in the .bash_history file
  commands=$(cat ~/.bash_history)
else
  # If the .bash_history file does not exist, print a warning message
  printf "${YELLOW}Warning: .bash_history file not found.${NC}\n"
fi

# Check if the .zsh_history file exists
if [ -f ~/.zsh_history ]; then
  # Extract the commands used in the .zsh_history file and add them to commands  
  commands="$commands $(cat ~/.zsh_history)"

  # If zsh_history file has EXTENDED_HISTORY enabled, remove the timestamp
  if [ -n "$(echo "$commands" | grep ': [0-9]*:[0-9]*;')" ]; then
    commands=$(echo "$commands" | sed 's/^: [0-9]*:[0-9]*;//')
  fi

else
  # If the .zsh_history file does not exist, print a warning message
  printf "${YELLOW}Warning: .zsh_history file not found.${NC}\n"
fi

# extract command without the flags
commands=$(echo "$commands" | sed 's/ .*//')

# remove empty lines
commands=$(echo "$commands" | sed '/^$/d')

# find length of commands
commands_length=$(echo "$commands" | wc -w)

# Store top 10 commands
top10=$(echo "$commands" | sort | uniq -c | sort -nr | head -10)

printf "${NC} You have used ${GREEN} $commands_length ${NC} commands\n"
printf "${YELLOW}Your top 10 commands are:\n"
printf "${GREEN}$top10${NC}\n"

