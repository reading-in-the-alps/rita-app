xquery version "3.0";
import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/templates" at "modules/app.xql";
import module namespace netvis="https://digital-archiv/ns/netvis" at "netvis/netvis.xqm";
import module namespace enrich="http://www.digital-archiv.at/ns/enrich" at "modules/enrich.xql";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

(: grant general execution rights to all scripts in analyze and modules collection :)
for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/analyze/"))
    return sm:chmod(xs:anyURI($config:app-root||'/analyze/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/modules/"))
    return sm:chmod(xs:anyURI($config:app-root||'/modules/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/ac/"))
    return sm:chmod(xs:anyURI($config:app-root||'/ac/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/netvis/"))
    return sm:chmod(xs:anyURI($config:app-root||'/netvis/'||$resource), "rwxrwxr-x"),

enrich:add_base_and_xmlid('https://id.acdh.oeaw.ac.at/rita/', 'editions'),


for $x in collection($app:editions)//tei:TEI
    let $removeBack := update delete $x//tei:back
    let $persons := distinct-values(data($x//tei:rs[@type="person" and not(@ref="#person_")]/@ref))
    let $listperson :=
    <listPerson xmlns="http://www.tei-c.org/ns/1.0">
        {
        for $y in $persons
        return
        collection($app:indices)//id(substring-after($y, '#'))
        }
    </listPerson>

    let $places := distinct-values(data($x//tei:rs[@type="place"]/@ref))
    let $listplace :=
    <listPlace xmlns="http://www.tei-c.org/ns/1.0">
        {
        for $y in $places
        return
        collection($app:indices)//id(substring-after($y, '#'))
        }
    </listPlace>
    let $bibls := distinct-values(data($x//tei:rs[@type="bibl"]/@ref))
    let $listbibl :=
    <listBibl xmlns="http://www.tei-c.org/ns/1.0">
        {
        for $y in $bibls
        return
        collection($app:indices)//id(substring-after($y, '#'))
        }
    </listBibl>

    let $validlistperson := if ($listperson/tei:person) then $listperson else ()
    let $validlistplace := if ($listplace/tei:place) then $listplace else ()
    let $validlistbibl := if ($listbibl/tei:bibl) then $listbibl else ()

    let $back :=
    <back xmlns="http://www.tei-c.org/ns/1.0">
        {$validlistperson}
        {$validlistplace}
        {$validlistbibl}
    </back>

    let $update := update insert $back into $x/tei:text

    return "done"
