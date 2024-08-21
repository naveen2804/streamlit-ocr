FROM python:3.11

# Install pip3
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip \
    libleptonica-dev \
    tesseract-ocr \
    libtesseract-dev \
    python3-pil \
    tesseract-ocr-eng \
    tesseract-ocr-script-latn \
    poppler-utils \ 
    && apt-get clean

# Step 3: Set the working directory in the container
WORKDIR /app

# Step 4: Copy the current directory contents into the container at /app
COPY . /app

# Step 5: Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 6: Expose the port the app runs on
EXPOSE 8501

# Step 7: Define environment variable for Streamlit to run in a container
# ENV PYTHONUNBUFFERED=1

# Step 8: Run the Streamlit app when the container launches
CMD ["streamlit", "run", "app.py"]
