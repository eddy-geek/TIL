
* Apps can record custom metrics. See [Activity Recording](https://developer.garmin.com/connect-iq/core-topics/activity-recording/)
* There is no dedicated field for "Stroke rate" information in the [ActivityInfo](https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity/Info.html), it is saved under currentCadence (available Bike/Swim/Row/Paddla mode, not Kayak)
* There is a fit2csv conversion tool : `java -jar FitCSVTool.jar some.fit`
* Some Apps that try to improve rowing stroke rate metric: 
  * [Rowing](https://dyrts.fr/en/garmin-app/rowing/)
  * [Vaaka cadence](https://www.vaakacadence.com/) (with 200€ sensor)
