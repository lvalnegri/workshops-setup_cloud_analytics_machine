# remember to first cd into the subfolder [~/scripts/r_packages/]
ght <- '' # insert-your-github-token-here
if(!require('remotes')) install.packages('remotes')
pkgs <- readLines(file('r_packages_gh.lst'))
pkgs <- pkgs[!unname(sapply(sapply(strsplit(pkgs, '/'), '[', 2), require, char = TRUE))]
remotes::install_github(pkgs, dep = FALSE, auth_token = ifelse(ght == '', NA, ght))
