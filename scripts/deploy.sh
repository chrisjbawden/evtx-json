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
echo "Installing Streamlit, Evtx, and xmltodict..."
pip3 install streamlit Evtx xmltodict

echo " "

# Clean up unnecessary files
echo "Cleaning up..."
apt-get clean

echo " "

# Verify installation
echo "Verifying installations..."
streamlit --version
pip3 show Evtx
pip3 show xmltodict

echo " " 

#setup app 
echo "Grabbing app..."

mkdir /opt/streamlit/evtx-json
curl https://raw.githubusercontent.com/chrisjbawden/evtx-json/refs/heads/main/app/app.py -o /opt/streamlit/evtx-json/app.py

echo " "

echo "launching..."

echo " "

streamlit run /opt/streamlit/evtx-json/app.py
