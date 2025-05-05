#!/usr/bin/env bash
set -eu

# egrep это grep -E
# egrep считается устаревшим, лучше grep -E
# grep -P (perl) это то, к чему я привык
# grep -E (extended) тоже мощный, но нет \w, \d, \s, (?=...), (?<=...), \b, \B

# egrep --help
# exit 0

header_with_ids='X-MiniProfiler-Ids: 8jpx3fmioa5quj0erro8,g4xy3bt4kx0clmogkldv,nqpfyy0yf80ksph3cbid,fceqkzw7s3znr51qoo3n,1tkggm0qijalf9eokt0m,zwr5d0jgrhpc4lxgyclh,mhseb9yqzcmnd9lua7ug,xls8rgqixqnsmedo7tj0,7xdpffwyh39zpy52vl1l,is7zes14jb4li7xew2kf,k12acq5fqe9y7ifn9v1y,mwgw4ehrvi6rkyst2qbp,3jb7yosa8df17egi8kha,x0afbbmkvcju5dmiv5k'
first_id=$(echo $header_with_ids | grep -oP '(?<=X-MiniProfiler-Ids:\s)\S+' | tr ',' '\n' | head -n1)
echo -e '$first_id: ' $first_id
