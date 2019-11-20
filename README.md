# rita

rita is a [dsebaseapp](https://github.com/KONDE-AT/dsebaseapp) based web application to publish XML/TEI encoded transcripts of inventories from 18th century Tyrol.
Transcriptions and application were created in the context of the FWF funded project ["Reading in the Alps"](https://pf.fwf.ac.at/de/wissenschaft-konkret/project-finder?search[what]=P+29329).

## install

The application's data is kept in a separate [git-repo rita2-data](https://github.com/reading-in-the-alps/rita2-data) and need to be included into the current repo via symlink, e.g. `ln -s ../rita2data/data data`
run `ant` in to build the application
install the package into eXist-db via eXist-dbs package manager
