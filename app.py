import streamlit as st
from PIL import Image
import pytesseract
from paddleocr import PaddleOCR
import numpy as np

# Set up PaddleOCR
ocr = PaddleOCR(use_angle_cls=True, lang='en')  # Initialize PaddleOCR

# Streamlit UI
st.title("OCR with Streamlit")

# Upload an image
uploaded_file = st.file_uploader("Upload an Image", type=["png", "jpg", "jpeg"])

# Select OCR engine
ocr_engine = st.selectbox("Choose OCR Engine", ["Tesseract", "PaddleOCR"])

if uploaded_file is not None:
    # Display uploaded image
    image = Image.open(uploaded_file)
    st.image(image, caption="Uploaded Image", use_column_width=True)

    # Perform OCR
    if st.button("Run OCR"):
        if ocr_engine == "Tesseract":
            # Using Tesseract OCR
            extracted_text = pytesseract.image_to_string(image)
        else:
            # Using PaddleOCR
            image_np = np.array(image)
            result = ocr.ocr(image_np)
            extracted_text = "\n".join([line[1][0] for line in result[0]])

        # Display the OCR output
        st.subheader("Extracted Text")
        st.text(extracted_text)
