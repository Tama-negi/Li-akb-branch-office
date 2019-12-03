#参考URL
#https://centossrv.com/clamav.shtml

# 1)パッケージインストール

yum install -y epel-release
yum -y install clamav clamav-server-systemd clamav-update clamav-scanner-systemd

# 2)設定ファイルの編集

ウイルス定義ファイル更新設定ファイル編集

cp -p /etc/freshclam.conf /etc/freshclam.conf.`date "+%Y%m%d"`
sed -i -e "s/^Example/#Example/g" /etc/freshclam.conf
sed -i -e "s/^#NotifyClamd \/path\/to\/clamd.conf/NotifyClamd \/etc\/clamd.d\/scan.conf/g" /etc/freshclam.conf

# 3)Proxy経由でアクセスする場合はこちらを実施する。

sed -i -e "s/^#HTTPProxyServer myproxy.com/HTTPProxyServer akbwg-proxy/g" /etc/freshclam.conf
sed -i -e "s/^#HTTPProxyPort 1234/HTTPProxyPort 8080/g" /etc/freshclam.conf

# 4)ウイルス定義ファイル自動更新設定ファイル編集

cp -p /etc/sysconfig/freshclam /etc/sysconfig/freshclam.`date "+%Y%m%d"`
sed -i -e "s/^FRESHCLAM_DELAY=/#FRESHCLAM_DELAY=/g" /etc/sysconfig/freshclam

# 5)Clam AntiVirus設定ファイル編集

cp -p /etc/clamd.d/scan.conf /etc/clamd.d/scan.conf.`date "+%Y%m%d"`
sed -i -e "s/^Example/#Example/g" /etc/clamd.d/scan.conf
sed -i -e "s/^User clamscan/#User clamscan/g" /etc/clamd.d/scan.conf
sed -i -e "s/^#LocalSocket/LocalSocket/g" /etc/clamd.d/scan.conf

# 6)ウイルス定義ファイル更新
freshclam

#7)Clam AntiVirus起動
cp -p /lib/systemd/system/clamd@.service /lib/systemd/system/clamd@.service.`date "+%Y%m%d"`
echo "TimeoutSec=5min" >> /lib/systemd/system/clamd@.service

#8）サービス再起動
systemctl daemon-reload
systemctl enable clamd@scan
systemctl start clamd@scan

#9)定期実行ファイルを作成する。

cat << 'EOF' > /etc/cron.daily/clamdscan
# 設定ファイル
CONFIG=/etc/clamd.d/scan.conf

# スキャン実行
# ※ウイルス検知時は隔離ディレクトリへ隔離
CLAMSCANLOG=`mktemp`
QUARANTINEDIR=/tmp/clamdscan-quarantinedir-$(date +%Y%m%d)
mkdir -p ${QUARANTINEDIR}
clamdscan -c ${CONFIG} --move=${QUARANTINEDIR} / > ${CLAMSCANLOG} 2>&1

# ウイルス検知時のみroot宛にメール通知
if [ -z "$(grep FOUND$ ${CLAMSCANLOG})" ]; then
    rm -rf ${QUARANTINEDIR}
else
    grep -A 1 FOUND$ ${CLAMSCANLOG} | mail -s "Virus Found in `hostname` => ${QUARANTINEDIR}" root
fi

# スキャンログをシスログに出力
cat ${CLAMSCANLOG} | logger -t $(basename ${0})
rm -f ${CLAMSCANLOG}
EOF

chmod +x /etc/cron.daily/clamdscan

#除外ディレクトリを追加する。
echo ExcludePath ^/tmp/clamdscan-quarantinedir-.*/ >> /etc/clamd.d/scan.conf
echo ExcludePath ^/proc/ >> /etc/clamd.d/scan.conf
echo ExcludePath ^/sys/ >> /etc/clamd.d/scan.conf


