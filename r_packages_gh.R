pkgs <- readLines(file('r_packages_gh.lst'))
pkgs <- pkgs[!unname(sapply(sapply(strsplit(pkgs, '/'), '[', 2), require, char = TRUE))]
devtools::install_github(pkgs, dep = FALSE, force = TRUE, auth_token = 'insert-GitHub-token-here')
