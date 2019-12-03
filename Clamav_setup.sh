#�Q�lURL
#https://centossrv.com/clamav.shtml

# 1)�p�b�P�[�W�C���X�g�[��

yum install -y epel-release
yum -y install clamav clamav-server-systemd clamav-update clamav-scanner-systemd

# 2)�ݒ�t�@�C���̕ҏW

�E�C���X��`�t�@�C���X�V�ݒ�t�@�C���ҏW

cp -p /etc/freshclam.conf /etc/freshclam.conf.`date "+%Y%m%d"`
sed -i -e "s/^Example/#Example/g" /etc/freshclam.conf
sed -i -e "s/^#NotifyClamd \/path\/to\/clamd.conf/NotifyClamd \/etc\/clamd.d\/scan.conf/g" /etc/freshclam.conf

# 3)Proxy�o�R�ŃA�N�Z�X����ꍇ�͂���������{����B

sed -i -e "s/^#HTTPProxyServer myproxy.com/HTTPProxyServer akbwg-proxy/g" /etc/freshclam.conf
sed -i -e "s/^#HTTPProxyPort 1234/HTTPProxyPort 8080/g" /etc/freshclam.conf

# 4)�E�C���X��`�t�@�C�������X�V�ݒ�t�@�C���ҏW

cp -p /etc/sysconfig/freshclam /etc/sysconfig/freshclam.`date "+%Y%m%d"`
sed -i -e "s/^FRESHCLAM_DELAY=/#FRESHCLAM_DELAY=/g" /etc/sysconfig/freshclam

# 5)Clam AntiVirus�ݒ�t�@�C���ҏW

cp -p /etc/clamd.d/scan.conf /etc/clamd.d/scan.conf.`date "+%Y%m%d"`
sed -i -e "s/^Example/#Example/g" /etc/clamd.d/scan.conf
sed -i -e "s/^User clamscan/#User clamscan/g" /etc/clamd.d/scan.conf
sed -i -e "s/^#LocalSocket/LocalSocket/g" /etc/clamd.d/scan.conf

# 6)�E�C���X��`�t�@�C���X�V
freshclam

#7)Clam AntiVirus�N��
cp -p /lib/systemd/system/clamd@.service /lib/systemd/system/clamd@.service.`date "+%Y%m%d"`
echo "TimeoutSec=5min" >> /lib/systemd/system/clamd@.service

#8�j�T�[�r�X�ċN��
systemctl daemon-reload
systemctl enable clamd@scan
systemctl start clamd@scan

#9)������s�t�@�C�����쐬����B

cat << 'EOF' > /etc/cron.daily/clamdscan
# �ݒ�t�@�C��
CONFIG=/etc/clamd.d/scan.conf

# �X�L�������s
# ���E�C���X���m���͊u���f�B���N�g���֊u��
CLAMSCANLOG=`mktemp`
QUARANTINEDIR=/tmp/clamdscan-quarantinedir-$(date +%Y%m%d)
mkdir -p ${QUARANTINEDIR}
clamdscan -c ${CONFIG} --move=${QUARANTINEDIR} / > ${CLAMSCANLOG} 2>&1

# �E�C���X���m���̂�root���Ƀ��[���ʒm
if [ -z "$(grep FOUND$ ${CLAMSCANLOG})" ]; then
    rm -rf ${QUARANTINEDIR}
else
    grep -A 1 FOUND$ ${CLAMSCANLOG} | mail -s "Virus Found in `hostname` => ${QUARANTINEDIR}" root
fi

# �X�L�������O���V�X���O�ɏo��
cat ${CLAMSCANLOG} | logger -t $(basename ${0})
rm -f ${CLAMSCANLOG}
EOF

chmod +x /etc/cron.daily/clamdscan

#���O�f�B���N�g����ǉ�����B
echo ExcludePath ^/tmp/clamdscan-quarantinedir-.*/ >> /etc/clamd.d/scan.conf
echo ExcludePath ^/proc/ >> /etc/clamd.d/scan.conf
echo ExcludePath ^/sys/ >> /etc/clamd.d/scan.conf


