# Strava high-res heatmap

The [strava global heatmap](https://support.strava.com/hc/en-us/articles/216918877-Strava-Metro-and-the-Global-Heatmap) is very useful.

Strava only allows low resolution(z=13?) tile in public mode.
But since you have access to higher resolution (z=16) when logged in strava.com, the resulting session can be reused in common software.

A browser plugin allows to retrieve this session ([josm-strava-heatmap](https://github.com/zekefarwell/josm-strava-heatmap))
but going to dev tools to inspect network traffic works as well.

For AlpineQuest, this is the resulting *strava-heatmap-alpinequest.aqx* map definition file for `winter` mode:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<aqx version="11">

    <name>Strava Heatmap High-res with my cookie</name>
    <description>© Strava</description>

    <source id="MAP_UID" layer="true" opacity="80">
        <name>Strava Heatmap High-res</name>
        <zoom-levels z="1-16">
            <referer><![CDATA[https://www.strava.com/]]></referer>
            <user-agent>Mozilla/5.0</user-agent>
            <server><![CDATA[https://heatmap-external-b.strava.com/tiles-auth/winter/hot/{zoom}/{x}/{y}.png?Key-Pair-Id=yourkey&Policy=veryverylongstring]]></server>
        </zoom-levels>
    </source>
<!-- Put in the_folder/datastore/maps/ -->
</aqx>

```
