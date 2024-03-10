function nvim
  command nvim $argv
  # Reset the cursor style on exit
  echo -ne "\e[0 q"
end
