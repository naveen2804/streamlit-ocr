# Step 1: Use an official Python runtime as a parent image
FROM python:3.9-slim

# Step 2: Install Tesseract and necessary system libraries
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    libleptonica-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Set the working directory in the container
WORKDIR /app

# Step 4: Copy the current directory contents into the container at /app
COPY . /app

# Step 5: Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 6: Expose the port the app runs on
EXPOSE 8501

# Step 7: Define environment variable for Streamlit to run in a container
ENV PYTHONUNBUFFERED=1

# Step 8: Run the Streamlit app when the container launches
CMD ["streamlit", "run", "app.py"]
