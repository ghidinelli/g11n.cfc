# g11n.cfc
A ColdFusion Component that helps with Globalization (g11n) - Internationalization (i18n) and Localization (l10n)

For a primery on Globalization with ColdFusion, check [https://gist.github.com/coldfusionPaul/3779416 this gist] from Paul Hastings (who knows a ton about g11n).

Some assumptions:

* Your content is in utf-8 and stored in the database as unicode
* You have `<cfprocessingdirective pageencoding="UTF-8"/>` everywhere
* You realize the built-in locale name and LS* functions are inadequate

Using g11n.cfc is easy:

```
g11n = createObject("component", "g11n").init(locale = "en_US", tzid = "US/Pacific");
writeOutput(g11n.getDateMask("short")); // M/d/yy h:mm a
writeOutput(g11n.formatDateTime(now(), "short")); // now() formatted as 'M/d/yy h:mm a' in Pacific time
writeOutput(g11n.formatCurrency(50000.50)); // $50,000.50
```

You can also pass the desired locale and timezone to most methods:

```
writeOutput(g11n.getDateMask(locale = "en_GB", mask = "short")); // dd/MM/yy HH:mm
writeOutput(g11n.formatCurrency(50000.50)); // £50.000,50
```
