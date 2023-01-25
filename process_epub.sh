#!/bin/sh

mkdir epub_work
mv $1 epub_work/

pushd epub_work
unzip $1
rm $1
for f in `find . -name *.xhtml`; do
	sed -i 's/width="70%"//g' $f
	sed -i 's/width="30%"/width="100"/g' $f
done
../fix_unidentified_fragments.py
zip -X $1 mimetype
zip -rg $1 META-INF -x \*.DS_Store
zip -rg $1 EPUB -x \*.DS_Store
popd
mv epub_work/$1 .
rm -rf epub_work
