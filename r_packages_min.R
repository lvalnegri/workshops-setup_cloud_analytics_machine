pkgs <- readLines(file('r_packages_min.lst'))
pkgs <- pkgs[!sapply(pkgs, require, char = TRUE)]
if(length(pkgs) > 0) install.packages(pkgs)
