############################
# PETITIONS MAP * global.R #
############################

# load packages
pkgs <- c(
    'Cairo', 'classInt', 'colourpicker', 'data.table', 'DT', 'fontawesome', 'jsonlite', 'htmltools', 'htmlwidgets', 'leaflet', 
    'RColorBrewer', 'readxl', 'rgdal', 'rgeos', 'scales', 'shiny', 'shinyjs', 'shinyWidgets', 'tools'
)
lapply(pkgs, require, char = TRUE)

# set constants
options(bitmapType = 'cairo', shiny.usecairo = TRUE)
tmp <- tempfile()
tmp.xls <- tempfile(fileext = ".xls")
tmpdir <- 'tmp_pet'

# download petitions list
pets <- fread('https://petition.parliament.uk/petitions.csv') # fromJSON('https://petition.parliament.uk/petitions.json')
setnames(pets, c('tagline', 'code', 'status', 'signatures'))
pets <- pets[status != 'rejected']
pets[, `:=`(code = as.integer(substring(pets$code, 42)), status = factor(toupper(status)))]

# download boundaries
download.file('https://opendata.arcgis.com/datasets/5ce27b980ffb43c39b012c2ebeab92c0_2.zip', tmp)
unzip(tmp, exdir = tmpdir)
y <- list.files(tmpdir, 'shp')
bnd <- readOGR(tmpdir, sub('\\.shp$', '', y[grepl('Constituencies', y)]))

# download election data
download.file(
    'https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/elections/electoralregistration/datasets/electoralstatisticsforuk/2017unformatted/elec5dt2unformattedelectoralstatisticsuk2017.xls',
    destfile = tmp.xls,
    mode = 'wb'
)
electors <- as.data.table(read_xls(tmp.xls, sheet = 5))
electors <- electors[, c(1, 5)]

# clean
unlink(tmp)
unlink(tmp.xls)
unlink(tmpdir, recursive = TRUE)

# set shiny constants
class.methods <- c(
#    'Fixed' = 'fixed',                  # need an additional argument fixedBreaks that lists the n+1 values to be used
    'Equal Intervals' = 'equal',        # the range of the variable is divided into n part of equal space
    'Quantiles' = 'quantile',           # each class contains (more or less) the same amount of values
    'Pretty Integers' = 'pretty',       # sequence of about ‘n+1’ equally spaced ‘round’ values which cover the range of the values in ‘x’. The values are chosen so that they are 1, 2 or 5 times a power of 10.
    'Hierarchical Cluster' = 'hclust',  # Cluster with short distance
    'K-means Cluster' = 'kmeans'        # Cluster with low variance and similar size
)

palette.lst <- list(
    'SEQUENTIAL' = c( # ordinal data where (usually) low is less important and high is more important
        'Blues' = 'Blues', 'Blue-Green' = 'BuGn', 'Blue-Purple' = 'BuPu', 'Green-Blue' = 'GnBu', 'Greens' = 'Greens', 'Greys' = 'Greys',
        'Oranges' = 'Oranges', 'Orange-Red' = 'OrRd', 'Purple-Blue' = 'PuBu', 'Purple-Blue-Green' = 'PuBuGn', 'Purple-Red' = 'PuRd', 'Purples' = 'Purples',
        'Red-Purple' = 'RdPu', 'Reds' = 'Reds', 'Yellow-Green' = 'YlGn', 'Yellow-Green-Blue' = 'YlGnBu', 'Yellow-Orange-Brown' = 'YlOrBr',
        'Yellow-Orange-Red' = 'YlOrRd'
    ),
    'DIVERGING' = c(  # ordinal data where both low and high are important (i.e. deviation from some reference "average" point)
        'Brown-Blue-Green' = 'BrBG', 'Pink-Blue-Green' = 'PiYG', 'Purple-Red-Green' = 'PRGn', 'Orange-Purple' = 'PuOr', 'Red-Blue' = 'RdBu', 'Red-Grey' = 'RdGy',
        'Red-Yellow-Blue' = 'RdYlBu', 'Red-Yellow-Green' = 'RdYlGn', 'Spectral' = 'Spectral'
    ),
    'QUALITATIVE' = c(  # categorical/nominal data where there is no logical order
        'Accent' = 'Accent', 'Dark2' = 'Dark2', 'Paired' = 'Paired', 'Pastel1' = 'Pastel1', 'Pastel2' = 'Pastel2',
        'Set1' = 'Set1', 'Set2' = 'Set2', 'Set3' = 'Set3'
    )
)
pal.default <- c('col' = 'steelblue3', 'cat' = 'Dark2', 'seq' = 'YlGnBu', 'div' = 'RdBu', 'na' = 'grey62')
lbl.options <- labelOptions(
    textsize = '12px', direction = 'right', sticky = FALSE, opacity = 0.8,
    offset = c(60, -40), style = list('font-weight' = 'normal', 'padding' = '2px 6px')
)
# tiles.lst <- as.list(maptiles[, provider])
# names(tiles.lst) <- maptiles[, name]

# set shiny functions
filename.clean <- function(fn){
    fn <- gsub('[ \\.]', '-', fn)
    gsub('[^[:alnum:]_-]', '', fn)
}
build_poly_label <- function(x, y, area_name){
    HTML(paste0(
            '<b>', area_name, '</b>: ', y$name[x], '<br>',
            ifelse('PCT' %in% names(y), paste0('<b>Postal Town</b>: ', y$PCT[x], '<br>'), ''),
            ifelse('LAD' %in% names(y), paste0('<b>Local Authority</b>: ', y$LAD[x], '<br>'), ''),
            ifelse('RGN' %in% names(y), paste0('<b>Region</b>: ', y$RGN[x], '<br>'), ''),
            '<b>Penetration</b>: ', round(y$Y[x], 2), '%<br>'
    ))
}
get_poly_labels <- function(x, y){
    lapply(1:length(x), build_poly_label, x, names(which(cols_map == y)))
}
get_legend <- function(Y, brks_lim, n_brks) {
    lbl_brks <- format(round(brks_lim, 3), nsmall = 1)
    lbl_text <- sapply(1:n_brks,
        function(x)
            paste0(
                lbl_brks[x], ' ÷ ', lbl_brks[x + 1],
                ' (', length(Y[Y >= as.numeric(gsub(',', '', lbl_brks[x])) & Y < as.numeric(gsub(',', '', lbl_brks[x + 1])) ] ), ')'
            )
    )
}
