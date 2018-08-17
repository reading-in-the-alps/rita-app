xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
import module namespace functx = "http://www.functx.com";
import module namespace util="http://exist-db.org/xquery/util";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace config="http://www.digital-archiv.at/ns/rita-app/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/rita-app/templates" at "../modules/app.xql";


let $refs := distinct-values(data(collection($app:editions)//tei:rs/@ref))
let $nomatch := 
<nomatch>
    {
        for $x in $refs
            let $id := substring-after($x, '#')
            let $match := collection($app:indices)//id($id)
            where not($match)
                return <item>
                            <origID>{$x}</origID>
                            <xmlID>{$id}</xmlID>
                        </item>
    }
</nomatch>
let $counter := count($nomatch//item)
return 
    <result>
        <mentionsNoIndexMatch>
            <amount>{$counter}</amount>
            {$nomatch}
        </mentionsNoIndexMatch>
    </result>
