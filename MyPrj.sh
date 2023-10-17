#Number Guessing
Game1()
{
	guess=$(($RANDOM %100))

	attempts=10
	#i=0
	repeat()
	{
		echo -e "\033[1;34m\033[1m Want to play again..?(Y/N)\033[0m"
		read play
			if  [ "$play" == "Y" ] || [ "$play"  == "y" ]
			then
				Game1
			else
				start
			fi	
	}
	echo -e "\n\t\t\033[1;34m\033[1m---------------*** WELCOME in Number Guessing Game ***---------------\033[0m\n\n"
	echo -e "\t\t\033[0;34mYou have to guess a number between 0 and 100 ,including 0 and 100"
	echo -e "\t\tYou will get 10 choices\033[0m\n"
	echo -e "\t\t\t\t\033[0;34m\033[1m *** Good Luck! ***\033[0m\n"
	
	for (( i=0;i<$attempts;i++ )) 
	do 
		#rem='echo $attempts - $i | bc'
		rem=$((attempts - i))
		echo -e "\033[1;31m \033[1m $rem \033[0m \033[0;31m atttempts are remaining\033[0m"
		echo -e "Enter Number:"
		read input
			
		if [ $input -lt  $guess  ]; then
			echo -e "\033[0;32m\033[1mToo small\033[0m\n"
		 
		elif [ $input -gt $guess ]; then
			echo -e  "\033[0;32m\033[1mToo big\033[0m\n"

		elif [ $input -eq $guess ]; then
			echo -e "\n\n"
			echo "***********************************"
			echo "   Congratulations Correct guess"
			echo "***********************************"
			echo -e "\033[1;31m\tThe secret number was $guess\n You guessed the secret number in \033[1m $i attempts\n\n"
			repeat
		fi
	done 

	if [ $input != $guess ]
	then

	echo "******************************************"
	echo "   Sorry.. The correct number was $guess"
	echo "******************************************"
	repeat	
			
	fi
}

#Snake Game
Game2()
{
	height=25; width=25;
	gover=0;x=0;y=0;f_x=0;f_y=0
	Boundry()
	{
		clear
		i=0
		while [ $i -le $height ]
		do
			j=0
			while [  $j -le $width ]
			do
				if [ $i -eq 0 ] || [ $i -eq $width ] || [ $j -eq 0 ] || [ $j -eq $height ];
				then 
					echo -n "#"
				else
					if [ $i -eq $x ] && [ $j -eq $y ] ;
					then
						echo  -ne "\033[1;32m\033[1m*\033[0m"
					elif [ $i -eq $f_x ] && [ $j -eq $f_y ];
					then
						echo  -ne "\033[0;31m\033[1m@\033[0m"
					else
						echo -n " "
					fi
				fi
				
				j=$((j + 1))
			done
			
			i=$((i + 1))
			echo 
		done
		echo -e "\n\t\033[0;31m\033[1mScore=\033[1;31m$score \033[0m"
		echo -e "\tPress \033[1m'X' \033[0m to quit the game"
	}


		fx_pos()
		{
			f_x=$(($RANDOM % 24))
			if [ $f_x -eq 0 ];
			then
				fx_pos
			fi
		}

		fy_pos()
		{
			f_y=$(($RANDOM % 24))
			if [ $f_y -eq 0 ];
			then
				fy_pos
			fi
		}		
	setup()
	{	gover=0
		x=$(( height / 2 )) 
		y=$(( width / 2 ))
		fx_pos
		fy_pos
		score=0
	}


	logic()
	{
		stop()
		{
				echo -e "\033[1;31m\033[1m\n\tGAME OVER! You hit a wall!\n"
				echo -e "\e[47m\033[1m Your score is: \033[1;31m$score\e[0m"
				echo -e "\033[1;34m\033[1m Want to play again..?(Y/N)\033[0m"
				read play
				if  [ "$play" == "Y" ] || [ "$play"  == "y" ]
				then
					exe
				else
					start
				fi
		}
		

		sleep 1	
		while true
		do
			read -sn1 key
			case $key in 
			w|W)
				x=$((x - 1))
				#echo "$key id pressed"
			;;
			s |S)
				x=$((x + 1))
			;;
			a | A)
				y=$((y - 1))
			;;
			d|D)
				y=$((y + 1))
			;;
			x|X) 
				gover=1;;
			esac
			
			if [ $x -eq $f_x ] && [ $y -eq $f_y ];
			then
				fx_pos
				fy_pos
				score=$((score + 10))
			fi	
			
			if [ $gover -eq 1 ]
			then
				echo -e "\n\n\033[1m\e[47m Your score is: \033[1;31m$score\e[0m"
				sleep 
				start
				
			elif  [ $x -lt 1 ] || [ $x -gt $((width -1)) ] || [ $y -lt 1 ] || [ $y -gt $((height - 1)) ] ; then
				stop 
			else
				Boundry
				logic
			fi
				
		done
	}

	exe()
	{
		clear
		echo -e "\033[0;31m\033[1m
		Keys:\033[0m

		 W - UP
		 S - DOWN
		 A - LEFT
		 D - RIGHT
		 X - QUIT"
		 sleep 5
			setup 
			
		while [ $gover -eq 0 ]
		do
			Boundry
			logic
		done  		
	}
	exe
}	


