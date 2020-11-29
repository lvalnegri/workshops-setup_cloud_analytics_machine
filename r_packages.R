# remember to first cd into the subfolder containing the list of packages to install (~/scripts/r_packages/)

# if you're in need to uninstall all (non *core*) libraries
# y <- as.data.frame(installed.packages())
# y <- as.character(unique(y[is.na(y$Priority), 'Package']))
# remove.packages(y)

# install packages from Bioconductor which are dependencies for subsequent CRAN packages
if(!require('BiocManager')) {
	install.packages('BiocManager')
    BiocManager::install(version = "3.12") 
	BiocManager::install('graph')
	BiocManager::install('S4Vectors')
}

# install CRAN packages not currently installed
pkgs <- readLines(file('r_packages_all.lst'))
pkgs.not <- pkgs[!sapply(pkgs, require, char = TRUE)]
if(length(pkgs.not) > 0) install.packages(pkgs.not)
lapply(pkgs, require, char = TRUE)

# summary
y <- data.frame(installed.packages())
message('Number of packages requested: ', length(pkgs))
message('Number of NEW packages installed: ', length(pkgs.not))
message('Number of packages installed: ', nrow(y[is.na(y$Priority),]))
message('Number of dependencies installed: ', nrow(y[is.na(y$Priority),]) - length(pkgs))
