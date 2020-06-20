#####################################
# PETITIONS MAP * @2020 datamaps.uk #
#####################################

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


ui <- fluidPage(

    titlePanel('UK Petitions Mapping'),

    sidebarLayout(

        sidebarPanel(

            a(id = 'tgl_pet', 'Show/Hide PETITIONS', class = 'toggle-choices'),  
            div(id = 'hdn_pet', class = 'toggle-choices-content',
                p(),
                
                # Write number of total petitions
              	h5(paste('Number of Petitions Loaded:', format(nrow(pets), big.mark = ','))),
                
                # Choose petition status
                prettyRadioButtons('rdb_pet_status', 'STATUS:', 
                    choices = c('OPEN', 'CLOSED'),
                    icon = icon('check'), status = 'primary', inline = TRUE, animation = 'jelly'
                ),                

                # Choose ordering 
                prettyRadioButtons('rdb_pet_order', 'ORDER BY:', 
                    choices = c('NUMBER OF SIGNATURES' = '1', 'ALPHABETICALLY' = '2'),
                    icon = icon('check'), status = 'primary', inline = TRUE, animation = 'jelly'
                ),                
                
                # Choose petition
                uiOutput('ui_pet'),
                
                # Write numer of signatures for selected petition
              	h6(id = 'flt_pet_sign'),
                
                # Choose to download data selected petition
                actionButton('dwn_pet', 'Download Data')
                
            ),
            
            uiOutput('flag_peek'),
            
            uiOutput('flag_go'),
    
            conditionalPanel('input.flag_go',

    		    hr(),
            
                # Choose method to bin values
    		    selectInput('cbo_cls', 'CLASS METHOD:', choices = class.methods, selected = 'quantile'),
    
                # Choose number of classes
    		    conditionalPanel("input.cbo_cls !== 'fixed'",
                    sliderInput('sld_brk', 'NUMBER OF CLASSES:', min = 3, max = 20, value = 7, step = 1, ticks = FALSE, sep = '')
    		    ),
    
                # Choose between specifying colours or predefined palette
                awesomeRadio('rdo_thm', 'THEME:', choices = c('COLOURS' = 'C', 'PALETTE' = 'P'), selected = 'P'),
    
                # PALETTE
    		    conditionalPanel("input.rdo_thm == 'P'",
                    pickerInput('cbo_pal', 'PALETTE:', choices = palette.lst, selected = pal.default[['seq']]),
                    prettySwitch('swt_pal', 'Reverse Colours', status = 'success', fill = TRUE )
    		    ),
                
                # COLOURS
    		    conditionalPanel("input.rdo_thm == 'C'",
                    colourpicker::colourInput('col_low', 'LOW VALUES:', 'yellow', returnName = FALSE),
                    colourpicker::colourInput('col_mdl', 'MIDDLE VALUES:', 'green', returnName = FALSE),
                    colourpicker::colourInput('col_hgh', 'HIGH VALUES:', 'blue', returnName = FALSE)
    		    ),
    
                # SHOW ADDITIONAL OPTIONS
                checkboxInput('flag_more', 'Additional Options?'),
                
    		    conditionalPanel("input.flag_more",
    		        
    				# Transparency (1-opacity)
    				sliderInput('sld_opt_trp', 'FILL TRANSPARENCY:', min = 0, max = 10, value = 3, step = 1, ticks = FALSE),
    		        
    				# Highlight Size (weight)
    				sliderInput('sld_opt_hsz', 'HIGHLIGHT SIZE:', min = 1, max = 20, value = 4, step = 1, ticks = FALSE),
    		        
    				# Highlight Color
    				colourpicker::colourInput('col_opt_hcl', 'HIGHLIGHT COLOUR:', 'white', showColour = 'background'),
    		        
    				# Size (weight)
    				sliderInput('sld_opt_bsz', 'BORDER SIZE:', min = 1, max = 20, value = 4, step = 1, ticks = FALSE),
    		        
    				# Color
    				colourpicker::colourInput('col_opt_bcl', 'BORDER COLOUR:', 'black', showColour = 'background'),
    		        
    				# Transparency (1-opacity)
    				sliderInput('sld_opt_btp', 'BORDER TRANSPARENCY:', min = 0, max = 10, value = 3, step = 0.5, ticks = FALSE),
    		        
                    # SHOW Uncovered Areas
                    checkboxInput('flag_nocov', 'Show also Uncovered Area Options?'),
        		    conditionalPanel("input.flag_nocov",
                        # Non Bookers: Fill Color
                        colourpicker::colourInput('col_opt_ncl', 'FILL COLOUR (non bookers):', value = 'gray20', showColour = 'background'),
                        # Non Bookers: Highlight Size
                        sliderInput('sld_opt_nhs', 'HIGHLIGHT SIZE (non bookers):', min = 1, max = 20, value = 4, step = 1, ticks = FALSE),
                        # Non Bookers: Highlight Color
                        colourpicker::colourInput('col_opt_nhc', 'HIGHLIGHT COLOUR (non bookers):', value = 'red', showColour = 'background')
        		    )
    		    ),
    
    		    hr(),
    
                # Choose to draw / save the map
                actionButton('map_draw', 'DRAW map'),
                downloadButton('map_save', 'SAVE map'), 
                br(),
                textInput('txt_dwn', 'FILENAME (max 50 characters)')
            
            ),

            width = 3
            
        ),
        
        mainPanel(
            
            conditionalPanel('input.flag_peek', DT::dataTableOutput('out_table') ),

          	h6(id = 'out_txt'),

            leafletOutput('out_map', height = '800px')
    
        )

    ),
    
    useShinyjs()

)


