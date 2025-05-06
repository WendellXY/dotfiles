#!/usr/bin/env zsh

# Function to compress images using compress_images.sh
compress_images() {
  local help_flag=0
  local target_dir="."
  local format="png"

  # Parse arguments
  local zparseopts_output
  zparseopts -D -E -F -- h=help_flag -help=help_flag || return 1

  # Show help if requested
  if (( ${#help_flag} > 0 )); then
    echo "Usage: compress_images [-h|--help] [directory] [format]"
    echo ""
    echo "Compresses all image files of the specified format in the specified directory."
    echo "If no directory is specified, the current directory is used."
    echo "If no format is specified, png is used by default."
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "The compressed images will be placed in an 'outputs' subdirectory."
    echo "Original files that fail to compress will be copied to the outputs directory."
    echo ""
    echo "Note: Currently supports PNG compression using pngquant."
    echo "Support for additional formats will be added in future updates."
    return 0
  fi

  # Process positional arguments
  if [[ $# -ge 1 ]]; then
    target_dir="$1"
  fi

  if [[ $# -ge 2 ]]; then
    format="$2"
  fi

	local script_dir="$ZDOTDIR/functions"

  # Check if the script exists
  if [[ ! -f "$script_dir/compress_images.sh" ]]; then
    echo "Error: compress_images.sh not found in the script directory."
    echo "Make sure this function is sourced from the same directory as compress_images.sh"
    echo "or that compress_images.sh is in the current directory."
    return 1
  fi

  # Check if pngquant is installed (for PNG compression)
  if [[ "$format" == "png" ]] && ! command -v pngquant &> /dev/null; then
    echo "Error: pngquant is not installed. Please install it first."
    echo "You can install it with: brew install pngquant (on macOS with Homebrew)"
    echo "Or: sudo apt-get install pngquant (on Ubuntu/Debian)"
    return 1
  fi

  # Check if target directory exists
  if [[ ! -d "$target_dir" ]]; then
    echo "Error: Target directory '$target_dir' does not exist."
    return 1
  fi

  # Count image files of the specified format in the target directory
  local image_count=$(find "$target_dir" -maxdepth 1 -name "*.$format" | wc -l | tr -d ' ')

  if [[ $image_count -eq 0 ]]; then
    echo "No $format files found in '$target_dir'."
    return 0
  fi

  echo "Found $image_count $format files in '$target_dir'."
  echo "Starting compression..."

  # Change to the target directory and run the script
  (
    cd "$target_dir" || return 1
    "$script_dir/compress_images.sh"
  )

  echo "Compression process completed."
  echo "Check the 'outputs' directory in '$target_dir' for compressed images."
}
