#!/usr/bin/env bash
sudo yum -y install jq
chk_res(){
 if [[ $? == "0" ]]
 then
    echo "Sucess $1"
 else
    echo "Failed $1"
    exit 1
 fi
}

if [[ $2 == "" ]]
then
 echo "input namespace"
 exit 1
else
 echo "default is default"
 NSPACE=$2
fi


if [[ $1 == "" ]]
then
 echo "input user"
 exit 1
fi

UNAME=$1


mkdir ./${UNAME}

echo "create user ${UNAME} key first 2048"
echo "openssl check"
c=$(which openssl)
echo $c

$c genrsa -out ${UNAME}/${UNAME}.key 2048
echo "create user ${UNAME} csr key first 2048"
$c req -new -key ${UNAME}/${UNAME}.key -out ${UNAME}/${UNAME}.csr -subj "/CN=$UNAME"

echo "Create ${UNAME}-csr.yaml for CertificateSigningRequest"
touch ${UNAME}/${UNAME}-csr.yaml

echo $?

echo "Get request value"
REQUEST_VALUE=$(cat ${UNAME}/${UNAME}.csr | base64 | tr -d "\n")
echo $REQUEST_VALUE

echo "REQUEST_VALUE CSR VALUE CREAETION SUCCESS VALUE : $?"
cat << 'EOF' > ${UNAME}/${UNAME}-csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: NAME-CSR
spec:
  groups:
  - system:authenticated
  request: REQUEST_TGRT
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - client auth
EOF

REPLACE_WITH_CSR=$(sed -i "s:REQUEST_TGRT:$REQUEST_VALUE:g" ${UNAME}/${UNAME}-csr.yaml)
REPLACE_NAME_CSR=$(sed -i "s:NAME-CSR:${UNAME}-csr:g" ${UNAME}/${UNAME}-csr.yaml)

K=$(which kubectl)
if [[ $K == "" ]]
then
  echo "KUBECTL NO EXIST FIRST INSTALL"
  exit 1
fi
echo $K
$K delete ${UNAME}.csr
$K apply -f ${UNAME}/${UNAME}-csr.yaml
chk_res ${UNAME}-csr.yaml
$K certificate approve ${UNAME}-csr
chk_res certificate_approve

touch ${UNAME}/${UNAME}.conf
GET_AUTH_DATA=$($K config view --raw --flatten -o json | jq -r '.clusters[0].cluster."certificate-authority-data"')
echo $GET_AUTH_DATA
GET_SERVER_DATA=$($K config view --raw --flatten -o json | jq -r '.clusters[0].cluster.server')
echo "get server data: $GET_SERVER_DATA"
SERVER_DATA=$(echo $GET_SERVER_DATA | sed 's://:\\/\\/:g')
echo $SERVER_DATA
GET_CERT_DATA=$($K get csr ${UNAME}-csr -o jsonpath='{.status.certificate}')
echo $GET_CERT_DATA
GET_CLIENT_KEY_DATA=$(cat ${UNAME}/${UNAME}.key | base64 | tr -d '\n')
echo $GET_CLIENT_KEY_DATA

cat << 'EOF' > ${UNAME}/${UNAME}.conf
apiVersion: v1
kind: Config
clusters:
- name: noname_cluster
  cluster:
    certificate-authority-data: CAUTHD
    server: SERD
contexts:
- name: UNAME-CONTEXT
  context:
    cluster: noname_cluster
    namespace: NSPACE
    user: UNAME
current-context: UNAME-CONTEXT
users:
- name: UNAME
  user:
    client-certificate-data: CCD
    client-key-data: CKD
EOF

REPLACE_UNAME=$(sed -i "s:CAUTHD:$GET_AUTH_DATA:g" ${UNAME}/${UNAME}.conf)
REPLACE_SERVER_DATA=$(sed -i "s/SERD/$SERVER_DATA/g" ${UNAME}/${UNAME}.conf)
REPLACE_NAME_CONTEXT=$(sed -i "s:UNAME-CONTEXT:$UNAME-context:g" ${UNAME}/${UNAME}.conf)
REPLACE_NAME=$(sed -i "s:UNAME:$UNAME:g" ${UNAME}/${UNAME}.conf)
REPLACE_NSPACE=$(sed -i "s:NSPACE:$NSPACE:g" ${UNAME}/${UNAME}.conf)
REPLACE_CERT_DATA=$(sed -i "s:CCD:$GET_CERT_DATA:g" ${UNAME}/${UNAME}.conf)
REPLACE_CLIENT_KEY_DATA=$(sed -i "s:CKD:$GET_CLIENT_KEY_DATA:g" ${UNAME}/${UNAME}.conf)

GRP=$UNAME
HOMEDIR="/home"
echo "Mkdir $UNAME .kube directory"
sudo su - $UNAME -c "mkdir $HOMEDIR/$UNAME/.kube"
sudo su - $UNAME -c "ls -l $HOMEDIR/$UNAME/.kube"
sudo cp -pfv $UNAME/$UNAME.conf $HOMEDIR/$UNAME/.kube/config
sudo chown -R $UNAME:$GRP $HOMEDIR/$UNAME/.kube
sudo chmod 600  $HOMEDIR/$UNAME/.kube/config
sudo ls -l $HOMEDIR/$UNAME/.kube/config

cat << 'EOF' > ${UNAME}/${UNAME}-role.yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: NSPACE
  name: ROLENAME
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
EOF

REPLACE_NSPACE=$(sed -i "s:NSPACE:$NSPACE:g" ${UNAME}/${UNAME}-role.yaml)
$(sed -i "s/ROLENAME/$NSPACE\-full\-access\-role/g" ${UNAME}/${UNAME}-role.yaml)
$K apply -f ${UNAME}/${UNAME}-role.yaml


cat << 'EOF' > ${UNAME}/${UNAME}-RoleBinding.yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: RBNAME
  namespace: NSPACE
subjects:
- kind: User
  name: UNAME
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: ROLENAME
  apiGroup: rbac.authorization.k8s.io
EOF

sed -i "s:NSPACE:$NSPACE:g" ${UNAME}/${UNAME}-RoleBinding.yaml
sed -i "s:UNAME:$UNAME:g" ${UNAME}/${UNAME}-RoleBinding.yaml
sed -i "s/ROLENAME/$NSPACE\-full\-access\-role/g" ${UNAME}/${UNAME}-RoleBinding.yaml
sed -i "s/RBNAME/$NSPACE\-full\-access\-role\-binding/g" ${UNAME}/${UNAME}-RoleBinding.yaml


$K apply -f ${UNAME}/${UNAME}-RoleBinding.yaml
sudo su - ${UNAME} -c "kubectl get all -n $NSPACE"
