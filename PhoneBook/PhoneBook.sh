#!/bin/bash



export PhoneBOOK=PhoneBook.txt

function DisplayMenu {

    echo
    echo "Welcome to PhoneBook"
    echo "----------------------"
    echo
    echo "[-i] -->  Insert New Contact"
    echo "[-v] -->  View Saved Contact"
    echo "[-s] -->  Search For Contact"
    echo "[-e] -->  Delete All Contact"
    echo "[-d] -->  Delete One Contact"
    echo

}


function NewContact {

    clear
    #read new name from the user
    read -p "Please enter the contact name: " newName

    #Check if file exit Phonebook.txt
    if test -f $PhoneBOOK; then

        if grep -qi $newName $PhoneBOOK ; then

            echo "The name Already exist"
        
        else
            #read new number from the user
            read -p "Please enter the phone Number: " NewNumber

            #print the new name and phone in the file 'PhoneBook.txt'
            echo -e "$newName\t$NewNumber" >> $PhoneBOOK

        fi

    else
        
        touch $PhoneBOOK

        #read new number from the user
        read -p "Please enter the phone Number: " NewNumber

        #print the new name and phone in the file 'PhoneBook.txt'
        echo -e "$newName\t$NewNumber" > $PhoneBOOK
        
    fi   
}

function ShowContact {

    #Check if the file is empty
    if test -s $PhoneBOOK; then
    
        clear
        echo -e "Name\tNumber"
        echo "---------------"
        #display file contents
        cat $PhoneBOOK;
    
    else

        echo "File is Empty"
    
    fi

}

function SearchContact {

    #Check if the file is empty or not
    if test -s $PhoneBOOK; then
    

        clear
        read -p "Please enter the name: " NameSearch
        clear
        
        #Check if name exist
        if grep -q $NameSearch $PhoneBOOK; then
        
            echo "---------------"
            echo -e "Name\tNumber"
            grep $NameSearch $PhoneBOOK

        else

            echo "Name does not exist"

        fi
    
    else

        echo "File is Empty"

    fi

}

function DeleteContact {

    #Check if the file is empty or not
    if test -s $PhoneBOOK; then
    

        clear
        read -p "Please enter the name: " NameDelete
        clear
        
        #Check if name exist
        if grep -q $NameDelete $PhoneBOOK; then
        
            sed -i "/$NameDelete/d" $PhoneBOOK
            echo -e "$NameDelete is deleted from the list"

        else

            echo "Name does not exist"

        fi
    
    else

        echo "File is Empty"

    fi

}


function DeleteAll {

    if test -f $PhoneBOOK; then

        read -p "Are you sure you want to delete the file (Y or N): " Answer

        clear

        if [ $Answer == Y ] ; then

            echo "" > $PhoneBOOK
            echo "PhoneBook is empty"
        
        else
            
            echo "The file is not deleted"

        fi

    else
        
        echo "No file with this name --> $PhoneBOOK "
        
    fi   

}


case $1 in
-i)

    NewContact;;

-v)

    ShowContact;;

-s)

    SearchContact;;


-e)

    DeleteAll;;

-d)

    DeleteContact;;

*)

    DisplayMenu;;


esac


