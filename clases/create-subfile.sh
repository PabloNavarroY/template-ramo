#!/usr/bin/env sh
# Create subfile, add line in main.tex with the
# correspondent include command and return a
# string with the created file.

FILE=$(date '+%m-%d').tex

if [ -f files/"$FILE" ]; then
    echo "files/$FILE"
    exit 0
fi

sed -i 's/\end{document}/\subfile{files\/'"$FILE"'}\n\\end{document}/' main.tex

cp files/template.tex files/"$FILE"

sed -i 's/FECHA/'"$(date '+%d}{%m}{%Y')"'/' "files/$FILE"

echo "files/$FILE"