#Tic-tac-toe
Game3()
{
	clear
	play()
	{
		echo -e "\n\t\t\033[1;34m\033[1m---------------*** Tic-tac-toe ***---------------\033[0m\n\n"
		echo -e "Choose a cell number from 1 to 9 as given below and play:\n\n"
		echo -e "\t\t\t 1 | 2 | 3 "
		echo -e "\t\t\t-----------"
		echo -e "\t\t\t 4 | 5 | 6 "
		echo -e "\t\t\t-----------"
		echo -e "\t\t\t 7 | 8 | 9 "
		echo -e "\t-\t-\t-\t-\t-\t-\t-\t-\n\n"
		
		#c1=" "; c2=" "; c3=" "; c4=" "; c5=" "; c6=" "; c7=" "; c8=" "; c9=" ";
		declare -a c
		for  ((i=1; i<=9; i++))
		{
			c[$i]=" "
		}
		
		
		winner()
		{
			echo -e  "\n\e[46m\n"
			echo -e  "\e[0m\n\e[34m\e[1m\n\tCongratulations\e[31m $turn...\e[34m\e[1m You win the game ";
			echo -e  "\e[32m\e[1m\n\nwant to play again..??(y/n)"
			read p
			if [ $p == "y" ] || [ $p == "Y" ];then
				Game3
			else
				start
			fi
		}
		
		
		showboard()
		{
			echo -e "\t\t\t\e[31m\e[1m ${c[1]} \e[0m|\e[31m\e[1m ${c[2]} \e[0m|\e[31m\e[1m ${c[3]} \e[0m"
			echo -e "\t\t\t-----------"
			echo -e "\t\t\t\e[31m\e[1m ${c[4]} \e[0m|\e[31m\e[1m ${c[5]} \e[0m|\e[31m\e[1m ${c[6]} \e[0m"
			echo -e "\t\t\t-----------"
			echo -e "\t\t\t\e[31m\e[1m ${c[7]} \e[0m|\e[31m\e[1m ${c[8]} \e[0m|\e[31m\e[1m ${c[9]} \e[0m"
		}
		
		count=0
				
		begin()
		{
			showboard
			if [ $turn == $player1 ]
			then
				insert="X"
			else
				insert="O"
			fi
			
			getagain()
			{
				getCell()
				{
					echo -e "\n\t\e[34m\e[1m$turn \e[0menter respetive cell number to insert $insert:\e[1m";
					echo -ne "\t" 
					read cell
				}
				
				getCell
				
				if [[ $cell -lt 1 ]] || [[ $cell -gt 9 ]] 
				then 
					echo -e "\e[31m Cell number can't be other than 1 to 9:\e[0m"
					getagain
					
				elif [ "${c[cell]}" != " " ]
				then
					echo -e "\n\e[31m\e[1mPosition is already filled!!... Please enter valid position.\e[0m\n\n"
					getagain
					
				elif [ "${c[cell]}" == " " ];
				then
					c[cell]=$insert
					count=$((count + 1))
					
					
					if [[ "${c[1]}" == "$insert" ]] && [[ "${c[2]}" == "$insert" ]] && [[ "${c[3]}" == "$insert" ]];
					then
						showboard
						winner
					elif [[ "${c[4]}" == "$insert" ]] && [[ "${c[5]}" == "$insert" ]] && [[ "${c[6]}" == "$insert" ]];then
						showboard
						winner
					elif [[ "${c[7]}" == "$insert" ]] && [[ "${c[8]}" == "$insert" ]] && [[ "${c[9]}" == "$insert" ]];then
						showboard
						winner
					elif [[ "${c[1]}" == "$insert" ]] && [[ "${c[4]}" == "$insert" ]] && [[ "${c[7]}" == "$insert" ]];then
						showboard
						winner
					elif [[ "${c[2]}" == "$insert" ]] && [[ "${c[5]}" == "$insert" ]] && [[ "${c[8]}" == "$insert" ]];then
						showboard
						winner
					elif [[ "${c[3]}" == "$insert" ]] && [[ "${c[6]}" == "$insert" ]] && [[ "${c[9]}" == "$insert" ]] ;then
						showboard
						winner
					elif [[ "${c[1]}" == "$insert" ]] && [[ "${c[5]}" == "$insert" ]] && [[ "${c[9]}" == "$insert" ]];then
						showboard
						winner
					elif [[ "${c[3]}" == "$insert" ]] && [[ "${c[5]}" == "$insert" ]] && [[ "${c[7]}" == "$insert" ]];
					then
						showboard
						winner
					else
						echo
					fi
					if [ $count  -eq 9 ]
					then
						echo -e "\n\n\e[31m\e[1mIt's a draw!!\e[0m"
						echo -e  "\n\e[32m\e[1m\n\nwant to play again..??(y/n)"
						read p
						if [ $p == "y" ] || [ $p == "Y" ];then
							Game3
						else
							start
						fi
					fi
				
					if [ "$turn" == "$player1" ]
					then
						turn=$player2
					else
						turn=$player1
					fi
					
					begin
				
				else
					echo 
				fi
			
			}
			getagain
			
		}
		begin
	}
	
	echo -e "\n\t\t\033[1;34m\033[1m---------------*** welcome ***------------\033[0m\n\n"
	
	echo -ne "Enter name  of Player-1:\033[1m"
	read player1
	echo -ne "\n\033[0mEnter name of Player-2:\033[1m"
	read player2
	
	toss=$(($RANDOM % 100))
		
			if [ $toss -lt 50 ];then
				echo -e "\n\n\e[1m\e[47m\tCongratulations $player1 \n\e[0m\e[1m\e[31m you win the toss"
				turn=$player1
			else
				echo -e "\n\n\e[1m\e[47m\tCongratulations $player2 \n\e[0m\e[1m\e[31m you win the toss"
				turn=$player2
			fi
	
	play
	
}

