# CallsForService

Scrapes, caches, and reaps records from http://www.slmpd.org/cfs.aspx

Does a little data massaging. Standardized timestamps, geocoding locations via google.

Scraping runs every two minutes and reaping runs every hour. Calling of each task is handled by the `:cron` app.

