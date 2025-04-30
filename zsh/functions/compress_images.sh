#!/bin/bash

# Path to the directory containing the PNG files
SOURCE_DIR="."

# Create the outputs directory if it doesn't exist
mkdir -p "outputs"

# Counter for processed files
processed=0
failed=0

# Process each PNG file
for file in "$SOURCE_DIR"/*.png; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "Processing: $filename"
        
        # Run pngquant with correct syntax
        pngquant --force --quality=85 "$file" --output "outputs/$filename"
        
        if [ $? -eq 0 ]; then
            processed=$((processed + 1))
            echo "Compressed: $filename"
        else
            failed=$((failed + 1))
            echo "Error compressing: $filename"
            
            # If compression fails, copy the original file to outputs
            echo "Copying original file to outputs directory..."
            cp "$file" "outputs/$filename"
            if [ $? -eq 0 ]; then
                echo "Original file copied successfully."
                processed=$((processed + 1))
            else
                echo "Failed to copy original file."
            fi
        fi
        echo "------------------------"
    fi
done

echo "Compression complete!"
echo "Successfully compressed: $processed PNG files."
echo "Failed to compress (copied original): $failed PNG files."
echo "All images are in the 'outputs' folder."
