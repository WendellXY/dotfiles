decode_xlog() {
  if [[ -z "$1" ]]; then
    echo "Usage: decode_xlog <input_file>"
    return 1
  fi

  local input_file="$1"
  local output_file="${input_file%.xlog}.log"

  if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file '$input_file' does not exist."
    return 1
  fi

  tencent-mars-xlog-util decode --input "$input_file" --output "$output_file"
}
