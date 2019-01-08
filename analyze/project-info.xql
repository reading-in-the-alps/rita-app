xquery version "3.1";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";
import module namespace app="http://www.digital-archiv.at/ns/rita/templates" at "../modules/app.xql";
import module namespace config="http://www.digital-archiv.at/ns/rita/config" at "modules/config.xqm";
declare option exist:serialize "method=json media-type=text/javascript content-type=application/json";


let $description := doc(concat($config:app-root, "/repo.xml"))//repo:description/text()
let $authors := normalize-space(string-join(doc(concat($config:app-root, "/repo.xml"))//repo:author//text(), ', '))
let $map := map{
    "title": "Reading in the Alps",
    "subtitle": "Private book ownership in the Catholically dominated Central Alps 1750–1800. A systematic study based on inventories from the Tyrolean Pustertal and Stubaital",
    "author": "Michael Span, Michael Prokosch, Peter Andorfer",
    "description": "The project aims at investigating private book ownership in the Catholically dominated rural areas of the Central Alps, or, putting it more precisely, in historic Tyrol in the 18th century. Referring to comparable existing studies – for example by Hans Medick – mainly focusing on protestant-pietistic regions, this study investigates inventories. Books mentioned in about 2,200 inventories from the Pustertal/Val di Pusteria, today belonging to South-Tyrol (Südtirol/Alto Adige), Italy, and Stubaital will be gathered in order to describe and systematically analyse private book ownership in the respective administrative districts.",
    "github": "https://github.com/reading-in-the-alps/rita-app",
    "purpose_de": "Ziel von Reading in the Alps ist die Publikation von Forschungsdaten.",
    "purpose_en": "The purpose of Reading in the Alps is the publication of research data.",
    "app_type": "digital-edition",
    "base_tech": "eXist-db",
    "framework": "Digital Scholarly Editions Base Application"
}
return 
        $map