Game_Studio()
{
	clear
	echo -e "\n\t\t\t\t\033[0;34m\033[1m.....................***** \e[31mWELCOME\e[0m\033[0;34m\033[1m *****.....................\033[0m\n\n"
	sleep 3
	start()
	{
	    clear
	    echo -e "\n\n\n\t========================================================="
	    echo -e "\t=\t\t\t\t\t\t\t="
	    echo -e "\t=\t\t\033[0;31m\033[1m****** Game Studio ******\033[0m\t\t="
	    echo -e "\t=\t\t\t\t\t\t\t="
	    echo -e "\t=\t\t\t\t\t\t\t="
	    echo -e "\t=\t1. Number Guessing Game\t\t\t\t="    
	    echo -e "\t=\t2. Snake Game          \t\t\t\t="  
	    echo -e "\t=\t3. Tic-tac-toe Game    \t\t\t\t=" 
	    echo -e "\t=\t4. Exit from Game Studio \t\t\t=" 
	    echo -e "\t=\t\t\t\t\t\t\t="
	    echo -e "\t@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n\n" 
	    

	    echo -e "\033[1;34m Which game  you want to play (1/2/3/4)\033[0m ?"
	    read choice
	    
	    case $choice in
		1) clear
		   Game1
		  
		;;
		2) clear
		   Game2
		;;
		3) clear
		   Game3
		;;
		4) exit
		;;
		esac
		
	}
    
    start   
}
Game_Studio
