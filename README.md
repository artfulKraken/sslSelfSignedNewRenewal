# Create and Renew Selfsigned SSL script
Script creates new ssl cert and key if one does not exist, or renews if existing cert expires in 30 days or less

Update `certDir` with directory you want cert and key
update `certName` with name of cert
update `keyName` with name of key

update cert info variables if you want identifying information in cert, or leave blank
- `country=""`
- `state=""`
- `region=""`
- `company=""`
- `department=""`
- `email=""`

create cron job to run this script daily
