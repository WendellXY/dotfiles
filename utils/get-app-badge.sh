if lsappinfo -all list | grep $1 >> /dev/null; then
  LABEL=$( lsappinfo -all list | grep $1 | egrep -o "\"StatusLabel\"=\{ \"label\"=\"?(.*?)\"? \}" | sed 's/\"StatusLabel\"={ \"label\"=\(.*\) }/\1/g')
  if [[ $LABEL =~ ^\".*\"$ ]]; then
    LABEL=$(echo $LABEL | sed 's/^"//' | sed 's/"$//')
    if [ -z "$LABEL" ]; then
      LABEL=0
    fi
  else
    LABEL=0
  fi
else
  LABEL="?"
fi

echo $LABEL