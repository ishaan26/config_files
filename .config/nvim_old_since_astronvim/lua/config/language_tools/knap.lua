local gknapsettings = {
	texoutputext = "pdf",
	textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
	textopdfviewerlaunch = "/Applications/sioyek.app/Contents/MacOS/sioyek %outputfile%",
	textopdfviewerrefresh = "kill -HUP %pid%",
	mdtopdfviewerlaunch = "/Applications/sioyek.app/Contents/MacOS/sioyek %outputfile%",
	markdowntohtmlviewerlaunch = "/Applications/Firefox.app/Contents/MacOS/firefox-bin %outputfile%",
}
vim.g.knap_settings = gknapsettings
