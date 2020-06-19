########################
# PETITIONS MAP * ui.R #
########################

shinyUI(fluidPage(

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

))
