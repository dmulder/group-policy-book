#!/bin/sh

mkdir epub_work
mv group-policy-book.epub epub_work/

pushd epub_work
unzip group-policy-book.epub
rm group-policy-book.epub
for f in `find . -name *.xhtml`; do
	sed -i 's/width="70%"//g' $f
	sed -i 's/width="30%"/width="100"/g' $f
done
zip -X group-policy-book.epub mimetype
zip -rg group-policy-book.epub META-INF -x \*.DS_Store
zip -rg group-policy-book.epub EPUB -x \*.DS_Store
popd
mv epub_work/group-policy-book.epub .
rm -rf epub_work
