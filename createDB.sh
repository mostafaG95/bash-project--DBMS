echo enter your database 
read database1
if [[ -e $database1 ]];then
echo "error file exist "
elif [[ $database1 =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]; then
mkdir -p database/$database1
else 
echo "error database begins with [a-z]"
fi