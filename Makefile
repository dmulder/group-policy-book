all: website pdf

RFILES=01.1-manage.Rmd 04-scripts.Rmd 08-sudoers.Rmd 12-firefox.Rmd 16-firewalld.Rmd 20-admx.Rmd 01-intro.Rmd 05-startup-scripts.Rmd 09-msgs.Rmd 13-chrome.Rmd 17-cse.Rmd index.Rmd 02-smb-conf.Rmd 06-files.Rmd 10-pam-access.Rmd 14-gnome.Rmd 18-sse.Rmd 03-sec.Rmd 07-symlink.Rmd 11-cert-auto-enroll.Rmd 15-openssh.Rmd 19-regpol.Rmd

pdf: $(RFILES)
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::pdf_book")'
	mv _book/_main.pdf group-policy-book.pdf
	evince group-policy-book.pdf

website: $(RFILES)
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'
	google-chrome _book/index.html
