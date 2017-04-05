declare function local:update-ref($ref){
let $target := $ref/@target
let $s := 
    for $r in collection('/db/apps/e-gedsh-data/data')//tei:idno[@type='URI'][. = $target]
    let $sib := $r/following-sibling::tei:idno[@type='subject']
    return $sib
let $type := tokenize(substring-after($s,'http://syriaca.org/'),'/')[1]
let $newRef := 
    <ref xmlns="http://www.tei-c.org/ns/1.0" rend="bold" target="{$target}">
        {
            if($type = 'place') then 
                <placeName xmlns="http://www.tei-c.org/ns/1.0" ref="{$s}">{$ref/node()}</placeName>
            else if($type='person') then 
                <persName xmlns="http://www.tei-c.org/ns/1.0" ref="{$s}">{$ref/node()}</persName>
            else $ref/node()        
        }
    </ref>
return $newRef
};

for $ref in collection('/db/apps/e-gedsh-data/data')//tei:ref[@target[starts-with(.,'http://gedsh.bethmardutho.org/') and not(contains(., '/fig/'))]]
let $target := $ref/@target
return 
    update replace $ref with local:update-ref($ref)
