How to Download offline maps?

- Follow http://randochartreuse.free.fr/mobac2.x/index.htm

Especially http://randochartreuse.free.fr/mobac2.x/mapsources/Suisse/

They currently list slope abpve 30 degrees, but not slope classes which are more useful. But the URLS actually come from SwissTopo [official APIs](https://api3.geo.admin.ch/services/sdiservices.html). In the [full list of layers](https://api3.geo.admin.ch/rest/services/api/MapServer), we find then around index 530/540:

```YAML
530
    attributes
        wmsUrlResource:	"https://wms.swisstopo.admin.ch/wss/httpauth/swisstopowms/"
        scaleLimit:	"-"
        inspireUpperAbstract:	"Surface representation"
        urlDetails:	"http://professionnels.ign.fr/rgealti#tab-1"
        bundCollectionNumber:	"41.6"
        inspireAbstract:	"Elevation"
        dataOwner:	"Federal Office of Topography swisstopo"
        abstract:	"Derivate representation of the digital terrain model swissALTI3D and models from France, Italy, Austria and Germany, which allows for the identification of inclinations over 30°. ..."
        wmsContactAbbreviation:	"swisstopo"
        maps:	"api,ech,geol,gewiss,inspire,kgs,schneesport,swisstopo,wms-swisstopowms"
        wmsContactName:	"Federal Office of Topography swisstopo"
        dataStatus:	"20160101"
        bundCollection:	"swissALTI3D"
        fullTextSearch:	"Slope classes over 30 de…of Topography swisstopo"
        inspireUpperName:	"Surface representation"
        inspireName:	"Elevation"
        urlApplication:	"https://map.geo.admin.ch/
            ?Y=645723.59&X=209000.00
            &zoom=1
            &bgLayer=ch.swisstopo.pixelkarte-farbe
            &time_current=latest
            &lang=de
            &topic=swisstopo
            &layers=ch.swisstopo.hangneigung-ueber_30
            &layers_opacity=0.75
            &catalogNodes=1459"
        idGeoCat:	"77f0637f-8d52-45bc-b824-d6e5719de55b"
        layerBodId:	"ch.swisstopo.hangneigung-ueber_30"
        fullName:	"Slope classes over 30 degrees"
        name:	"Slope classes over 30°"
540
    attributes:
        ...
        urlApplication:	"https://map.geo.admin.ch/
            ?topic=ech
            &lang=de
            &bgLayer=ch.swisstopo.pixelkarte-farbe
            &layers=ch.swisstopo.zeitreihen,ch.bfs.gebaeude_wohnungs_register,ch.bav.haltestellen-oev,ch.swisstopo.swisstlm3d-wanderwege,ch.swisstopo-karto.hangneigung
            &layers_visibility=false,false,false,false,true
            &layers_timestamp=18641231,,,,
            &layers_opacity=1,1,1,1,0.2"
    idGeoCat:	"c37cbfbf-0d87-4ae8-8c21-8932130eb3fa"
    layerBodId:	"ch.swisstopo-karto.hangneigung"
    fullName:	"Slope over 30 degrees"
    name:	"Slope over 30°"
```

So we replace in [Suisse_Pentes.bsh](http://randochartreuse.free.fr/mobac2.x/mapsources/Suisse/liaisons-new/Suisse_Pentes.bsh), `swisstlm3d-wanderwege` by `hangneigung-ueber_30`:
```java
	String MyFolder = "1.0.0/ch.swisstopo.hangneigung-ueber_30/default/current/3857";
```

