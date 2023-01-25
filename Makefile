all: website epub pdf

RFILES=index.Rmd 01.1-manage.Rmd 01-intro.Rmd 02-smb-conf.Rmd 03-sec.Rmd 04-scripts.Rmd 05-startup-scripts.Rmd 06-files.Rmd 07-symlink.Rmd 08-sudoers.Rmd 09-msgs.Rmd 10-pam-access.Rmd 11-cert-auto-enroll.Rmd 12-firefox.Rmd 13-chrome.Rmd 14-gnome.Rmd 15-openssh.Rmd 16-firewalld.Rmd 17-ext.Rmd 19-regpol.Rmd 20-admx.Rmd 21-policy-application.Rmd 22-index.Rmd

pdf: $(RFILES)
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::pdf_book")'
	mv _book/_main.pdf group-policy-book.pdf
	evince group-policy-book.pdf

website: $(RFILES)
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'
	google-chrome _book/index.html

epub: $(RFILES)
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::epub_book")'
	mv _book/_main.epub group-policy-book.epub
	./process_epub.sh group-policy-book.epub
	epubcheck group-policy-book.epub

clean:
	rm -rf group-policy-book.pdf _book/* group-policy-book.epub
