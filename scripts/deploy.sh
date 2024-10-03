#!/bin/bash

# Update package lists
echo " "
echo "Updating package lists..."
apt-get update -y

echo " "

# Install Python and pip system-wide
echo "Installing Python and pip..."
apt-get install -y python3 python3-pip

echo " "

# Install Streamlit, Evtx, and xmltodict system-wide
echo "Installing Streamlit ..."
pip install -y streamlit python-Evtx xmltodict --break-system-packages

echo " "

# Clean up unnecessary files
echo "Cleaning up..."
apt-get clean


echo " " 

#setup app 
echo "Grabbing app..."

#!/bin/bash

# Check if /opt/streamlit directory exists, if not create it
if [ ! -d "/opt/streamlit" ]; then
    echo "Creating /opt/streamlit directory..."
    mkdir -p /opt/streamlit
else
    echo "/opt/streamlit directory already exists."
fi

# Check if /opt/streamlit/evtx-json directory exists, if not create it
if [ ! -d "/opt/streamlit/evtx-json" ]; then
    echo "Creating /opt/streamlit/evtx-json directory..."
    mkdir -p /opt/streamlit/evtx-json
else
    echo "/opt/streamlit/evtx-json directory already exists."
fi

# Check if the app.py file exists in /opt/streamlit/evtx-json, if not download it
if [ ! -f "/opt/streamlit/evtx-json/app.py" ]; then
    echo "Downloading app.py to /opt/streamlit/evtx-json..."
    curl https://raw.githubusercontent.com/chrisjbawden/evtx-json/refs/heads/main/app/app.py -o /opt/streamlit/evtx-json/app.py
else
    echo "app.py already exists in /opt/streamlit/evtx-json."
fi


echo " "

echo "launching..."

echo " "

streamlit run /opt/streamlit/evtx-json/app.py
