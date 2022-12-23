function Create_database()
{
    
    echo "please enter Database name : "
    read name
    while [[ ! $name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]]
        do
         echo "pleas enter a valid name"
         read name
        done

    while :
    do
        if [ -e $name ];then
            echo "This name is already taken"
            read name
        else
        mkdir ./$name
        cd ../ 
        . ./main.sh
        break
        fi
    done

}
