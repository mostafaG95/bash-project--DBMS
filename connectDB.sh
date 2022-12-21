echo "Enter Name of DB " 
read name
echo $name 
if [ -d $name ] ; then 
cd $name
select y in create_tables list_tables drop update insert Select
do
case $y in 
create_tables )
echo "enter table name : "
read table
touch $table
break
;;
list_tables )
echo "hello"
break
;;
drop )
echo "hello"
break
;;
update )
echo "hello"
break
;;
insert )
echo "hello"
break
;;
Select )
echo "hello"
break
;;
esac
done 
else 
echo "Sorry DataBase Not Exit "
fi