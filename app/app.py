import streamlit as st
import json
from Evtx.Evtx import Evtx
import xmltodict
import os

# Streamlit app interface

# File uploader
uploaded_file = st.file_uploader("Choose an EVTX file", type="evtx")

# If a file is uploaded
if uploaded_file is not None:
    st.write("Processing your file...")
    
    # Save the uploaded file to a temporary path
    temp_file_path = os.path.join("/tmp", uploaded_file.name)
    
    # Write the uploaded file to the temporary path
    with open(temp_file_path, "wb") as f:
        f.write(uploaded_file.getbuffer())
    
    # Now process the EVTX file using the saved temporary path
    with Evtx(temp_file_path) as log:
        records = []
        for record in log.records():
            # Converting each record from XML to JSON format
            xml_record = record.xml()
            json_record = xmltodict.parse(xml_record)
            records.append(json_record)

        # Display the JSON output
        st.write(records)

        # Option to download JSON file
        json_output = json.dumps(records, indent=4)
        st.download_button(
            label="Download as JSON",
            data=json_output,
            file_name="converted_logs.json",
            mime="application/json",
        )
