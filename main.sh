#/usr/bin/bash
source create.sh
source connect.sh
source list.sh
source drop.sh
if [ -e ./Databases ];then
            cd Databases
        else
            mkdir Databases
            cd Databases
fi
select option in "createDB" "listDB" "ConnectDB" "DropDB" "Exit"
do
echo $option
case $option in 
createDB )
Create_database
;;                
listDB ) 
listing_Databases
;;
ConnectDB )
echo "Enter Name of DB "
read name
echo $name 
if [ -d $name ] ; then 
cd $name
select y in create_tables list_tables drop insert Select
do
case $y in 
create_tables )
create_table
break
;;
list_tables )
listing_tables
break
;;
drop )
drop_table
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
;;
DropDB ) 
droppingDataBase
;;                
Exit )
echo "breakkk" 
break
;;
esac
done

 