server <- function(input, output, session) {
    
    onclick('tgl_pet', toggle(id = 'hdn_pet', anim = TRUE) )            # venues    
    
    output$ui_pet <- renderUI({
        y <- pets[status == input$rdb_pet_status]
        y <- 
            if(input$rdb_pet_order == '1'){
                y <- y[order(-signatures)]
            } else {
                y <- y[order(tagline)]
            }
        pets.lst <- as.list(y[, code])
        names(pets.lst) <- y[, tagline]
        pickerInput('cbo_pet', 
            paste0('TAGLINE: [', format(nrow(y), big.mark = ','), ' petitions]'), 
            choices = pets.lst, options = list(`live-search` = TRUE)
        )
    })
   
    observeEvent(input$cbo_pet, {
        html('flt_pet_sign', paste('Number of Signatures', format(pets[code == input$cbo_pet, signatures], big.mark = ',')))
    })
    
    dts <- eventReactive(input$dwn_pet, {    
        y <- fromJSON(paste0('https://petition.parliament.uk/petitions/', input$cbo_pet, '.json'))
        y <- y$data$attributes$signatures_by_constituency
        y <- electors[y, on = c(Code = 'ons_code')]
        setnames(y, c('ons_code', 'electors', 'Constituency', 'MP', 'signatures'))
        setcolorder(y, c('Constituency', 'ons_code', 'MP', 'electors', 'signatures'))
        y[, permille := round(1000 * signatures / electors, 2)]
        y[order(Constituency)]
    })

    output$flag_peek <- renderUI({
        if(is.null(dts())) return()
        checkboxInput('flag_peek', 'Peek data?')
    })
    
    output$flag_go <- renderUI({
        if(is.null(dts())) return()
        checkboxInput('flag_go', 'Map downloaded petition?')
    }) 
    
    output$out_table <- DT::renderDataTable({ datatable( dts(), rownames = FALSE ) })    
    
    observeEvent(input$map_draw, {
        updateCheckboxInput(session, 'flag_peek', value = FALSE)

        output$out_map <- renderLeaflet({

            #  check with user if willing to map
            if(!input$flag_go) return()
            
            # merge with boundaries
            pbnd <- merge(bnd, dts(), by.x = 'pcon17cd', by.y = 'ons_code')

            # subset boundaries for the polygons with YES/NO Petitioners
            pbnd.no <- subset(pbnd, is.na(pbnd@data$Constituency))
            pbnd.ok <- subset(pbnd, !is.na(pbnd@data$Constituency))

            # Store the number of bins
            n_brks <- input$sld_brk

            # Determine the bin limits to use
            brks_poly <- classIntervals(pbnd.ok$permille, n = n_brks, style = input$cbo_cls, warnSmallN = FALSE)

            # Determine the colors to use
            if(input$rdo_thm == 'P'){
                br_pal <- input$cbo_pal
                col_codes <-
                    if(n_brks > brewer.pal.info[br_pal, 'maxcolors']){
                        colorRampPalette(brewer.pal(brewer.pal.info[br_pal, 'maxcolors'], br_pal))(n_brks)
                    } else {
                        brewer.pal(n_brks, br_pal)
                    }
                if(input$swt_pal) col_codes <- rev(col_codes)
            } else {
                col_codes <- colorRampPalette(c(input$col_low, input$col_mdl, input$col_hgh))(n_brks)
            }

            # build the lookup between values and colours
            pal_poly <- findColours(brks_poly, col_codes)

            # calculate centroid of the selected region
            yc <- rgeos::gCentroid(pbnd)@coords

            # build the map
            leaflet(options = leafletOptions(minZoom = 6)) %>%
                # center and zoom
                setView(yc[1], yc[2], zoom = 6) %>%
                # add maptiles
            	addProviderTiles(providers$OpenStreetMap.Mapnik, group = 'OSM Mapnik') %>%
            	addProviderTiles(providers$OpenStreetMap.BlackAndWhite, group = 'OSM B&W') %>%
            	addProviderTiles(providers$Stamen.Toner, group = 'Stamen Toner') %>%
            	addProviderTiles(providers$Stamen.TonerLite, group = 'Stamen Toner Lite') %>% 
            	addProviderTiles(providers$Hydda.Full, group = 'Hydda Full') %>%
            	addProviderTiles(providers$Hydda.Base, group = 'Hydda Base') %>% 
                # add "NON PETITIONERS" Polygon layer
                addPolygons(
                    data = pbnd.no,
                    group = 'Non Petitioners',
                    stroke = TRUE,
                    color = input$col_opt_bcl,
                    opacity = 1 - as.numeric(input$sld_opt_btp) / 10,
                    weight = as.integer(input$sld_opt_bsz) / 10,
                    smoothFactor = 0.5,
                    fill = TRUE,
                    fillColor = input$col_opt_ncl,
                    fillOpacity = 1 - as.numeric(input$sld_opt_trp) / 10,
                    highlightOptions = highlightOptions(
                        color = input$col_opt_nhc,
                        weight = input$sld_opt_nhs,
                        bringToFront = TRUE
                    ),
                    label = lapply(1:length(pbnd.no), function(x) HTML(paste0('<b>Constituency</b>: ', pbnd.no$pcon17nm[x], '<br>')) ),
                    labelOptions = lbl.options
                ) %>%
                # add "PETITIONERS" Polygon layer
                addPolygons(
                    data = pbnd.ok,
                    group = 'Petitioners',
                    stroke = TRUE,
                    color = input$col_opt_bcl,
                    opacity = 1 - as.numeric(input$sld_opt_btp) / 10,
                    weight = as.integer(input$sld_opt_bsz) / 10,
                    smoothFactor = 0.5,
                    fill = TRUE,
                    fillColor = pal_poly,
                    fillOpacity = 1 - as.numeric(input$sld_opt_trp) / 10,
                    highlightOptions = highlightOptions(
                        color = input$col_opt_hcl,
                        weight = as.integer(input$sld_opt_hsz),
                        bringToFront = TRUE
                    ),
                    label = lapply(
                        1:length(pbnd.ok),
                        function(x)
                            HTML(paste0(
                                '<b>Constituency</b>: ', pbnd.ok$pcon17nm[x], '<br>',
                                '<b>MP</b>: ', pbnd.ok$MP[x], '<br>',
                                '<b>Electors</b>: ', format(pbnd.ok$electors[x], big.mark = ','), '<br>',
                                '<b>Signatures</b>: ', format(pbnd.ok$signatures[x], big.mark = ','), '<br>',
                                '<b>per mille</b>: ', pbnd.ok$permille[x], '<br>'
                            ))
                        ),
                    labelOptions = lbl.options
                ) %>%
                # add (and hide) layers control
                addLayersControl(
            		baseGroups = c('OSM Mapnik', 'OSM B&W', 'Stamen Toner', 'Stamen Toner Lite', 'Hydda Full', 'Hydda Base'),
                	overlayGroups = c('Non Petitioners', 'Petitioners'),
                	options = layersControlOptions(collapsed = TRUE)
                ) %>%
                # add legend
                addLegend(
                    colors = col_codes,
                    labels = get_legend(pbnd.ok$permille, brks_poly$brks, n_brks),
                    position = 'bottomright',
                    opacity = 0.8
                ) %>%
                # add title
            	addControl(
                    tags$div(HTML(paste0(
                        '<p style="font-size:20px;padding:10px 5px 10px 10px;margin:0px;background-color:#ffd5c6;">',
                        pets[code == input$cbo_pet, tagline],
                        '</p>'
                    ))),
                    position = 'bottomleft'
            	) %>%
                # hide secondary objects
                hideGroup('Non Petitioners')

        })
        
    })
            
    dwn_mps <- reactive({
        
        # merge with boundaries
        pbnd <- merge(bnd, dts(), by.x = 'pcon17cd', by.y = 'ons_code')

        # subset boundaries for the polygons with YES/NO Petitioners
        pbnd.no <- subset(pbnd, is.na(pbnd@data$Constituency))
        pbnd.ok <- subset(pbnd, !is.na(pbnd@data$Constituency))

        # Store the number of bins
        n_brks <- input$sld_brk

        # Determine the bin limits to use
        brks_poly <- classIntervals(pbnd.ok$permille, n = n_brks, style = input$cbo_cls, warnSmallN = FALSE)

        # Determine the colors to use
        if(input$rdo_thm == 'P'){
            br_pal <- input$cbo_pal
            col_codes <-
                if(n_brks > brewer.pal.info[br_pal, 'maxcolors']){
                    colorRampPalette(brewer.pal(brewer.pal.info[br_pal, 'maxcolors'], br_pal))(n_brks)
                } else {
                    brewer.pal(n_brks, br_pal)
                }
            if(input$swt_pal) col_codes <- rev(col_codes)
        } else {
            col_codes <- colorRampPalette(c(input$col_low, input$col_mdl, input$col_hgh))(n_brks)
        }

        # build the lookup between values and colours
        pal_poly <- findColours(brks_poly, col_codes)

        # calculate centroid of the selected region
        yc <- rgeos::gCentroid(pbnd)@coords

        # build the map
        leaflet(options = leafletOptions(minZoom = 6)) %>%
            # center and zoom
            setView(yc[1], yc[2], zoom = 6) %>%
            # add maptiles
        	addProviderTiles(providers$OpenStreetMap.Mapnik, group = 'OSM Mapnik') %>%
        	addProviderTiles(providers$OpenStreetMap.BlackAndWhite, group = 'OSM B&W') %>%
        	addProviderTiles(providers$Stamen.Toner, group = 'Stamen Toner') %>%
        	addProviderTiles(providers$Stamen.TonerLite, group = 'Stamen Toner Lite') %>% 
        	addProviderTiles(providers$Hydda.Full, group = 'Hydda Full') %>%
        	addProviderTiles(providers$Hydda.Base, group = 'Hydda Base') %>% 
            # add "NON PETITIONERS" Polygon layer
            addPolygons(
                data = pbnd.no,
                group = 'Non Petitioners',
                stroke = TRUE,
                color = input$col_opt_bcl,
                opacity = 1 - as.numeric(input$sld_opt_btp) / 10,
                weight = as.integer(input$sld_opt_bsz) / 10,
                smoothFactor = 0.5,
                fill = TRUE,
                fillColor = input$col_opt_ncl,
                fillOpacity = 1 - as.numeric(input$sld_opt_trp) / 10,
                highlightOptions = highlightOptions(
                    color = input$col_opt_nhc,
                    weight = input$sld_opt_nhs,
                    bringToFront = TRUE
                ),
                label = lapply(1:length(pbnd.no), function(x) HTML(paste0('<b>Constituency</b>: ', pbnd.no$pcon17nm[x], '<br>')) ),
                labelOptions = lbl.options
            ) %>%
            # add "PETITIONERS" Polygon layer
            addPolygons(
                data = pbnd.ok,
                group = 'Petitioners',
                stroke = TRUE,
                color = input$col_opt_bcl,
                opacity = 1 - as.numeric(input$sld_opt_btp) / 10,
                weight = as.integer(input$sld_opt_bsz) / 10,
                smoothFactor = 0.5,
                fill = TRUE,
                fillColor = pal_poly,
                fillOpacity = 1 - as.numeric(input$sld_opt_trp) / 10,
                highlightOptions = highlightOptions(
                    color = input$col_opt_hcl,
                    weight = as.integer(input$sld_opt_hsz),
                    bringToFront = TRUE
                ),
                label = lapply(
                    1:length(pbnd.ok),
                    function(x)
                        HTML(paste0(
                            '<b>Constituency</b>: ', pbnd.ok$pcon17nm[x], '<br>',
                            '<b>MP</b>: ', pbnd.ok$MP[x], '<br>',
                            '<b>Electors</b>: ', format(pbnd.ok$electors[x], big.mark = ','), '<br>',
                            '<b>Signatures</b>: ', format(pbnd.ok$signatures[x], big.mark = ','), '<br>',
                            '<b>per mille</b>: ', pbnd.ok$permille[x], '<br>'
                        ))
                    ),
                labelOptions = lbl.options
            ) %>%
            # add (and hide) layers control
            addLayersControl(
        		baseGroups = c('OSM Mapnik', 'OSM B&W', 'Stamen Toner', 'Stamen Toner Lite', 'Hydda Full', 'Hydda Base'),
            	overlayGroups = c('Non Petitioners', 'Petitioners'),
            	options = layersControlOptions(collapsed = TRUE)
            ) %>%
            # add legend
            addLegend(
                colors = col_codes,
                labels = get_legend(pbnd.ok$permille, brks_poly$brks, n_brks),
                position = 'bottomright',
                opacity = 0.8
            ) %>%
            # add title
        	addControl(
                tags$div(HTML(paste0(
                    '<p style="font-size:20px;padding:10px 5px 10px 10px;margin:0px;background-color:#ffd5c6;">',
                    pets[code == input$cbo_pet, tagline],
                    '</p>'
                ))),
                position = 'bottomleft'
        	) %>%
            # hide secondary objects
            hideGroup('Non Petitioners')

    })
    
    observe({
        updateTextInput(session, 'txt_dwn', 
            value = filename.clean(paste( input$cbo_pet, format(Sys.Date(), '%Y%m%d'), sep = '_'))
        )
    })
    
    output$map_save <- downloadHandler(
        filename <- function(){ paste0(filename.clean(input$txt_dwn), '.html' ) },
        content <- function(file){ saveWidget(dwn_mps(), file) }
    )
     
    
}


shinyApp(ui, server)
