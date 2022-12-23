function droppingDataBase()
{
echo enter the name of the DataBase to Delete
read DBName
if [ -d $DBName ];then
  rm -r $DBName
  echo DataBase Deleted successfuly.
else
  echo DataBase not existed
fi
}
