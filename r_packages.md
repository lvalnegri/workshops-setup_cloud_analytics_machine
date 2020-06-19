# Notable *R* Packages for Data Science

**Author**: [Luca Valnegri](https://www.linkedin.com/in/lucavalnegri/)   
**Last Updated**: 30-Oct-2019

---
  * [Data Sourcing](#sourcing)
    + [Data I/O](#IO)
    + [Database Drivers](#databases)
  * [Data Processing](#processing)
    + [Data Manipulation (atomics)](#manipulation)
    + [Data Wrangling (structures)](#wrangling)
    + [Data Imputation (missing data)](#imputation)
    + [Anomaly Detection (outliers, extreme values)](#outliers)
    + [Data Validation](#data-validation)
  * [Data Exploration](#exploration)
    + [Data Summaries](#summaries)
    + [Data Display](#display)
    + [Data Visualization](#visualization)
      - [*htmlwidgets*, JS Wrappers](#htmlwidgets)
      - [*ggplot* Extensions](#ggplot-extensions)
      - [*ggplot* Helpers](#ggplot-helpers)
      - [*ggplot* Themes](#ggplot-themes)
      - [Palettes, Colours](#palettes)
      - [Icons, Fonts](#icons)
  * [Features Engineering](#features-eng)
    + [Features Selection](#features-sel)
    + [Dimensionality Reduction](#features-dim)
  * [Data Modeling](#modeling)
    + [Classification](#classification) 
      - [Fraud Detection](#fraud-detection) 
      - [Customer Retention](#customer-retention) 
      - [Image Recognition](#image-recognition) 
    + [Regression, Linear Models](#regression) 
    + [Clustering](#clustering) 
      - [Recommender Systems](#recommender) 
      - [Customer Segmentation](#segmentation) 
    + [Deep Learning](#deep-learning) 
    + [Time Series, Forecasting](#time-series)
    + [Survival Analysis](#survival)
    + [Network Analysis](#network)
    + [Spatial Data](#spatial)
      - [Generics, Tools, Utilities](#spatial-tools)
      - [Mapping](#mapping)
      - [Analysis, Geocomputation](#geocomputation)
      - [Localization](#localization)
    + [Model Validation, ROC Analysis](#model-validation)
  * [Data Presentation](#presentation)
    + [*shiny* Extensions](#shiny-ext)
      - [Shiny Apps Examples](#shiny-apps)
  * [Applications](#applications)
    + [Matrix Calculus](#matrix)
    + [Probability, Simulation, Computational Statistics](#probability)
    + [Quantitative Analyis, Applied Finance](#finance)
    + [Digital Analytics](#digital)
    + [Meta-Analyis](#meta)
    + [*BioConductor*](#bio)
    + [Other Applications](#other-applications)
  * [Programming Tools](#programming)
    + [High Performance](#performance)
    + [Big Data](#big-data)
    + [Cloud Computing](#cloud)
    + [Web, Internet](#internet)
    + [APIs](#apis)
    + [Package Development](#packages)
    + [Version Control](#git)
    + [Utilities](#utilities)
  * [Datasets](#datasets)
  * [Resources](#resources)
---

  <a name="sourcing"/>

## Data Sourcing

  <a name="IO"/>

### Data I/O
  - [fst](http://github.com/fstpackage/fst) - A new and fast way to store dataframes/data.tables to disk, even with data compression.
  - [feather](https://github.com/wesm/feather) - Store dataframes to disk lightning fast and shareable between R and Python.
  - [readr](https://github.com/tidyverse/readr) - Provide a fastest way to read rectangular data than core *R* functions, in case of huge files
  - [rio](https://github.com/leeper/rio) - The aim of rio is to make data file I/O in *R* as easy as possible by implementing just a few simple functions: `import`, `export` and `convert`.
  - [openxlsx](http://github.com/awalker89/openxlsx) - Provide an interface to writing, styling and editing Excel files
  - [readxl](https://github.com/tidyverse/readxl) - Easiest way to reading Excel files, without using JAVA dependencies
  - [XLConnect](https://github.com/miraisolutions/xlconnect) - Comprehensive and cross-platform package for manipulating Excel files (requires Java)  
  - [xml2](http://github.com/r-lib/xml2) - R binding to the C parser [libxml2](http://xmlsoft.org/), making it easy to work with HTML and XML documents
  - [jsonlite](https://github.com/jeroen/jsonlite) - A Robust, High Performance JSON Parser and Generator
  - [downloader](http://github.com/wch/downloader) - Wrapper for base R download function that eases dealing with files over https
  - [googlesheets](http://github.com/jennybc/googlesheets) - Easily read data into R from Google Sheets
  - [rdrop2](https://github.com/karthik/rdrop2) - R interface for Dropbox
  - [foreign](https://cran.r-project.org/package=foreign) - Provides I/O functionalities towards read other statistical software
  - [haven](https://github.com/tidyverse/haven) - Allow reading and writing SPSS, SAS and Stata files. Part of the *tidyverse*.

  <a name="databases"/>

### Database Drivers
  - [DBI](https://github.com/r-dbi/DBI) - Provides a common interface between *R* and any database management systems (**DBMS**). 
  - [pool](https://github.com/rstudio/pool) - Object pooling
  - [odbc](https://github.com/rstats-db/odbc) - Provide a generic connector to DBMS without an *R* standalone driver, like Microsoft [SQL Server]() relational database.
  - [RJDBC](https://github.com/s-u/RJDBC) - Allows R to connect to any DBMS that has a [JDBC]() driver, like [Hive](https://hive.apache.org/) - Allows interactive SQL queries over massive amounts of data of all shapes, sizes and formats stored in [Hadoop]() clusters, using [HiveQL](), a SQL-like language.
  - [sqldf](http://github.com/ggrothendieck/sqldf) - Run *SQL* queries on any data frame with [sqldf syntax](http://www.sqlite.org/lang.html)
  - [RSQLite](https://github.com/rstats-db/RSQLite) - Embeds the [SQLite](https://www.sqlite.org/index.html) single-file database engine in *R*
  - [RMySQL](https://github.com/rstats-db/RMySQL) - R interface and driver to [MySQL](https://www.mysql.com/) relational databases
  - [RPostgres](https://github.com/r-dbi/RPostgres) - Fully `DBI`-compliant `Rcpp`-backed interface to [PostgreSQL](https://www.postgresql.org/) relational databases. Notice that dealing with the [PostGIS](https://postgis.net/) extensions to spatial objects see the `sf` package. 
  - [mongolite](https://github.com/jeroen/mongolite) - Connector to a [MongoDB](https://github.com/mongodb/mongo) [document database](), that supports storing information in JSON format.
  - [MonetDBLite](https://github.com/hannesmuehleisen/MonetDBLite-R) - A fully embedded version of the [columnar storage]() [MonetDB](https://www.monetdb.org/Home) 
  - [RNeo4j](http://github.com/nicolewhite/RNeo4j) - Allows I/O operations with the [Neo4j](https://neo4j.com/) [graph database]() platform.
  - [Redis](https://github.com/richfitz/redux) - [Redis]() is an in-memory [key-value lookups database](), which makes it lightning fast.
  - [Cassandra]() - [Cassandra]() is a key-value, column-oriented distributed database, that provides its own SQL-like language [CQL]().
  - [HBase]() - [HBase]() qualifies as a [wide column storage solution](), that drives the well-known [Hadoop]() product. It makes perfect sense to use when you want serious data processing capabilities and the use of [Map Reduce]()


  <a name="processing"/>

## Data Processing

  <a name="manipulation"/>

### Data Manipulation (acting on atomics)
  - [stringr](https://github.com/tidyverse/stringr) - Easy to learn tools for text manipulation, regular expressions included. Most functions are prefixed with `str_` so they are very easy to remember.
  - [glue](https://github.com/tidyverse/glue) - Potentially, the best replacement for the *paste* function
  - [lubridate](https://github.com/tidyverse/lubridate) - Tools that make working with dates and times easier.
  - [hms](https://github.com/tidyverse/hms) - Tools for working with date and time
  - [forcats](https://github.com/tidyverse/forcats) - Tools for working with factors (categorical variables)
  - [qdapRegex](http://) - Collection of reg-expr tools built in the context of discourse analysis (see qdap package), though often useful outside of it

  <a name="wrangling"/>

### Data Wrangling (acting on structures)
  - [data.table](https://github.com/Rdatatable/data.table) :heart_eyes: - An alternative way to organize data sets for very, very fast operations. Useful when dealing with large data sets.
  - [dplyr](http://github.com/tidyverse/dplyr) - Essential SQL-like shortcuts for subsetting, summarizing, rearranging, and joining together data sets. An easy to use substitute for *split-apply-combine* functionality in Base R: 
    - *split* a data structure into groups 
    - *apply* a function on each group
    - *combine* and return the results in a possibly different data structure
  - [tidyr](http://github.com/hadley/tidyr) - Provides functionality for changing the layout of any dataframe, like *gather* and *spread*, to convert datasets in a *tidy* format. Upscale version of the now superseeded [reshape2](http://github.com/hadley/reshape)
  - [gdata](https://cran.r-project.org/package=gdata/) - Provides various tools for data I/O, manipulation and wrangling
  - [purrr](http://github.com/hadley/purrr) - Provides lots of functional programming tools, including important features from other languages
  - [magrittr](https://github.com/tidyverse/magrittr) - Provides a set of operators which make the code more readable
  - [wrapr](https://github.com/WinVector/wrapr) - Provedes functionalities for writing and debugging R code.
  - [sjmisc](http://www.strengejacke.de/sjmisc/) - Collection of miscellaneous utility functions, designed to work together seamlessly with packages from the tidyverse, and sjPlot.
  - [plyr](https://github.com/hadley/plyr) - Even if mostly superseeded by *dplyr*, it is still great when dealing with lists
  - [scales](https://github.com/hadley/scales) - Provide functions to implement scales in a way that is graphics system agnostic
  - [xda](http://github.com/ujjwalkarn/xda) - Contains several tools to perform initial exploratory analysis on any input dataset.
  - [funModeling](http://github.com/pablo14/funModeling) - Contains several tools to perform data cleaning, importance variable analysis and model perfomance
  - [gmodels](https://cran.r-project.org/package=gmodels/) - Various functionalities for model fitting
  - [questionr](https://github.com/juba/questionr) - Provides functions to make surveys processing easier
  - [janitor](https://github.com/sfirke/janitor) - Simple tools for data cleaning
  - [rowr](https://cran.r-project.org/package=rowr/) - Allows the manipulation of R objects as if they were organized rows in a way that is familiar to people used to working with databases.
  - [data.tree](https://github.com/gluc/data.tree) - Provides functionalities to manage hierarchical data and tree structures

  <a name="data-validation"/>

### Data Validation
  - [validate](https://github.com/data-cleaning/validate) - Provides functionalities to firstly define data validation rules independent of the code or dataset, then confront a dataset, or various versions thereof, with the rules.
  - [dataCompareR](https://github.com/capitalone/dataCompareR) - Allows users to compare two datasets and view a report on the similarities and differences.

  <a name="imputation"/>

### Data Imputation (Missing Values)
  - [mice](http://) - 
  - [Amelia](http://) - 
  - [missForest](http://) - 
  - [mi](http://) - 
  - [VIM](http://) - 
  - [rrcovNA](http://) - 
  - [mvnmle](http://) - 
  - [missMDA](http://) - 
  - [norm](http://) - 
  - [softimpute](http://) - 
  - [mvoutlier](https://cran.r-project.org/package=mvoutlier) - 

  <a name="outliers"/>

### Anomaly Detection (Outliers)



  <a name="exploration"/>

## Data Exploration

  <a name="summaries"/>

### Data Summaries
  - [classInt](https://github.com/r-spatial/classInt/) - Commonly used methods for choosing univariate class intervals, mainly for data visualization purposes
  - [matrixStats](https://cran.r-project.org/package=matrixStats/) - High-performing functions operating on rows and columns of matrices, optimized per data type and submatrices
  - [skimr](https://github.com/ropenscilabs/skimr) - A frictionless, pipeable approach to dealing with summary statistics
  - [Hmisc](https://github.com/harrelfe/Hmisc) - Miscellaneous functions for various tasks. Highlights are: `describe`, a more robust summary function; `Cs`, creates a vector of strings from unquoted strings wrapped in standard `c`.

  <a name="display"/>

### Data Display
  - [DT](https://github.com/rstudio/DT) :heart_eyes: - R interface to the [DataTables](https://datatables.net/) JS library
  - [formattable](https://github.com/renkun-ken/formattable) - 
  - [rhandsontable](https://github.com/jrowen/rhandsontable) - R interface to the [handsontable](http://http//handsontable.com/) JS library
  - [table1](https://github.com/benjaminrich/table1) - Allows to easily generate LaTeX-style tables of descriptive statistics with HTML output
  - [ztable](https://github.com/cardiomoon/ztable) - 
  - [R3port](https://github.com/RichardHooijmaijers/R3port) - 
  - [highlightHTML](https://github.com/lebebr01/highlightHTML) - 
  - [huxtable](https://github.com/hughjonesd/huxtable) - Provides functionalities to create modern LaTeX and HTML tables
  - [flextable](https://github.com/davidgohel/flextable) - Provides a framework to easily create tables for reporting with *RMarkdown*/*Shiny* or *Word*/*Powerpoint* 
  - [kableExtra](https://github.com/haozhu233/kableExtra) - Add functionalities to `kable` package to construct more complex tables. It can also be added to `formattable`.
  - [simpletable](https://github.com/jalapic/simpletable) - Allows making simple tables in RMarkdown (Not to be mistaken with [SimpleTable](https://cran.rstudio.com/web/packages/SimpleTable/))
  - [pixiedust](https://github.com/nutterb/pixiedust) - Provide functionalities for building customized tables in R output
  - [sparktable](https://github.com/alexkowa/sparkTable) - Allows to include sparklines and graphical tables for TeX and HTML formats
  - [rpivotTable](http://github.com/smartinsightsfromdata/rpivotTable) - 
  - [D3TableFilter](https://github.com/ThomasSiegmund/D3TableFilter) - R interface to the [TableFilter](http://koalyptus.github.io/TableFilter/) JS library, 
  - [listviewer](https://github.com/timelyportfolio/listviewer) - R interface to [jsoneditor](https://github.com/josdejong/jsoneditor), lets interactively view and maybe modify lists. 
  - [xtable](https://cran.r-project.org/package=xtable) - Allows to build LaTeX-like table with HTML output.
  - [microplot](https://cran.r-project.org/package=microplot/) - Provides functionalities to insert *R* graphics files as microplots  or *sparklines* in tables in either *LaTeX*, *HTML*, *Word*, or *Excel* files
  - [sparkline](https://github.com/htmlwidgets/sparkline) - R interface to the [sparkline](http://omnipotent.net/jquery.sparkline/) jquery library
  - [htmlTable](https://github.com/gforge/htmlTable) - Allows to generate tables using HTML formatting. This format is compatible with Markdown when used for HTML-output. 
  - [tableHTML](https://github.com/LyzandeR/tableHTML) - Provides functionalities for easily creating CSS-ible Shiny-compatible HTML tables
  - [basictabler](https://github.com/cbailiss/basictabler) - Construct tables for output to HTML/Excel natively in R, with some style functionalities
  - [pivottabler](https://github.com/cbailiss/pivottabler) - Create *Pivot Tables* natively in R, with some style functionalities

  <a name="visualization"/>

### Data Visualization 
  - [ggplot2](http://docs.ggplot2.org/current/) :heart_eyes: - The most famous package for making amazing graphics in R. *ggplot2* lets you use the [grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.pdf 'A paper by Hadley Wickham') to build layered, customizable plots.
  - [ggvis](http://github.com/rstudio/ggvis) - Interactive, web based graphics built like `ggplot2` with the grammar of graphics
 |- [lattice](https://github.com/deepayan/lattice) - Implementation of Trellis graphics for R, in some ways the main __*competitor*__ to *ggplot*
  - [latticeExtra]() - Add further functionalities to the *lattice* package
  - [googleVis](http://github.com/mages/googleVis) - Wrapper for the [Google Chart API](https://developers.google.com/chart/)
  - [corrplot](http://github.com/taiyun/corrplot) - Visualize correlation matrix using correlogram
  - [corrgram](https://github.com/kwstat/corrgram) - Visualize correlation matrix using correlogram
  - [ggparallel](https://github.com/heike/ggparallel) - Set of functions to draw parallel coordinate plots for categorical data
  - [vcd](https://cran.r-project.org/package=vcd/) - Visualization tools and tests for categorical data
  - [vcdExtra](https://cran.r-project.org/package=vcdExtra/) - Complement to the *vcd*  and the *gnm* packages
  - [gridExtra](http://github.com/baptiste/gridextra/wiki) - Provides a number of user-level functions to work with *grid* graphics
  - [animint2](http://github.com/tdhock/animint2) - Provide tools to design multi-layer, multi-plot, interactive, and possibly animated data visualizations using *ggplot2*, and rendering with [D3](http://d3js.org/)
  - [sjplot](https://github.com/strengejacke/sjPlot) - Collection of plotting and table output functions for data visualization, with a focus on Statistics in Social Science 
  - [trelliscope](https://github.com/delta-rho/trelliscope) - Provides a scalable way to flexibly visualize large, complex data in great detai
  - [tabplot](https://github.com/mtennekes/tabplot) - Provides visualization methods to explore and analyse large multivariate datasets.
  - [treemap](https://github.com/mtennekes/treemap) - Provides functionalities for drawing treemaps
  - [circlize](https://github.com/jokergoo/circlize) - Provides an implementation of circular layout generation
  - [rCharts](https://github.com/ramnathv/rCharts) `install_github('ramnathv/rCharts')` - allow for interactive JS charts from R
  - [clickme](https://github.com/nachocab/clickme) `install_github('nachocab/clickme')` - allow for interactive JS charts from R
  - [rcdimple](http://github.com/timelyportfolio/rcdimple) - R interface to the [dimple](http://dimplejs.org/) JS charts library, an object-oriented API for business analytics.
  - [timevis](http://github.com/daattali/timevis) - Interactive timeline visualizations in R.
  - [alluvial](https://github.com/mbojan/alluvial) - Provides functions to draw alluvial diagrams (see also the *ggalluvial* extension gor *ggplot2*)
  - [iheatmapr](https://github.com/ropensci/iheatmapr) - Allows to build complex and interactive heatmaps using modular building blocks.
  - [riverplot](https://cran.r-project.org/package=riverplot/) - Allows the creation of a basic type of Sankey diagrams
  - [pheatmap](https://github.com/raivokolde/pheatmap) - Provides fine grained control over heatmap dimensions and appearance.
  - [animation](https://github.com/yihui/animation) - A set of utilities to create and export animations to a variety of formats
  - [tweenr](https://github.com/thomasp85/tweenr) - Provides functions to interpolate data between different states
  - [misc3d]() - Miscellaneous functions for three dimensional plots
  - [hexbin](http://github.com/edzer/hexbin) - Provides bivariate binning into hexagonal cells, in an attempt to override overlapping in scatterplots and maps.
  - [dendextend](https://github.com/talgalili/dendextend) - Extends R core dendrogram functionality
  - [voteogram](https://github.com/hrbrmstr/voteogram) `install_github('hrbrmstr/voteogram')` - Voting Cartogram Generators (currently limited to U.S. House and Senate)
  - [Rgraphviz]() - Provides plotting capabilities for R graph objects
  - [coefplot](https://github.com/jaredlander/coefplot) - Provides functionalities for plotting the coefficients and st.err from a variety of models: lm, glm, glmnet, maxLik, rxLinMod, rxGLM and rxLogit. 
  - [likert](http://github.com/jbryer/likert) - A package designed to help analyzing and visualizing Likert type items
  - [wordcloud2](http://github.com/lchiffon/wordcloud2) - R interface to the [wordcloud2](http://github.com/timdream/wordcloud2.js) JS library
  - [DataVisualizations](https://cran.r-project.org/package=DataVisualizations/) - Provides functionalities for the visualization of High-Dimensional Data

  <a name="htmlwidgets"/>

#### htmlwidgets, JS wrappers 
  - [dygraphs](http://rstudio.github.io/dygraphs/) :heart_eyes: - R interface to the [dygraphs](http://dygraphs.com/) JS library for time series, one-line command if your data is an xts object.
  - [plotly](https://github.com/ropensci/plotly) - R interface to the [Plotly](http://plot.ly/javascript/) JS library. Includes a *ggplotly* function to convert on the fly graphs created with *ggplot2*. 
  - [lineup](https://github.com/kbroman/lineup) - R interface to the [LineUp](http://caleydo.org/tools/lineup/) JS library for Visual Analysis of Multi-Attribute Rankings. See also the [GitHub project repo](https://github.com/sgratzl/lineupjs).
  - [highcharter](https://github.com/jbkunst/highcharter) - R interface to the [Highcharts](http://www.highcharts.com/) JS library. It's worth mentioning that this is **not** an open source library, and there's a [fee](https://shop.highsoft.com/highcharts) to be paid, apart from non-profit company or personal use.
  - [rbokeh](http://github.com/bokeh/rbokeh/) - R interface to the [Bokeh](http://bokeh.pydata.org/) JS library
  - [d3heatmap](https://github.com/rstudio/d3heatmap) - 
  - [metricsgraphics](http://hrbrmstr.github.io/metricsgraphics/) - R interface to the [metricsgraphics](http://metricsgraphicsjs.org/) JS library for bare-bones line, scatterplot and bar charts
  - [rthreejs](http://github.com/bwlewis/rthreejs) - R interface to the [threejs](http://threejs.org/) JS library for interactive 3D scatterplots and globes
  - [rglwidget](http://) - Interactive 3D visualizations with R
  - [scatterD3](http://github.com/juba/scatterD3) - Interactive scatter plots visualization
  - [hexjsonwidget](https://github.com/psychemedia/htmlwidget-hexjson) `install_github('psychemedia/htmlwidget-hexjson')` - Provides functionalities to display [HexJSON](https://odileeds.org/projects/hexmaps/hexjson.html) maps based on the [d3-hexjson](https://github.com/olihawkins/d3-hexjson) library
  - [trelliscopejs](https://github.com/hafen/trelliscopejs) - R interface to the [Trelliscope](https://github.com/hafen/trelliscopejs-lib) JS library
  - [BioCircos](https://github.com/lvulliard/BioCircos.R) - R interface to the [BioCircos](http://bioinfo.ibp.ac.cn/biocircos/index.php) JS library
  - [morpheus](https://github.com/cmap/morpheus.R) - R interface to the [morpheus](https://github.com/cmap/morpheus.js/) JS library for advanced interactive visualization of matrices in a heat map display
  - [bpexploder](https://github.com/homerhanumat/bpexploder) - Allows to render box-plots that explode upon mouse-click into jittered individual-value plots, with the additional option to configure tool-tips for each individual points
  - [widgetframe](https://github.com/bhaskarvk/widgetframe) - Provides functionalities for easier embedding of *htmlwidgets* inside responsive *iframes*
  - [circlepackeR](https://github.com/jeromefroe/circlepackeR) `install_github("jeromefroe/circlepackeR")` - R clone for the Mike Bostocks’s D3 [circle packing visualization](http://bl.ocks.org/mbostock/7607535)
  - [worldcloud2](https://github.com/Lchiffon/wordcloud2) - R interface to the [wordcloud2.js](https://github.com/timelyportfolio/sunburstR) JS library 
  - [sunburstR](https://github.com/Lchiffon/wordcloud2) - A treemap with a radial layout, using a design by [John Stasko](http://www.cc.gatech.edu/gvu/ii/sunburst/)
  - [D3partitionR](https://github.com/AntoineGuillot2/D3partitionR) - Allows to build interactive visualisation of nested data.
  - [taucharts](https://github.com/hrbrmstr/taucharts) - R interface to the [taucharts](https://www.taucharts.com/) JS library 
  - [svgPanZoom](https://github.com/timelyportfolio/svgPanZoom) - Provides pan and zoom interactivity to R graphics wrapping the [svg.panzoom.js](http://svgjs.com/plugins/svg-panzoom-js/) JS library.

  <a name="ggplot-extensions"/>

#### ggplot extensions 
  - [colorplaner](https://github.com/wmurphyrd/colorplaner) - visualize two variables through one color aesthetic via mapping to a color space projection.
  - [cowplot](https://github.com/wilkelab/cowplot) - Provides functionalities to label and arrange figures created by `ggplot2` into a grid., plus custom annotations and styles focused for scientific publications
  - [directlabels](https://github.com/tdhock/directlabels) - Functionalities for automatically placing direct labels onto multicolor plots
  - [egg](https://cran.r-project.org/package=egg/) - Miscellaneous functions to help customise multiple *ggplot2* objects in different layouts
  - [**geofacet**](https://github.com/hafen/geofacet) - Provides geographical faceting functionality
  - [geomnet](http://github.com/sctyner/geomnet) - Provides a geometry to visualize graphs and networks, plus a function to calculate network layouts with the *sna* package
  - [gg3D](https://github.com/AckerDWM/gg3D) `install_github("AckerDWM/gg3D")` - Provides functionalities for three-dim graphs
  - [ggallin](https://github.com/shabbychef/ggallin) - Misc extra geoms and scales
  - [ggaluvial](https://github.com/corybrunson/ggalluvial) - Provides geometries to create [alluvial](https://github.com/mbojan/alluvial) diagrams
  - [ggally](http://github.com/ggobi/ggally) - Reduce the complexity of combining geometric objects with transformed data
  - [gggalt](http://github.com/hrbrmstr/ggalt) - Provides extra coordinate systems, geometries, statistical transformation and scales
  - [gganimate](http://github.com/dgrtwo/gganimate/) - Wraps the *animation* package to create animated *ggplot2* plots
  - [ggbeeswarm](https://github.com/eclarke/ggbeeswarm) - Uses either the [beeswarm](https://cran.r-project.org/web/packages/beeswarm/index.html) or the [vipor](https://github.com/sherrillmix/vipor) library to plot column/violin scatterplots, to avoids overlapping datapoints.
  - [ggbuildr](https://cran.r-project.org/package=ggbuildr) - Provides functionalities for saving *ggplot* objects into multiple files, each with a layer added incrementally.
  - [ggChernoff](https://github.com/Selbosh/ggChernoff) - Provides functionalities to map multivariate data to human-like faces (so called [Chernoff faces](https://en.wikipedia.org/wiki/Chernoff_face)) with *ggpolot2*.
  - [ggcorrplot](https://github.com/kassambara/ggcorrplot) - Visualization of a correlation matrix using ggplot2
  - [ggdag](https://github.com/malcolmbarrett/ggdag) - An R Package for visualizing and analyzing directed acyclic graphs
  - [**ggExtra**](http://github.com/daattali/ggExtra) - Add marginal plots to ggplot2
  - [ggfittext](https://github.com/wilkox/ggfittext) - Provides a geometry to fit text into boxes
  - [ggfocus](https://github.com/Freguglia/ggfocus) - Allows to highlight data for a specific subgroup of observations in any ggplot
  - [ggforce](http://github.com/thomasp85/ggforce) - Repository of missing functionalities of any nature and type
  - [ggfortify](http://github.com/sinhrks/ggfortify) - Data Visualization Tools for Statistical Analysis Results in a unified style
  - [gghalves](https://github.com/erocoar/gghalves) `install_github('erocoar/gghalves')` - Allows to compose *half-half* plots, like displaying a boxplot next to jittered points, or violin plots side by side with dotplots.
  - [**gghighlight**](https://github.com/yutannihilation/gghighlight) - Provides functionalitites to highlight conditionally lines and points geometries in ’ggplot2
  - [ggimage](https://github.com/GuangchuangYu/ggimage) - Provides integration of image files and graphic objects
  - [**ggiraph**](http://github.com/davidgohel/ggiraph) - Provides interaction to some geometries
  - [ggiraphExtra](https://github.com/cardiomoon/ggiraphExtra) - Provides additional interactivity on top of ggiraph
  - [gglorenz](https://github.com/jjchern/gglorenz) - plot Lorenz Curves
  - [ggmap](https://github.com/dkahle/ggmap) - Extends the plotting capabilities of *ggplot2*; in particular, it enables the downloading of background maptiles.
  - [ggmcmc](https://github.com/xfim/ggmcmc) - Graphical tools for analyzing Markov Chain Monte Carlo simulations from Bayesian inference
  - [ggmosaic](https://github.com/haleyjeppson/ggmosaic) - Add mosaic functionality to ggplots
  - [ggnetwork](http://github.com/briatte/ggnetwork) - Add geometry to plot networks
  - [ggnet](http://github.com/briatte/ggnet) `install_github('briatte/ggnet')` - 
  - [ggpol](https://github.com/erocoar/ggpol) -  adds parliament diagrams and various other visualizations and convenience functions to ggplot2
  - [ggpmisc](https://bitbucket.org/aphalo/ggpmisc) - Miscellaneous Extensions to *ggplot2*
  - [ggpubr](https://github.com/kassambara/ggpubr) - Provides some easy-to-use functions for creating and customizing ‘ggplot2’- based publication ready plots.
  - [ggpval](https://github.com/s6juncheng/ggpval) - allows you to perform statistic tests and add the corresponding p-values to ggplots automatically
  - [ggradar](https://github.com/ricardo-bion/ggradar) `install_github('ricardo-bion/ggradar')` - Provides a function to build radar charts in moments
  - [ggRandomForests](https://github.com/ehrlinger/ggRandomForests) - Graphical analysis of random forests using the packages *randomForestSRC* and *randomForest*
  - [ggraph](https://github.com/thomasp85/ggraph) - Supports relational data structures such as networks, graphs, and trees.
  - [**ggrepel**](https://github.com/slowkow/ggrepel) - Provides geometries to repel overlapping text labels
  - [**ggridges**](https://github.com/clauswilke/ggridges) - Provides geometries to make ridgeline, a convenient way of visualizing changes in distributions over time or space (this package replaces [ggjoy](https://github.com/clauswilke/ggjoy))
  - [ggseas](https://github.com/ellisp/ggseas) - Provides a geometry that shows seasonal adjustments
  - [ggsignif](https://github.com/const-ae/ggsignif) - Provides tools to add annotations for significance tests
  - [**ggspatial**](http://github.com/paleolimbot/ggspatial) - provides several functions to convert spatial objects to `ggplot2` layers
  - [ggstance](http://github.com/lionel-/ggstance) - Implements horizontal versions of the most common geometries, stats, and positions (note that *ggplot* only flip the entire plot)
  - [ggstatsplot](https://github.com/IndrajeetPatil/ggstatsplot) - Collection of functions to enhance ggplot2 plots with results from statistical tests
  - [ggtern](http://github.com/nicholasehamilton/ggtern) - Extends the functionality of ggplot2, giving the capability to plot ternary diagrams for (subset of) the proto geometries
  - [ggTimeSeries](http://github.com/Ather-Energy/ggTimeSeries) `install_github('Ather-Energy/ggTimeSeries')` - Provides alternative way to display time series
  - [ggvoronoi](https://github.com/garretrc/ggvoronoi/) - Provides functionalities to build Voronoi choropleth maps with ggplot2
  - [ggwordcloud](https://github.com/lepennec/ggwordcloud) - Provides a fast wordcloud text geom for ggplot2
  - [lemon](https://github.com/stefanedwards/lemon) - Provides added functionalities for axes and legends
  - [lindia](https://github.com/yeukyul/lindia) - Provides linear regression diagnostic plots
  - [**patchwork**](https://github.com/thomasp85/patchwork) `install_github("thomasp85/patchwork")` - Allows to easily combine separate ggplots into the same graphic 
  - [**plotROC**](http://github.com/sachsmc/plotROC) - Provides functions to generate interactive ROC curve plots
  - [qqplotr](https://github.com/aloy/qqplotr) - Provides functionalities for drawing both *QQ* and *PP* points, lines, and confidence bands.
  - [quickReg](https://github.com/GeneticResources/quickReg) - provides functions to display regression models for lm, glm and cox regression
  - [survminer](https://github.com/kassambara/survminer) - Provides functionalities for survival analysis and visualization
  - [treemapify](https://github.com/wilkox/treemapify) -  Provides geometries for drawing treemaps
  - [waffle](https://github.com/hrbrmstr/waffle) - Provides functionality to make *waffle* charts (square pie charts)
 
  <a name="ggplot-helpers"/>

#### ggplot helpers
  - [ggedit](https://github.com/metrumresearchgroup/ggedit) - Interactively edit *ggplot* layer aesthetics and theme definitions
  - [esquisse](https://github.com/dreamRs/esquisse) - *RStudio* add-in to make plots with *ggplot2*
  - [ggquickeda](https://github.com/smouksassi/ggquickeda) - 
  - [ggplotAssist](https://github.com/cardiomoon/ggplotAssist) - 
  - [ggplotgui](https://github.com/gertstulp/ggplotgui/) - allows users to visualize their data using an online graphical user interface that makes use of ggplot
  - [ggThemeAssist](https://github.com/calligross/ggthemeassist) - *RStudio* add-in that provides a GUI for editing *ggplot2* themes.

  <a name="ggplot-themes"/>

#### ggplot themes
  - [ggconf](https://github.com/caprice-j/ggconf) - Concise appearance modification of `ggplot2` themes elements
  - [ggsci](https://github.com/road2stat/ggsci) - Collection of palettes inspired by scientific journals, data viz libraries, science fiction movies, and TV shows
  - [**ggthemes**](http://github.com/jrnold/ggthemes) - Collection of various themes and scales 
  - [ggthemr](https://github.com/cttobin/ggthemr) `install_github('cttobin/ggthemr')` - Another collection of various themes 
  - [hrbrthemes](https://github.com/hrbrmstr/hrbrthemes) - Provides typography-centric themes 
  - [tvthemes](https://github.com/Ryo-N7/tvthemes) - Themes and palettes based on some people's favourite TV shows
  - [ggtech](https://github.com/ricardo-bion/ggtech) - Themes and palettes associated with some of the most successful tech (ex) start-ups

  <a name="palettes"/>

#### Palettes, Colours
  - [**RColorBrewer**](https://cran.r-project.org/package=RColorBrewer/) - Provides an easy way to select adequate color palettes for any visualization, following [ColorBrewer](http://colorbrewer2.org/) advises.
  - [**viridis**](https://github.com/sjmgarnier/viridis) - Implementation of the python [Matplolib](http://matplotlib.org/) *viridis* color map
  - [scico](https://github.com/thomasp85/scico) - Palettes for R based on the [Scientific Colour-Maps](http://www.fabiocrameri.ch/colourmaps.php)
  - [dichromat](https://cran.r-project.org/package=dichromat) - Color-blind friendly palettes. Run `colorschemes` to see a list of all hex RGBs strings.
  - [wesanderson](https://github.com/karthik/wesanderson) - A colour palette inspired by Wes Anderson. 
  - [pals](https://github.com/kwstat/pals) - Extensive collection of colormaps and palettes, with multiple tools to evaluate them.
  - [rwantshue](https://github.com/hoesler/rwantshue) `install_github('hoesler/rwantshue')` - Palette inspired by [IWantHue](https://github.com/medialab/iwanthue)
  - [munsell](https://github.com/cwickham/munsell/) - Provides easy access to, and manipulation of, the [Munsell](http://munsell.com/about-munsell-color/how-color-notation-works/) colours
  - [Polychrome](https://cran.r-project.org/package=Polychrome) - Provides a few qualitative palettes with many colors
  - [yarrr](https://github.com/ndphillips/yarrr) - While providing functionalities to build a *pirateplot* (which is a boxplot-like chart that shows simultaneously raw data as points, descriptive stats as lines/bars), and inferential stats as bands), there are quite a few palettes included, just use `piratepal()` to display them all.
  - [jcolors](https://github.com/jaredhuling/jcolors) - Another selection of `ggplot2` color palettes. Run `display_all_jcolors()` to display them all
  - [colorspace](https://cran.r-project.org/package=colorspace/) - Provides color palettes based on HCL colors. Also included an interactive GUI color picker 
  - [qualpalr](https://github.com/jolars/qualpalr) - Another package able to generate *distinct qualitative* color palettes inspired by [IWantHue](http://tools.medialab.sciences-po.fr/iwanthue/)
  - [randomcoloR](https://github.com/ronammar/randomcoloR) - Simple methods to generate *attractive* random colors, as a wrapper of the JS library [randomColor.js](https://github.com/davidmerfield/randomColor), or *optimally distinct* colors based on k-means, inspired by [IWantHue](http://tools.medialab.sciences-po.fr/iwanthue/)
  - [Cairo](https://cran.r-project.org/package=Cairo/) - R graphics device using the [cairo graphics library](https://www.cairographics.org/) for creating high-quality graphics output
  - [paletteer](https://github.com/EmilHvitfeldt/paletteer) - An attempt to collect most of the color palettes $R$ packages, using a common interface.

  <a name="icons"/>

#### Icons, Fonts
  - [fontawesome](https://github.com/rstudio/fontawesome) `install_github('rstudio/fontawesome')` - Allows to easily insert [font awesome](http://fontawesome.com) icons into *RMarkdown* docs and *Shiny* apps
 [Glyphicons](http://getbootstrap.com/components/#glyphicons)
  - [emojifont](https://github.com/GuangchuangYu/emojifont) - Provides functionalities to use  [emoji]( https://github.com/muan/emojilib/) and [font awesome](http://fontawesome.com) icons in both base and `ggplot2` graphics.
  - [emo(ji)](https://github.com/hadley/emo) `install_github('hadley/emo')` - Makes it very easy to insert [emoji]( https://github.com/muan/emojilib/) into RMarkdown documents.
  - [extrafont](https://github.com/wch/extrafont) - 
  - [fontcm](https://github.com/wch/fontcm) - 
  - [showtext](https://github.com/yixuan/showtext) - 
  - [giphyr](https://github.com/haozhu233/giphyr) - Makes it easy to insert GIFs into rmarkdown presentation, only if using RStudio.  
 

  <a name="features-eng"/>

## Features Engineering

  <a name="features-sel"/>

### Features Selection
 
 
  <a name="features-eng"/>

### Dimensionality Reduction
  - [SpatPCA](https://github.com/egpivo/SpatPCA) - Facilitates Regularized Principal Component Analysis for Spatial Data
 

  <a name="understanding"/>

## Data Understanding

   <a name="modeling"/>

### Statistical Modeling
  - [stats](http://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html) - Part of *R* core, contains functions for statistical calculations and random number generation
  - [infer](https://github.com/andrewpbray/infer) - Provides a *tidyverse* expressive statistical grammar to perform statistical inference
  - [broom](http://github.com/tidyverse/broom) - Convert Statistical Analysis Objects into Tidy Data Frames
  - [ggeffects](https://github.com/strengejacke/ggeffects) - Create tidy dataframes of marginal effects for *ggplot2* from model outputs
  - [modelr](http://github.com/hadley/modelr) - Helper functions for modelling (full documentation is available in the online book [R for Data Science](http://r4ds.had.co.nz/model-basics.html), mostly in the *Model basics* chapter)
  - [car](http://) - Contains functions and datasets associated with the book [An R Companion to Applied Regression](http://socserv.socsci.mcmaster.ca/jfox/Books/Companion/index.html). Functions herein could be applied to a fitted regression model, perform additional calculations on the model or possibly compute a different model, and then return values and graphs.
  - [regViz]() - Provides visualization of regression models, pointwise confidence bands, partial residuals as well as outliers and other deviations from modeling assumptions.
  - [rms](http://biostat.mc.vanderbilt.edu/wiki/Main/RmS) - 
  - [gnm]() - Provide functions to specify and fit generalized nonlinear models
  - [mgcv](https://cran.r-project.org/package=mgcv/) - Functionalities for fitting and working with *GAM*s (Generalized Additive Models), *GAMM*s (Generalized Additive Models) and other Generalized Ridge Regression
  - [gam](https://cran.r-project.org/package=gam/) - Functionalities for fitting and working with *GAM*s 
  - [gamlss](http://www.gamlss.org/) - Main package for the Evaluation of Generalized Additive Models for Location Scale and Shape.
  - [nlme](https://github.com/lme4/lme4) **core** - Fit and compare Gaussian Linear and Non-linear Mixed Effects models
  - [lme4](https://github.com/lme4/lme4) - Linear and Non-linear Mixed Effects models, using S4 classes and  algorithms from the [Eigen](http://eigen.tuxfamily.org) C++ library, via the [RcppEigen](http://github.com/RcppCore/RcppEigen) interface layer
  - [multcomp](https://cran.r-project.org/package=multcomp/) - Tools for multiple comparison testing
  - [glmnet](https://cran.r-project.org/package=glmnet/) - Lasso and elastic-net regularized GLM with cross validation
  - [CVXR](https://github.com/anqif/CVXR) - Provides an object-oriented modeling language for convex optimization.
  - [lars](https://cran.r-project.org/package=lars/) - Alternative package for glmnet
  - [biglasso](https://github.com/YaohuiZeng/biglasso) - Extend lasso and elastic-net model fitting to Big Data
  - [survival](https://github.com/therneau/survival) - Tools to perform survival analysis
  - [dismo](http://) - Boosted Regression Trees for ecological modeling

  <a name="mining"/>

### Data Mining, Machine Learning
  - [caret](https://github.com/topepo/caret) - Tools for Classification And Regression Training models, with the intent to combine model training and prediction. A set of functions that attempt to streamline the process for creating predictive models
  - [mlr](http://github.com/mlr-org/mlr) - R Interface to a large number of classification and regression techniques.
  - [class](https://cran.r-project.org/package=class/) - Various functions for classification, including kNN, LVQ and SOM.
  - [h2o](https://github.com/h2oai/h2o-3) - Open Source Fast Scalable Machine Learning API that provides implementations of many popular algorithms in one single platform.
  - [klaR](https://cran.r-project.org/package=klaR) - Miscellaneous functions for classification and visualization 
  - [randomForest](https://cran.r-project.org/package=randomForest/) - Classification methods used to create large number of decision trees, then each observation is inputted into the decision tree. The common output obtained for maximum of the observations is considered as the final output.
  - [ranger](https://github.com/imbs-hl/ranger) - A Fast Implementation of Random Forests
  - [e1071](https://cran.r-project.org/package=e1071/) - Latent class analysis, support vector machine, fuzzy clustering, Fourier transforms, shortest path computation, bagged clustering, naive Bayes classifier, ...
  - [tree](https://cran.r-project.org/package=tree/) - Classification and regression trees.
  - [rpart](https://cran.r-project.org/package=rpart/) - Recursive Partitioning And Regression Trees: classification/regression models using a two stage procedure, with the resultant model represented in the form of binary trees
  - [party](https://cran.r-project.org/package=party/) - recursive partitioning, using ensemble methods, to build decision trees based on Conditional Inference algorithm
  - [partykit](https://cran.r-project.org/package=partykit/) - A Toolkit for Recursive Partytioning
  - [arules](https://cran.r-project.org/package=arules/) - Mining Association Rules and Frequent Itemsets
  - [nnet](https://cran.r-project.org/package=nnet/) - Feed-forward Neural Networks and Multinomial Log-Linear Models
  - [neuralnet](https://cran.r-project.org/package=neuralnet/) - Training of neural networks using back-propagation
  - [kknn](https://cran.r-project.org/package=kknn/) - Weighted k-Nearest Neighbors for Classification, Regression and Clustering
  - [kernlab](https://cran.r-project.org/package=kernlab/) - KERNel-based Machine Learning LABoratory
  - [C50](http://) - 
  - [xgboost](https://cran.r-project.org/package=xgboost/) - Efficient implementation of the gradient boosting framework from [Chen & Guestrin]()
  - [gbm](https://cran.r-project.org/package=gbm/) - Gradient Boosting Machine
  - [AppliedPredictiveModeling](http://) - 
  - [earth](http://) - 
  - [mda](http://) - (kappa statistics)
  - [tau](https://cran.r-project.org/package=tau/) - Text Analysis Utilities
  - [tidytext](https://github.com/juliasilge/tidytext) - Text mining using tidyverse tools
  - [tm](https://cran.r-project.org/package=tm/) - A framework for text mining applications within R.
  - [ada](https://cran.r-project.org/package=ada/) - Stochastic Boosting
  - [adabag](https://cran.r-project.org/package=adabag) - Classification with Boosting and Bagging [technical article](http://www.jstatsoft.org/index.php/jss/article/view/v054i02/adabag_An_R_Package_for_Classification_with_Boosting_and_Bagging.pdf)
  - [RoogleVision](http://) - a Package for Image Recognition
  - [magick](https://github.com/ropensci/magick) - Advanced High-quality image processing in R

  <a name="time-series"/>

### Time Series, Forecasting
  - [zoo](https://cran.r-project.org/package=zoo/) - Provides the most popular format for saving and handling with time series objects in R.
  - [xts](http://github.com/joshuaulrich/xts) - Extensible time series class that provides uniform handling of many *R* ts classes by extending zoo.
  - [timetk](https://github.com/business-science/timetk) - Formerly *timekit*, it's a collection of tools for working with time series
  - [forecast](http://github.com/robjhyndman/forecast) - Makes it incredibly easy to fit time series models like ARIMA, ARMA, AR, Exponential Smoothing, etc.
  - [sweep](https://github.com/business-science/sweep) - Tries to link the *forecast* package with the *tidyverse*, so to extend the *broom* tools for forecasting and time series analysis 
  - [prophet](https://facebookincubator.github.io/prophet/) - Forecasting tool from Facebook
  - [tibbletime](https://github.com/business-science/tibbletime) - Provides functionalities for *time-aware* tibbles 
 
  <a name="survival"/>

### Survival Analysis

 
  <a name="network"/>

### Network Analysis
  - [igraph](https://github.com/igraph/rigraph) - A collection of network analysis tools, based on the [igraph](http://igraph.org) library
  - [visNetwork](http://datastorm-open.github.io/visNetwork/) - R interface to the open-source JS library [vis.js](http://visjs.org/)
  - [networkD3](http://christophergandrud.github.io/networkD3/) - network graphs
  - [DiagrammeR](http://rich-iannone.github.io/DiagrammeR/) - R interface to the open-source JS libraries [mermaid.js](http://github.com/knsv/mermaid) and [Graphviz](http://www.graphviz.org/), capable of generating diagrams and flowcharts from text in a similar manner as markdown.
  - [sna](https://cran.r-project.org/package=sna/) - A range of tools for Social Network Analysis
  - [SigmaNet]() - Provides functionalities for rendering graphs created using the *igraph* package

  <a name="spatial"/>

### Spatial Data

  <a name="spatial-tools"/>

#### Generics, Tools, Utilities
  - [sf](https://github.com/r-spatial/sf) :+1: - Support for [*simple features*](https://en.wikipedia.org/wiki/Simple_Features), a new standardized way to encode spatial data, with bindings to GDAL, GEOS and Proj.4.
  - [sp](https://github.com/edzer/sp) :+1: - Provides classes and methods for spatial data
  - [rgdal](https://cran.r-project.org/package=rgdal/) :+1: - R interface to the popular C/C++ *Geospatial Abstraction Library* [GDAL](http://www.gdal.org/), that enables R to handle a broader range of spatial data formats. 
  - [rgeos](https://cran.r-project.org/package=rgeos/) :+1: - Tools for handling spatial operations on topologies. R interface to the powerful vector processing library [geos](http://trac.osgeo.org/geos/)
  - [maptools](https://cran.r-project.org/package=maptools/) :+1: - Provides various functions for manipulating and reading spatial data from various formats
  - [rmapshaper](https://github.com/ateucher/rmapshaper) :+1: - R interface to the [mapshaper](https://github.com/mbloch/mapshaper/) JS library for Geospatial Operations
  - [tmaptools](https://github.com/mtennekes/tmaptools) :+1: - Add-on package for *tmap* that provides utilities for reading and processing *shapefiles* and *simple features* formats 
Plus, `tmaptools::palette_explorer()` is a great tool for picking *ColorBrewer* palettes
  - [mapedit](https://github.com/r-spatial/mapedit) - Interactive editing of spatial data
  - [geojson](https://github.com/ropensci/geojson) - Provides classes and methods for spatial data defined as [GeoJSON](https://tools.ietf.org/html/rfc7946).
  - [geojsonio](https://github.com/ropensci/geojsonio) - Functions to convert from/to geojson objects
  - [osrm](https://github.com/rCarto/osrm) - R interface to the [OSRM API](http://project-osrm.org/) routing service, based on [OpenStreetMap](https://www.openstreetmap.org/about) data, that allows to compute distances (travel time and kilometric distance) between points and travel time matrices.
  - [raster](https://cran.r-project.org/package=raster) - Provides functionalities for reading, writing, manipulating, analyzing and modeling of gridded spatial data
  - [GEOmap](https://cran.r-project.org/package=GEOmap) - 
  - [PSBmapping]() - 
  - [geoaxe](https://github.com/ropenscilabs/geoaxe) `install_github('ropenscilabs/geoaxe')` - Provides tools to split geospatial objects into pieces
  - [geoops](https://github.com/ropenscilabs/geoops) `install_github('ropenscilabs/geoops')` - Provides spatial operations on GeoJSON that work with the *geojson* package
  - [siftgeojson](https://github.com/ropenscilabs/siftgeojson) `install_github('ropenscilabs/siftgeojson')` - Provides functions to slice and dice GeoJSON just as easily as a data.frame. It is built on top of *jqr*, an R wrapper for [jq](https://stedolan.github.io/jq/), a JSON processor.
  - [geosphere](https://cran.r-project.org/package=geosphere/) - Spherical trigonometry for geographic applications: measures for angular (longitude/latitude) locations.
  - [photon](https://github.com/rCarto/photon) `install_github('rCarto/photon')` - R Interface to the OS geocoder [Photon API](https://github.com/komoot/photon), built for [OpenStreetMap](http://www.osm.org/) data, that gives you back the results in a convenient data frame structure.
  - [mapsapi](https://github.com/michaeldorman/mapsapi/issues) - Interface to the *Directions*, *Distance Matrix* and *Geocode* *'Google Maps* APIs
  - [RQGIS](https://github.com/jannes-m/RQGIS) - Establishes an interface between R and QGIS, that allows access to QGIS functionalities from within R.
 
  <a name="mapping"/>

#### Mapping
  - [mapproj](https://cran.r-project.org/package=mapproj/) - Provide simple functions to convert from latitude and logitude into projected coordinates.
  - [maps](https://cran.r-project.org/package=maps/) - Simple functions to display geographical maps
  - [mapview](https://github.com/r-spatial/mapview) - Interactive visualization of spatial objects in R
  - [tmap](https://github.com/mtennekes/tmap) :heart_eyes: - Quick and easy thematic mapping in R, inheriting functionalities from *ggplot2*, like faceting
  - [leaflet](http://rstudio.github.io/leaflet/) :heart_eyes: - Interactive mapping tools, conceived as a htmlwidgets wrapper for [leaflet](leafletjs.com) JS library
  - [leaflet.extras](https://github.com/bhaskarvk/leaflet.extras) - Provides extra functionality to the `leaflet` package using various [leaflet plugins](http://leafletjs.com/plugins)
  - [leaflet.minicharts](https://github.com/rte-antares-rpackage/leaflet.minicharts) - Provides two functions to add and update small charts on an interactive maps created with the package `leaflet`.
  - [micromap](https://github.com/USEPA/micromap) - Provides functionalities to create linked micromap plots
  - [mapplots]() - 
  - [mapmisc](https://cran.r-project.org/package=btb) - Provides a few utilities for making nice maps in short tidy code chunks which are suitable for knitr documents.
  - [cartography](https://github.com/riatelab/cartography) - Allows to create easily thematic cartography
  - [geogrid](https://github.com/jbaileyh/geogrid) - Provides functionalities to turn geospatial polygons into regular or hexagonal grids
  - [cartogram](https://github.com/sjewo/cartogram) :sparkles: - Construct continuous area cartograms by a *rubber sheet distortion* algorithm or *non-contiguous Area Cartograms* (a [*cartogram*](https://en.wikipedia.org/wiki/Cartogram) is a choropleth map where polygons are sized proportionally to some thematic mapping variable – such as population, GNP, travel time, ... – instead of the usual land area or distance)
  - [topogRam](http://github.com/pvictor/topogRam) :sparkles: - It's an htmlwidget for creating continuous cartograms, based on the [implementation with D3.js](http://prag.ma/code/d3-cartogram/#popest/2010) by Shawn Allen.
  - [tilegramsR](https://github.com/bhaskarvk/tilegramsR) - R interface to the [tilegrams](https://github.com/PitchInteractiveInc/tilegrams) library, that allows to build `sf` spatial objects representing various tilegrams (a *tilegram* is a cartogram where all polygons are drawn in the same hexagonal shape)
  - [recmap](https://github.com/cpanse/recmap) - Compute the Rectangular Statistical Cartogram
  - [GISTools](https://cran.r-project.org/package=GISTools/) - Mapping and spatial data manipulation tools
  - [greatCircles](https://github.com/homeaway/great-circles) - Provides functionalities to create [great-circle](https://en.wikipedia.org/wiki/Great-circle_distance
) arcs 
  - [osmplotr](https://github.com/ropensci/osmplotr) - Allows Data visualisation using [OpenStreetMap](https://www.openstreetmap.org/) objects
  - [osmdata](https://github.com/ropensci/osmdata) - Allows to download and import *OpenStreetMap* data as `sf` or `sp`` objects
  - [rosm](https://github.com/paleolimbot/rosm) - Download and plot Open Street Map (and other tiled map sources) using *base* plotting and `sp` spatial objects.
  - [googleway](https://github.com/SymbolixAU/googleway/) - Provides access to [Google Maps API](https://developers.google.com/maps/), and the ability to plot interactive Google Maps
  - [RgoogleMaps](http://rgooglemaps.r-forge.r-project.org/) - R interface to the [Google server](maps.google.com) for static maps
  - [choroplethr](http://) - mapping tool
  - [datamaps](https://github.com/JohnCoene/datamaps) - R htmlwidget for the [datamaps](http://datamaps.github.io/) JS libary
  - [RWorldMap]() - lets map easily global data
  - [rasterVis]() - raster visualization
  - [stplanr](https://github.com/ropensci/stplanr) - Provides functionalities to convert data on travel behaviour into geographic objects that can be plotted on a map and analysed using typical GIS methodology

  <a name="geocomputation"/>

#### Analysis, Geocomputation
  - [spatstat](https://github.com/spatstat/spatstat/) - Spatial Point Pattern analysis
  - [spdep](https://github.com/r-spatial/spdep/) - A collection of functions and tests for evaluating spatial dependence
  - [gstat](http://cran.rstudio.com/web/packages/gstat/) - Functions for spatial and spatio-temporal geostatistical modeling, prediction and simulation
  - [geoR](https://cran.r-project.org/package=geoR) - Provides functionalities for geostatistical data analysis
  - [geoRglm](https://cran.r-project.org/package=geoRglm) - Functions for inference in generalised linear spatial models
  - [KRIG](https://github.com/pedroguarderas/KRIG) - Spatial Statistic with Kriging
  - [spatialEco](https://github.com/jeffreyevans/spatialEco) - Provides functionalities for spatial analysis and modelling, mostly for ecological systems
  - [georob](https://cran.r-project.org/package=georob) - Robust Geostatistical Analysis of Spatial Data
  - [fields](https://cran.r-project.org/package=fields) - Various tools for the analysis of Spatial data
  - [stars](https://github.com/r-spatial/stars) - (*Proposed package*) Provides functionality for handling dense spatiotemporal data as tidy arrays
  - [GWmodel]() - Geographically weighted models
  - [spatgraphs]() - Graph Edge Computations for Spatial Point Patterns
  - [nngeo](https://github.com/michaeldorman/nngeo) - K-nearest neighbor search for projected and non-projected *sf* spatial layers
  - [geozoning](https://github.com/hazaeljones/geozoning) - Provides functionalities for zoning spatial data
  - [spcosa](https://cran.r-project.org/package=spcosa) - Spatial coverage sampling and random sampling from compact geographical strata created by k-means
  - [dissever](https://github.com/pierreroudier/dissever) - Provides methods for general method for spatial downscaling
  - [spacetime](http://cran.rstudio.com/web/packages/spacetime/) - 
  - [trajectories](http://cran.rstudio.com/web/packages/trajectories/) - 
  - [akima]() - for spline interpolation
  - [deldir](https://cran.r-project.org/package=deldir/) - Functions to calculate and manipulate Delaunay Triangulations and Dirichlet or Voronoi tessellations of points datasets
  - [sparr](https://github.com/tilmandavies/sparr) - Provides functionalities for estimating spatial and spatiotemporal Relative Risk
  - [lawn](https://github.com/ropensci/lawn) - R client for [turf.js](http://turfjs.org/), an *Advanced geospatial analysis for browsers and node*. It also wraps some functions from the *Node* package [geojson-random](https://github.com/mapbox/geojson-random)
  - [emdi](https://github.com/SoerenPannier/emdi) - Provide functionalities that support estimating, assessing and mapping regional disaggregated indicators
  - [PBSmapping](https://github.com/pbs-software/pbs-mapping) - Born as a tool to map fisheries data, it's evolved as a generic spatial extension for R.
  - [SpatialTools](https://github.com/jpfrench81/SpatialTools) - Provides functionalities for spatial prediction and simulation, with some emphasis on *kriging* and spatio-temporal data analysis
  - [btb](https://github.com/ArlindoDosSantos/btb/) - Kernel Density Estimation dedicated to Urban Geography, that allows you to square and smooth geolocated data
  - [nngeo](https://github.com/michaeldorman/nngeo/) - provide k-nearest neighbor join capabilities for spatial analysis

  <a name="localization"/>

#### Localization
  - [tigris](https://github.com/walkerke/tigris) - 
  - [tidycensus](https://github.com/walkerke/tidycensus) - 


  <a name="model-validation"/>

## Model Validation, ROC Analysis
  - [DALEX](https://github.com/pbiecek/DALEX) - A set of tools that help to understand how complex machine learning models are working.
  - [ROCR](https://cran.r-project.org/package=ROCR/) - Visualizing the performance of scoring classifiers
  - [pROC](https://cran.r-project.org/package=pROC/) - Display and Analyze ROC Curves
  - [plotROC](http://github.com/sachsmc/plotROC) - Provides functions to generate interactive ROC curve plots
  - [PROC]() - 
  - [TimeROC]() - 

  <a name="presentation"/>

## Data Presentation
  - [blogdown](https://github.com/rstudio/blogdown) - Provides functionalities to easily generate static websites based on RMarkdown and [Hugo](https://gohugo.io/) 
  - [bookdown](https://github.com/rstudio/bookdown) - Built on top of RMarkdown, makes it really easy to write books and long-form articles/reports.
  - [knitr](https://github.com/yihui/knitr) - Provides functionalities to bundle together *R* snippets and *markdown* documents, to easily generate automated reports in various formats. 
  - [officer](https://github.com/davidgohel/officer) - Allows to manipulate *Word* (.docx) and *PowerPoint* (.pptx) documents
  - [rmarkdown](http://rmarkdown.rstudio.com/) :heart_eyes: - The perfect workflow for reproducible reporting. Write R code in your markdown reports. When you run render, R Markdown will replace the code with its results and then export your report as an HTML, pdf, or MS Word document, or a HTML or pdf slideshow. The result? Automated reporting. R Markdown is integrated straight into RStudio.
  - [shiny](http://shiny.rstudio.com/) :heart_eyes: - Easily make interactive, web apps with R. A perfect way to explore data and share findings with non-programmers.

  <a name="shiny-ext"/>

### Shiny extensions
  - [bs4Dash](https://github.com/DivadNojnarg/bs4Dash) - Bootstrap 4 shinydashboard using the [AdminLTE3](https://adminlte.io/) template.
  - [bsplus](https://github.com/ijlyttle/bsplus) - Provide a framework to facilitate the use of [Bootstrap's JavaScript-markup API](http://getbootstrap.com/javascript/) inside *rmarkdown* HTML documents and *Shiny* apps
  - [colourpicker](https://github.com/daattali/colourpicker) :+1: - Provides a colour picker tool for *Shiny* apps
  - [dragulaR](https://github.com/zzawadz/dragulaR) - R interface for the [dragula](https://github.com/bevacqua/dragula) JS library, that allows to move around elements in a shiny app.
  - [ECharts2Shiny](http://github.com/XD-DENG/ECharts2Shiny) - R interface to the [ECharts](http://ecomfe.github.io/echarts-doc/public/en/) JS library, now an [an incubator project](http://incubator.apache.org/projects/echarts.html) of the Apache Software Foundation
  - [flexdashboard](http://rmarkdown.rstudio.com/flexdashboard/) - A flexible and easy way to specify row and column-based layouts, to publish a group of related data visualizations as a dashboard.
  - [gradientPickerD3](https://github.com/peikert/gradientPickerD3) - Allows to add gradient choosers to Shiny apps, as implemented in the [Gradient Picker](https://github.com/tantaman/jquery-gradient-picker) jQuery plugin.
  - [jsTree](https://github.com/metrumresearchgroup/jsTree) - Shiny integration with the [jsTree](http://jstree.com/) JS library
  - [midas](https://github.com/shapenaji/midas) - Convert HTML/XML native code into lists or shiny function(s) that would generate the equivalent shiny object(s) - [shinyBS](http://ebailey78.github.io/shinyBS/) - Add additional functionality and interactivity to Shiny apps, like Alerts, Tooltips and Popovers
  - [miniUI](https://github.com/rstudio/miniUI) - Provides UI widget and layout functions for writing Shiny apps that work well on small screens.
  - [regexSelect](https://github.com/yonicd/regexSelect) - Enables *regular expression* searches within a *Shiny* selectize object.
  - [rintrojs](https://github.com/carlganz/rintrojs/) - R interface to the [Introjs](http://introjs.com/) JS library that let users easily add instructions to their web applications 
  - [shiny.admin]() - 
  - [shiny.user]() - 
  - [shiny.collection]() - 
  - [shiny.semantic]() - 
  - [semantic.dashboard]() - 
  - [shinyAce](https://github.com/trestletech/shinyAce) - Enables Shiny developers to use the [Ace text editor](https://ace.c9.io/) in their apps.
  - [shinyalert](https://github.com/daattali/shinyalert) - Create pretty modals popup messages
  - [shinyhelper](https://github.com/cwthom/shinyhelper) - Allows to add help documentation to shiny inputs and outputs, using RMarkdown files
  - [shinyanimate](https://github.com/Swechhya/shinyanimate) - An extension for the [animate.css](https://github.com/daneden/animate.css) library, that allows to add animations to any UI element in a shiny app.
  - [shinycssloaders](https://github.com/andrewsali/shinycssloaders) :+1: - Add loader animations (spinners) to Shiny Outputs in an automated fashion.
  - [shinycustomloader](https://github.com/emitanaka/shinycustomloader) - Extension to the previous `shinycssloaders` package that allows for custom css/html or gif/image file to include in the loading screen. There are also twelve additional built in css/html loading screen.
  - [shinydashboard](http://rstudio.github.io/shinydashboard/) - Makes it easy to use Shiny to create dashboards-like apps.
  - [shinydashboardPlus](https://github.com/DivadNojnarg/shinydashboardPlus) - Enrich a shinydashboard with some additional functionalities.
  - [shinyDND](https://github.com/ayayron/shinydnd) - Provides functionalities to create drag and drop elements in Shiny apps.
  - [shinyFeedback](https://github.com/merlinoa/shinyFeedback) - Displays user feedback next to shiny inputs
  - [shinyFiles](https://github.com/thomasp85/shinyFiles) - Provides a shiny extension for server side file access
  - [shinyLP](https://github.com/jasdumas/shinyLP) - Provide Bootstrap components to make landing home pages for Shiny apps
  - [shinyjqui](https://github.com/Yang-Tang/shinyjqui) - R wrapper for the [jQuery UI javascript library](http://jqueryui.com/), that allows users to easily add interactions and animation effects to a *Shiny* app.
  - [shinyjs](http://github.com/daattali/shinyjs/) :+1: - It lets you perform common useful JS operations in Shiny apps without having to actually know any JS
  - [shinymaterial](https://github.com/ericrayanderson/shinymaterial) - Implements *Material Design* in Shiny apps
  - [shinysense](https://github.com/nstrayer/shinysense) `install_github("nstrayer/shinysense")` - Shiny modules to help shiny recall data from more than the keyboard
  - [shinytest](https://github.com/rstudio/shinytest) - 
  - [shinythemes](http://rstudio.github.io/shinythemes/) - Makes it easy to alter the overall appearance of any Shiny app
  - [shinyWidgets](https://cran.r-project.org/package=shinyWidgets/) :+1: - Provides custom input widgets for Shiny apps. See the live version of the vignette [here](https://dreamrs-vic.shinyapps.io/shinyWidgets/)
  - [tippy](https://github.com/JohnCoene/tippy/) - Allows to add Tooltips to *RMarkdown* Documents and *Shiny* apps using *htmlwidgets and the [tippy.js](https://atomiks.github.io/tippyjs/) JS library.

  <a name="shiny-apps"/>

### Shiny Apps Examples
  - [ChannelAttributionApp]() - 
  - [cocktailApp](https://github.com/shabbychef/cocktailApp)
  - [ERSA](https://github.com/cbhurley/ERSA) - A collection of functions for displaying the results of a regression calculation, packaged together as a shiny app.
  - [Factoshiny]() - 
  - [MAVIS](https://github.com/kylehamilton/MAVIS) - 
  - [Radiant](https://github.com/radiant-rstats/radiant) - 
  - [RtutoR](https://github.com/skranz/RTutor) - 
  - [SpatialEpiApp](https://github.com/Paula-Moraga/SpatialEpiApp) - 
  - [teachingApps](https://github.com/Auburngrads/teachingApps) - Apps for Teaching Statistics, R Programming, and Shiny App Development

  <a name="shiny-apps"/>

### RMarkdown Themes
  - [prettydoc](https://github.com/yixuan/prettydoc) - 
  - [rmdformats]() - 
  - [xaringan]() - 
  - []() - 
  - [rmdshower](https://github.com/mangothecat/rmdshower) - 



  <a name="applications"/>

## Applications

  <a name="matrix"/>

### Matrix Calculus
  - [Matrix](https://cran.r-project.org/package=Matrix/) - Sparse and Dense Matrix Classes and Methods
  - [svd](https://cran.r-project.org/package=svd/) - Interface to Lanczos SVD and eigensolvers from R
  - [irlba](http://illposed.net/irlba.pdf) - Provides a fast way to compute partial SVDs and principal component analyses of very large scale data
  - [OpenMx](http://openmx.ssri.psu.edu/) - Matrix optimizer, ofetn used to fit general SEM (structural equation models)

  <a name="probability"/>

### Probability, Simulation, Computational Statistics
  - [fitdistrplus](https://cran.r-project.org/package=fitdistrplus/) - Extends the `fitdistr` function of the `MASS` package with several functions to help the fit of univariate parametric distributions to censored or non-censored data, using a plethora of different methods.
  - [boot]() - bootstrap calculations
  - [deSolve]() - 
  - [cvTools]() - 
  - [laeken]() - 
  - [rlecuyer]() - 

  <a name="finance"/>

### Quantitative Analyis, Applied Finance
  - [quantmod](https://github.com/joshuaulrich/quantmod) - Tools for downloading financial data, plotting common charts, and doing technical analysis.
  - [PerformanceAnalytics](https://github.com/braverock/PerformanceAnalytics) - Provides functionalities to assess performance and risk analysis of financial instruments or portfolios.
  - [TTR](https://github.com/joshuaulrich/TTR) - Provides Technical analysis functionalities to construct technical trading rules.
  - [tidyquant](https://github.com/business-science/tidyquant) - Financial package useful for importing, analyzing and visualizing data, as well as integrating aspects of other financial packages with *tidyverse* tools.
  - [Quandl](https://github.com/quandl/quandl-r) - Get financial and economic datasets from hundreds of publishers directly into R. Free plan for open data, paid plans for all othet sources
  - [fMultivar](https://cran.r-project.org/package=fMultivar/) - Analysis and Modeling of Multivariate Financial Return Distributions
  - [BatchGetSymbols](https://cran.r-project.org/package=BatchGetSymbols/) - Downloads and Organizes Financial Data for a large number of Tickers using Yahoo or Google Finance.

  <a name="digital"/>

### Digital Analytics
  - [googleAnalyticsR](https://github.com/MarkEdmondson1234/googleAnalyticsR) - A bridge to **Google Analytics**
  - [rga](http://github.com/skardhamar/rga/) - One more interface to **Google Analytics**
  - [twitteR]() - 

  <a name="meta"/>

### Meta-Analyis
  - [meta]() - 
  - [metafor](http ://www.metafor-project.org/doku.php) - 
  - [metaSEM](http://courses.nus.edu.sg/course/psycwlm/Internet/metaSEM/) - Conducts meta-analyses by formulating meta-analytic models as Structural Equation Models.
  - [rmeta]() - 
  - [epir]() - 
  - [forestplot](https://github.com/gforge/forestplot) - 
  - [esc](https://github.com/sjPlot/esc) - Implementation in R of the web-based [Practical Meta-Analysis Effect Size Calculator](http://www.campbellcollaboration.org/escalc/html/EffectSizeCalculator-Home.php) from David B. Wilson, author of the famous book *Practical Meta-analysis*.

  <a name="bio"/>

### BioConductor
[Bioconductor](https://www.bioconductor.org/) provides tools for the analysis and comprehension of high-throughput genomic data. The `biocLite()` command is the recommended way to install *Bioconductor* packages: *Bioconductor* has a repository and release schedule that differs from *R*. Run `source('http://bioconductor.org/biocLite.R')` to get the latest version of *Bioconductor*.
  - [IRanges]() - 
  - [AnnotationDbi]() - 

  <a name="other-applications"/>

### Other Applications
  - [psych](https://cran.r-project.org/package=psych/) - Procedures for Psychological, Psychometric, and Personality Research


  <a name="programming"/>

## Programming Tools

  <a name="performance"/>

### High Performance
  - [Rcpp](https://github.com/RcppCore/Rcpp) - Write R functions that call C++ code for lightning fast speed.
  - [future](https://github.com/HenrikBengtsson/future) - Provides a lightweight and unified Future API for sequential and parallel processing of R expression via futures
  - [promises](https://github.com/rstudio/promises) - Allows *asynchronous* programming capabilities, that increase scalability and responsiveness, especially to Shiny apps.
  - [parallel]() **core** - Use parallel processing in R to speed up your code or to crunch large data sets.
  - [foreach](https://cran.r-project.org/package=foreach/) - 
  - [doMC](https://cran.r-project.org/package=doMC/) - Multicore processing
  - [multicore]() - ...
  - [doSNOW]() - ...
  - [SOAR](https://cran.r-project.org/package=SOAR/) - Memory management by delayed assignments
  - [rbenchmark]() - ...

  <a name="big-data"/>

### Big Data
  - [sparklyr](https://github.com/rstudio/sparklyr) - R interface for [Apache Spark](http://spark.apache.org/), data engine for large-scale data processing, that also provides a complete dplyr backend and access to Spark distributed machine learning library.
  - [bigrquery](https://github.com/rstats-db/bigrquery) - R interface to [Google BigQuery](https://developers.google.com/bigquery/)
  - [bigQueryR](https://github.com/cloudyr/bigQueryR) - A less developed R interface to [Google BigQuery](https://developers.google.com/bigquery/), but uses [googleAuthR](https://github.com/MarkEdmondson1234/googleAuthR) as backend, and therefore has Shiny support
  - [datadr](https://github.com/delta-rho/datadr) - Provides methods for dividing large and complex datasets into subsets, applying analytical methods to the subsets, and recombining the results. 
  - [RHIPE](https://github.com/saptarshiguha/RHIPE/) - Provides a way to use Hadoop from R. Installation of RHIPE requires a working Hadoop cluster and several prerequisites.
  - [ddR](https://github.com/vertica/ddR) - Standard API for Distributed Data Structures in R

  <a name="cloud"/>

### Cloud Computing
  - [analogsea](http://github.com/sckott/analogsea) - R client for version 2 of the [Digital Ocean API](http://developers.digitalocean.com/v2/)
  - [piggyback](https://github.com/ropensci/piggyback) - Allows larger (up to 2 GB) data files to piggyback on a repository as assets attached to individual GitHub releases.

  <a name="internet"/>

### Web, Internet
  - [RCurl](http://www.omegahat.net/RCurl/) -  R-interface to the [libcurl](https://curl.haxx.se/) library, that provides HTTP facilities: composition of general HTTP requests, functions to fetch URLs, to get and post web data
  - [httr](http://github.com/r-lib/httr) - A set of useful tools for working with http connections, especially pulling data from APIs
  - [htmltools](https://github.com/rstudio/htmltools) - Tools for HTML generation and output
  - [rvest](https://github.com/hadley/rvest) Provides functionality for *web scraping*, extracting data from HTML pages, in a similar manner as Python's [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/). Works well with [Selectorgadget](https://cran.r-project.org/package=rvest/vignettes/selectorgadget.html).
  - [blastula](https://github.com/rich-iannone/blastula) - Easily send great-looking HTML email messages from *R*
  - [htmltab](https://github.com/crubba/htmltab) - Easily scrapes table from web pages and returns formatted dataframes
  - [webreadr](https://github.com/Ironholds/webreadr) - A set of wrappers and functions for reading, munging and formatting data from access logs and other sources of web request data.

  <a name="apis"/>

#### APIs
  - [pageviews](https://github.com/Ironholds/pageviews) - An API client library for Wikimedia pageview data
  - [birdnik](https://github.com/Ironholds/birdnik) - R client for the [Wordnik](https://www.wordnik.com/) dictionary (require access tokens)
  - [w3wr](https://bitbucket.org/richierocks/w3wr) - R client for the [what3words](https://map.what3words.com/) maps service (require access tokens)
  - [alphavantager](https://github.com/business-science/alphavantager) - R client for [Alpha Vantage](https://www.alphavantage.co/), an API for retreiving real-time and historical financial data (require access tokens)

  <a name="packages"/>

### Package Development
  - [devtools](http://github.com/hadley/devtools/) - An essential suite of tools for turning code into an R package
  - [testthat](https://github.com/r-lib/testthat) - An easy way to write unit tests for any code projects.
  - [roxygen2](http://roxygen.org/#documentation) - A quick way to document any R packages. roxygen2 turns inline code comments into documentation pages and builds a package namespace.
  - [lintr](https://github.com/jimhester/lintr) - Static code analysis for R
  - [htmlwidgets](http://www.htmlwidgets.org/) - A fast way to build interactive (javascript based) displays and visualizations. See also the [gallery](http://gallery.htmlwidgets.org/)
  - [log4r](http://github.com/johnmyleswhite/log4r) - A simple logging system for R, based on [log4j](logging.apache.org/log4j/)
  - [installr](http://github.com/talgalili/installr/) - (Windows only) Allows to easily update the installed version of R from within R
  - [reticulate](https://github.com/rstudio/reticulate) - R Interface to Python

  <a name="git"/>

### Version Control
  - [git2r](https://github.com/ropensci/git2r) - Provides tools for programmatic access to Git repositories, using the [libgit2](http://libgit2.github.com/) library
  - [rgithub](https://github.com/cscheid/rgithub) - R Bindings for the Github API
  - [gistr](https://github.com/ropensci/gistr) - R interface to GitHub's *gists*

  <a name="utilities"/>

### Utilities
  - [profvis](https://github.com/rstudio/profvis) - 
  - [googleAuthR](https://github.com/MarkEdmondson1234/googleAuthR) - Shiny compatible R interface to select Google API Client Libraries. Easy authentication with OAuth2.
  - [webshot](http://github.com/wch/webshot) - It makes it easy to take screenshots of web pages from R. It requires an installation of [PhantomJS](http://phantomjs.org/), that could be installed from inside R using `webshot::install_phantomjs()`
  - [plumber](http://github.com/trestletech/plumber) - Allows to create a REST API
  - [gmailR](http://github.com/jimhester/gmailr) - Provides a way to send gmail message from R with attachments.
  - [hexSticker](https://github.com/GuangchuangYu/hexSticker) - Provides a function to create [Hexagon stickers](http://hexb.in/sticker.html)
  - [slackr](https://github.com/hrbrmstr/slackr) - R interface to the [Slack](slack.com) messaging platform
  - [diffobj](https://github.com/brodieG/diffobj) - Generate a colorized diff of two R objects for an intuitive visualization of their differences
  - [editr](https://github.com/swarm-lab/editR) - Basic editor for *Rmarkdown* documents with instant previewing. Alternative way to [R Notebooks](http://rmarkdown.rstudio.com/r_notebooks.html)
  - [pacman](https://github.com/trinker/pacman) - A package management tools for R
  - [reinstallr](https://github.com/calligross/reinstallr) - Simple tool to identify and reinstall missing packages
  - [countrycode](https://github.com/vincentarelbundock/countrycode) - Standardize country names, convert them into one of eleven coding schemes, convert between coding schemes, and assign region descriptors.


  <a name="datasets"/>

## Datasets


  <a name="resources"/>

## Resources


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQ3NDE4OTUwNSwxOTYyNTMxMTQ1LC0xMj
M3ODEzMjY3LDIxMDUyMzA0NTgsLTEwNzcwMDQwMjEsLTE0NDQy
NjA3MzksLTEwOTY0OTkyMyw5MDcxNTM4ODYsLTcyNzI4OTIyMy
wtMTI5MjI0NzQ2MywtMjEwMzM2MDQzMSw4MTkzODU2NzcsOTYx
MTUwMDUxXX0=
-->