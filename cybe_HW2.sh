#!/bin/bash

flag=1

while ((flag == 1)); do
string=""
        echo -e "Choose an option.\n1. Show password file with shadow password $

        read option

        if(($option == '1'))
                then
                echo -e "Please type alternate password file or press enter to $
                read password_file
                echo -e "Please type alternate shadow file or press enter to us$
                read shadow_file
                if((-z $password_file == 0))
                        then
                        while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
                        do
                                passhash=$(grep $f1 /etc/shadow)
                                IFS=':' read -a array <<< $passhash
                                string="$string$f1:${array[1]}:$f3:$f4:$f5:$f6:$
                        done <"/etc/passwd"
                        echo -e "User:Password Hash:UID:GID:User Name or Commen$
                        echo -e $string|less
                else
                        while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
                        do
                        passhash=$(grep $f1 /etc/shadow)
                                IFS=':' read -a array <<< $passhash
                                string="$string$f1:${array[1]}:$f3:$f4:$f5:$f6:$
                        done <"/etc/passwd"
                        echo -e "User:Password Hash:UID:GID:User Name or Commen$
                        echo -e $string|less
                else
                        while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
                        do
                                passhash=$(grep $f1 $shadow_file)
                                IFS=':' read -a array <<< $passhash
                                string="$string$f1$:{array[1]}:$f3:$f4:$f5:$f6:$
                        done <$password_file
                fi
        elif(($option == '2'))
                then
                echo "Please enter a user name."
                read user_name
                echo "Please enter a password."
                read -s password_hash
                echo "Please enter a group ID."
                read group_id
                echo "Enter a user name or comment."
                read comment_field
                echo "Enter an optional user command interpreter."
                read interpreter

                echo -e "$user_name:$(openssl passwd -1 $password_hash):1001:$g$
        elif(($option == '3'))
                then
                echo -e "Please type alternate password file or press enter to $
                read password_file
                echo -e "Please type alternate shadow file or press enter to us$
                read shadow_file
                if((-z $password_file == 0))
                        then
                        while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
                        do
                                if(($f3 == '0'))
                                        then
                                        passhash=$(grep $f1 /etc/shadow)
                                        IFS=':' read -a array <<< $passhash
                                        string="$string$f1:$f3:$f7:${array[1]}\$
                                fi

                        done <"/etc/passwd"
                        echo -e "User:UID:Shell:Password Hash\n"
                        echo -e $string|less
                else
                        while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
                        do
                              if(($f3 == '0'))
                                        then
                                        passhash=$(grep $f1 $shadow_file)
                                        IFS=':' read -a array <<< $passhash
                                        string3="$string$f1:$f3:$F7:${array[1]}$
                              fi
                        done <$password_file
                        echo -e "User:UID:Shell:Password Hash\n"
                        echo -e $string|less
                fi
        elif(($option == '4'))
                then
                echo -e "Please enter a UID lower bound."
                read lower_bound
                echo -e "Please enter a UID upper bound."
                read upper_bound
                while IFS=: read -r f1 f2 f3 f4 f5f6 f7
                do
                        if(($f3 >= $lower_bound && $f3 <= $upper_bound))
                                then
                                passhash=$(grep $f1 /etc/shadow)
                                IFS=':' read -a array <<< $passhash
                                passwd=${array[1]}
                                #if [ -n "$passwd" ] && [[ "$passwd" > "*" ]]
                                #       then
                                        string="$string$f1:$f3:$f7:${array[1]}\$
                                #fi
                        fi
                done <"/etc/passwd"
                echo -e "User:UID:Shell:Ecnrypted Password\n"
                echo -e $string|less

        elif(($option == '5'))
                then
                flag=2
        else
                echo
                echo Invalid input, please try again.
        fi
done
echo Done
