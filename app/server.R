############################
# PETITIONS MAP * server.R #
############################

shinyServer(function(input, output, session) {
    
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
     
    
})
