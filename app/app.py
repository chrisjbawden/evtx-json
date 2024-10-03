import streamlit as st
import json
import Evtx.Evtx
import xmltodict

# Streamlit app interface
st.title("EVTX to JSON Converter")

# File uploader
uploaded_file = st.file_uploader("Choose an EVTX file", type="evtx")

# If a file is uploaded
if uploaded_file is not None:
    st.write("Processing your file...")
    
    # Reading and parsing the EVTX file
    with Evtx(uploaded_file) as log:
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
