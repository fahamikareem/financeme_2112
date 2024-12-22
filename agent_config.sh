#!/bin/bash

PROJECT_DIRECTORY=FinanceMe_2112
GIT_URL=https://github.com/fahamikareem/FinanceMe_2112.git

# Update and install necessary packages
sudo apt update
sudo apt install git -y
sudo apt install openjdk-17-jdk -y  # Corrected package name for JDK 17
sudo apt install maven -y

# Clone or pull the repository
if [ -d "$PROJECT_DIRECTORY" ]; then
    echo "Directory $PROJECT_DIRECTORY exists. Pulling latest changes."
    cd "$PROJECT_DIRECTORY" && git pull "$GIT_URL"
else
    echo "Directory $PROJECT_DIRECTORY does not exist. Cloning repository."
    git clone "$GIT_URL"
fi

